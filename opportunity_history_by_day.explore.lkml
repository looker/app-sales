# Used for the Pipeline Report Viz on the "Pipeline Management" Dashboard
explore: opportunity_history_by_day_core {
  extension: required
  view_name: opportunity_history_by_day
  label: "Opportunity Snapshots"
#   fields: [ALL_FIELDS* , -opportunity_owner.manager, -opportunity_owner.rep_comparitor, -opportunity_owner.average_amount_pipeline]

  join: calendar {
    type: inner
    relationship: many_to_many
    sql_on: ${calendar.generated_raw} >= CAST(${opportunity_history_by_day.window_start_raw} AS DATE)
            AND
            ${calendar.generated_raw} < CAST(${opportunity_history_by_day.window_end_raw} AS DATE);;
  }
  join: current_opportunity {
    from: opportunity
    relationship: one_to_many
    sql_on: ${current_opportunity.id} = ${opportunity_history_by_day.opportunity_id} ;;
    fields: []
  }
  join: opportunity_owner {
    from: user
    relationship: one_to_many
    sql_on: ${opportunity_owner.id} = ${current_opportunity.owner_id} ;;
    fields: []
  }
  join: account {
    sql_on: ${current_opportunity.account_id} = ${account.id} ;;
    relationship: many_to_one
  }
}
