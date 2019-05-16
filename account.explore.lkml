include: "account_core.view.lkml"

explore: account_core {
  extension: required
  view_name: account
  sql_always_where: NOT ${account.is_deleted}
    ;;
  fields: [ALL_FIELDS*, -account_owner.user_exclusion_set*, -creator.user_exclusion_set*, -opportunity.opportunity_exclusion_set*]

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

  join: opportunity_owner {
    from: user
    sql_on: ${opportunity.owner_id} = ${opportunity_owner.id} ;;
    relationship: many_to_one
  }

  join: account_facts_start_date {
    sql_on: ${account_facts_start_date.account_id} = ${account.id} ;;
    relationship: one_to_one
  }

  join: account_facts_customer_lifetime_value {
    sql_on: ${account_facts_customer_lifetime_value.account_id} = ${account.id} ;;
    relationship: one_to_one
  }

  join: quota {
    view_label: "Quota"
    sql_on: ${quota.name} = ${opportunity_owner.name} ;;
    relationship: one_to_one
  }

#   join: quota_aggregation {
#     view_label: "Quota"
#     sql_on: ${quota_aggregation.ae_segment} = ${quota.ae_segment} ;;
#     relationship: one_to_one
#   }
  join: first_meeting {
    view_label: "Opportunity"
    sql_on: ${opportunity.id} = ${first_meeting.opportunity_id} ;;
    relationship: one_to_one
  }
}
