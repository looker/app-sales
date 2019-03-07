include: "account_core.view.lkml"

explore: account_core {
  extension: required
  view_name: account
  sql_always_where: NOT ${account.is_deleted}
    ;;
  fields: [ALL_FIELDS*, -account_owner.user_exclude_set*, -creator.user_exclude_set*, -opportunity.opportunity_exclude_set*]

  join: sf_opportunity_facts {
    sql_on: ${account.id} = ${sf_opportunity_facts.account_id}  ;;
    relationship: one_to_one
  }

  join: contact {
    sql_on: ${account.id} = ${contact.account_id} ;;
    relationship: one_to_many
  }

  join: creator {
    from: user
    sql_on: ${contact.created_by_id} = ${creator.id} ;;
    relationship: many_to_one
  }

  join: account_owner {
    from: user
    sql_on: ${account.owner_id} = ${account_owner.id} ;;
    relationship: many_to_one
  }

  join: manager {
    from: user
    sql_on: ${account_owner.manager_id} = ${manager.id};;
    fields: []
    relationship: many_to_one
  }

  join: opportunity {
    sql_on: ${account.id} = ${opportunity.account_id} ;;
    relationship: one_to_many
  }
}
