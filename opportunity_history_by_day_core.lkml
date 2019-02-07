# Used for the Pipeline Report Viz on the "Pipeline Management" Dashboard
explore: opportunity_history_by_day_core {
  extension: required
  view_name: opportunity_history_by_day

  join: calendar {
    type: inner
    relationship: many_to_many
    sql_on: ${calendar.generated_raw} >= CAST(${opportunity_history_by_day.window_start_raw} AS DATE)
            AND
            ${calendar.generated_raw} < CAST(${opportunity_history_by_day.window_end_raw} AS DATE);;
  }
}
