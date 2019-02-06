# Used for Pipeline Waterfall Viz for "Pipeline Management" Dashboard
include: "opportunity_history_waterfall.view"

explore: opportunity_history_waterfall {
  always_filter: {
    filters: {
      field: pipeline_dates
      value: "last quarter"
    }
  }
}
