# Used for the Pipeline Report Viz on the "Pipeline Management" Dashboard
include: "opportunity_history_by_day.view"
include: "calendar.view"

explore: calendar {
  join: opportunity_history_by_day {
    type: inner
    relationship: many_to_many
    sql_on: ${calendar.generated_raw} >= CAST(${opportunity_history_by_day.window_start_raw} AS DATE)
            AND
            ${calendar.generated_raw} < CAST(${opportunity_history_by_day.window_end_raw} AS DATE);;
  }
}
