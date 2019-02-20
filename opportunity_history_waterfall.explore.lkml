include: "opportunity_history_waterfall_core.view"

explore: opportunity_history_waterfall_core {
  extension: required
  view_name: opportunity_history_waterfall

  # Filters out all opportunities that have a close date outside the timeframe we specify
  sql_always_where: (CASE WHEN ${closed_first} THEN 1 ELSE 0 END) = 0 AND ${closed_date_in_start_or_end} AND ${opportunity.is_new_business} ;;

  join: opportunity {
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
}
