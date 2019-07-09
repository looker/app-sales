include: "contact_core.view.lkml"

explore: contact_core {
  extension: required
  view_name: contact
  sql_always_where: NOT ${contact.is_deleted} ;;

  fields: [ALL_FIELDS*, -contact_owner.user_exclusion_set*, -opportunity.opportunity_exclusion_set*, -account.account_exclusion_set*, -quota.quota_exclusion_set*]

  join: contact_owner {
    from: user
    sql_on: ${contact_owner.id} = ${contact.owner_id} ;;
    relationship: many_to_one
  }

  join: account {
    sql_on: ${contact.account_id} = ${account.id} ;;
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

  join: manager {
    from: user
    sql_on: ${opportunity_owner.manager_id} = ${manager.id};;
    fields: []
    relationship: many_to_one
  }

  join: quota {
    view_label: "Quota"
    sql_on: ${quota.name} = ${opportunity_owner.name} ;;
    relationship: one_to_one
  }

  join: aggregate_quota {
    sql_on: ${aggregate_quota.quota_start_fiscal_quarter} = ${opportunity.close_fiscal_quarter}  ;;
    relationship: many_to_one
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
