include: "opportunity_history_waterfall_core.view"

explore: opportunity_history_waterfall_core {
  hidden:  yes
  extension: required
  view_name: opportunity_history_waterfall
  fields: [ALL_FIELDS*,-opportunity.opportunity_exclusion_set*, -account.account_exclusion_set*]

  # Filters out all opportunities that have a close date outside the timeframe we specify
  sql_always_where: (CASE WHEN ${closed_first} THEN 1 ELSE 0 END) = 0 AND ${closed_date_in_start_or_end} AND ${opportunity.is_included_in_quota} ;;

  join: opportunity {
    view_label: "Current Opportunity"
    type: left_outer
    relationship: many_to_one
    sql_on: ${opportunity_history_waterfall.opportunity_id} = ${opportunity.id} ;;
  }
  join: account {
    sql_on: ${opportunity.account_id} = ${account.id} ;;
    relationship: many_to_one
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
  join: quota_aggregation {
    view_label: "Quota"
    sql_on: ${quota_aggregation.ae_segment} = ${quota.ae_segment} ;;
    relationship: one_to_one
  }
  join: first_meeting {
    view_label: "Opportunity"
    sql_on: ${opportunity.id} = ${first_meeting.opportunity_id} ;;
    relationship: one_to_one
  }
}

explore: opportunity_history_waterfall_filter_suggestions {
  hidden: yes
}
