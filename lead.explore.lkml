include: "lead_core.view.lkml"

explore: lead_core {
  extension: required
  view_name: lead
  fields: [ALL_FIELDS*,-opportunity.opportunity_exclusion_set*, -account.account_exclusion_set*]
  sql_always_where: NOT ${lead.is_deleted}
    ;;

  join: lead_owner {
    from: user
    sql_on: ${lead.owner_id} = ${lead_owner.id} ;;
    relationship: many_to_one
  }

  join: account {
    sql_on: ${lead.converted_account_id} = ${account.id} ;;
    relationship: many_to_one
  }

  join: account_owner {
    from: user
    sql_on: ${account.owner_id} = ${account_owner.id} ;;
    relationship: many_to_one
  }

  join: contact {
    sql_on: ${lead.converted_contact_id} = ${contact.id} ;;
    relationship: many_to_one
  }

  join: opportunity {
    sql_on: ${lead.converted_opportunity_id} = ${opportunity.id} ;;
    relationship: many_to_one
  }

#   join: opportunity_stage {
#     sql_on: ${opportunity_stage.api_name} = ${opportunity.custom_stage_name} ;;
#     relationship: one_to_one
#   }

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

  join: task {
    sql_on: ${task.who_id} = ${lead.id} ;;
    relationship: one_to_many
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
