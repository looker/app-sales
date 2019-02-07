include: "opportunity_history_waterfall_core.view"

explore: opportunity_history_waterfall_core {
  extension: required
  view_name: opportunity_history_waterfall

  always_filter: {
    filters: {
      field: pipeline_dates
      value: "last quarter"
    }
  }
}
