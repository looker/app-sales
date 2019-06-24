- dashboard: deal_flow
  title: Deal Flow
  extends: sales_analytics_base
  embed_style:
    background_color: "#ffffff"
    title_color: "#3a4245"
    tile_text_color: "#3a4245"
    text_tile_text_color: ''
  elements:
  - title: Forecast Categories
    name: Forecast Categories
    model: sales_analytics
    explore: opportunity_history_waterfall
    type: sankey
    fields: [opportunity_history_waterfall.sankey_forecast_first, opportunity_history_waterfall.sankey_forecast_last,
      opportunity_history_waterfall.sankey_sum_amount]
    filters:
      opportunity_history_waterfall.pipeline_dates: this quarter
    sorts: [opportunity_history_waterfall.sankey_forecast_first]
    limit: 500
    color_range: ["#FED8A0", "#FFB690", "#FDA08A", "#EE9093", "#D978A1", "#C762AD",
      "#BB55B4", "#9F4AB4", "#8643B1", "#683AAE", "#462C9D", "#170658"]
    series_types: {}
    listen:
      Pipeline Category - Start: opportunity_history_waterfall.sankey_forecast_first
      Pipeline Category - End: opportunity_history_waterfall.sankey_forecast_last
      Segment: account.business_segment
      Source: opportunity.source
      Stage: opportunity.custom_stage_name
    row: 0
    col: 0
    width: 24
    height: 11
  - title: Opp Amount by Source
    name: Opp Amount by Source
    model: sales_analytics
    explore: opportunity_history_waterfall
    type: looker_pie
    fields: [opportunity_history_waterfall.sankey_sum_amount, opportunity.source]
    filters:
      opportunity_history_waterfall.pipeline_dates: 1 quarters ago for 1 quarter
    sorts: [opportunity_history_waterfall.sankey_sum_amount desc]
    limit: 500
    value_labels: legend
    label_type: labPer
    color_application:
      collection_id: 5f313589-67ce-44ba-b084-ec5107a7bb7e
      palette_id: b20fe57d-cb13-420f-815b-60e907a43148
      options:
        steps: 5
        __FILE: app-sales/deal_flow.dashboard.lookml
        __LINE_NUM: 45
    series_colors: {}
    color_range: ["#dd3333", "#80ce5d", "#f78131", "#369dc1", "#c572d3", "#36c1b3",
      "#b57052", "#ed69af"]
    series_types: {}
    hidden_fields: []
    listen:
      Pipeline Category - Start: opportunity_history_waterfall.sankey_forecast_first
      Pipeline Category - End: opportunity_history_waterfall.sankey_forecast_last
      Segment: account.business_segment
      Source: opportunity.source
      Stage: opportunity.custom_stage_name
    row: 11
    col: 0
    width: 6
    height: 6
  - title: Opps By Rep
    name: Opps By Rep
    model: sales_analytics
    explore: opportunity_history_waterfall
    type: looker_bar
    fields: [opportunity_history_waterfall.sankey_forecast_last, opportunity_owner.name,
      opportunity_history_waterfall.count]
    pivots: [opportunity_history_waterfall.sankey_forecast_last]
    filters:
      opportunity_history_waterfall.pipeline_dates: this quarter
    sorts: [opportunity_history_waterfall.sankey_forecast_last 0, total_count desc]
    limit: 1000
    column_limit: 50
    dynamic_fields: [{table_calculation: total_count, label: Total Count, expression: 'sum(pivot_row(${opportunity_history_waterfall.count}))',
        value_format: !!null '', value_format_name: decimal_0, _kind_hint: supermeasure,
        _type_hint: number}]
    stacking: normal
    trellis: ''
    color_application:
      collection_id: 5f313589-67ce-44ba-b084-ec5107a7bb7e
      palette_id: be92eae7-de25-46ae-8e4f-21cb0b69a1f3
      options:
        steps: 5
        __FILE: app-sales/deal_flow.dashboard.lookml
        __LINE_NUM: 117
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    point_style: none
    series_colors: {}
    series_types: {}
    limit_displayed_rows: true
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '10'
    y_axes: [{label: '', orientation: left, series: [{id: Closed Lost - opportunity_history_waterfall.count,
            name: Closed Lost, axisId: Closed Lost - opportunity_history_waterfall.count,
            __FILE: app-sales/deal_flow.dashboard.lookml, __LINE_NUM: 132}, {id: Closed
              Won - opportunity_history_waterfall.count, name: Closed Won, axisId: Closed
              Won - opportunity_history_waterfall.count, __FILE: app-sales/deal_flow.dashboard.lookml,
            __LINE_NUM: 134}, {id: Moved Out - opportunity_history_waterfall.count,
            name: Moved Out, axisId: Moved Out - opportunity_history_waterfall.count,
            __FILE: app-sales/deal_flow.dashboard.lookml, __LINE_NUM: 135}, {id: Remain
              Open - opportunity_history_waterfall.count, name: Remain Open, axisId: Remain
              Open - opportunity_history_waterfall.count, __FILE: app-sales/deal_flow.dashboard.lookml,
            __LINE_NUM: 137}], showLabels: false, showValues: false, unpinAxis: false,
        tickDensity: default, tickDensityCustom: 5, type: linear, __FILE: app-sales/deal_flow.dashboard.lookml,
        __LINE_NUM: 132}]
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    ordering: none
    show_null_labels: false
    show_totals_labels: true
    show_silhouette: false
    totals_color: "#808080"
    color_range: ["#FED8A0", "#FFB690", "#FDA08A", "#EE9093", "#D978A1", "#C762AD",
      "#BB55B4", "#9F4AB4", "#8643B1", "#683AAE", "#462C9D", "#170658"]
    hidden_fields: [total_count]
    listen:
      Pipeline Category - Start: opportunity_history_waterfall.sankey_forecast_first
      Pipeline Category - End: opportunity_history_waterfall.sankey_forecast_last
      Segment: account.business_segment
      Source: opportunity.source
      Stage: opportunity.custom_stage_name
    row: 11
    col: 18
    width: 6
    height: 6
  - title: Current Opp Summary
    name: Current Opp Summary
    model: sales_analytics
    explore: opportunity_history_waterfall
    type: table
    fields: [opportunity.stage_name, opportunity.name, opportunity_owner.name, opportunity.total_amount,
      opportunity.is_pipeline]
    filters:
      opportunity_history_waterfall.pipeline_dates: 1 quarters ago for 1 quarters
    sorts: [opportunity.total_amount desc]
    limit: 500
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    subtotals_at_bottom: false
    hide_totals: false
    hide_row_totals: false
    series_labels:
      opportunity_owner.name: Owner
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: true
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: !!null '',
        font_color: !!null '', color_application: {collection_id: legacy, palette_id: legacy_diverging1,
          options: {steps: 5, stepped: false, __FILE: app-sales/deal_flow.dashboard.lookml,
            __LINE_NUM: 195}, __FILE: app-sales/deal_flow.dashboard.lookml, __LINE_NUM: 194},
        bold: false, italic: false, strikethrough: false, fields: [], __FILE: app-sales/deal_flow.dashboard.lookml,
        __LINE_NUM: 193}]
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    listen:
      Pipeline Category - Start: opportunity_history_waterfall.sankey_forecast_first
      Pipeline Category - End: opportunity_history_waterfall.sankey_forecast_last
      Segment: account.business_segment
      Source: opportunity.source
      Stage: opportunity.custom_stage_name
    row: 23
    col: 0
    width: 24
    height: 7
  - title: Opps by Stage
    name: Opps by Stage
    model: sales_analytics
    explore: opportunity_history_waterfall
    type: looker_pie
    fields: [opportunity_history_waterfall.sankey_sum_amount, opportunity.custom_stage_name]
    filters:
      opportunity_history_waterfall.pipeline_dates: 1 quarters ago for 1 quarters
    sorts: [opportunity.custom_stage_name]
    limit: 500
    column_limit: 50
    value_labels: legend
    label_type: labPer
    color_application:
      collection_id: 5f313589-67ce-44ba-b084-ec5107a7bb7e
      palette_id: b20fe57d-cb13-420f-815b-60e907a43148
      options:
        steps: 5
        __FILE: app-sales/deal_flow.dashboard.lookml
        __LINE_NUM: 227
    series_colors: {}
    series_labels: {}
    color_range: ["#dd3333", "#80ce5d", "#f78131", "#369dc1", "#c572d3", "#36c1b3",
      "#b57052", "#ed69af"]
    series_types: {}
    hidden_fields: []
    listen:
      Pipeline Category - Start: opportunity_history_waterfall.sankey_forecast_first
      Pipeline Category - End: opportunity_history_waterfall.sankey_forecast_last
      Segment: account.business_segment
      Source: opportunity.source
      Stage: opportunity.custom_stage_name
    row: 17
    col: 6
    width: 6
    height: 6
  - title: Opp Amount by Segment
    name: Opp Amount by Segment
    model: sales_analytics
    explore: opportunity_history_waterfall
    type: looker_pie
    fields: [opportunity_history_waterfall.sankey_sum_amount, account.business_segment]
    filters:
      opportunity_history_waterfall.pipeline_dates: 1 quarters ago for 1 quarters
    sorts: [opportunity_history_waterfall.sankey_sum_amount desc]
    limit: 500
    column_limit: 50
    value_labels: legend
    label_type: labPer
    color_application:
      collection_id: 5f313589-67ce-44ba-b084-ec5107a7bb7e
      palette_id: b20fe57d-cb13-420f-815b-60e907a43148
      options:
        steps: 5
        __FILE: app-sales/deal_flow.dashboard.lookml
        __LINE_NUM: 79
    series_colors: {}
    color_range: ["#dd3333", "#80ce5d", "#f78131", "#369dc1", "#c572d3", "#36c1b3",
      "#b57052", "#ed69af"]
    series_types: {}
    hidden_fields: []
    listen:
      Pipeline Category - Start: opportunity_history_waterfall.sankey_forecast_first
      Pipeline Category - End: opportunity_history_waterfall.sankey_forecast_last
      Segment: account.business_segment
      Source: opportunity.source
      Stage: opportunity.custom_stage_name
    row: 11
    col: 12
    width: 6
    height: 6
  filters:
  - name: Pipeline Category - Start
    title: Pipeline Category - Start
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: sales_analytics
    explore: opportunity_history_waterfall_filter_suggestions
    listens_to_filters: []
    field: opportunity_history_waterfall_filter_suggestions.suggestions_first
  - name: Pipeline Category - End
    title: Pipeline Category - End
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: sales_analytics
    explore: opportunity_history_waterfall_filter_suggestions
    listens_to_filters: []
    field: opportunity_history_waterfall_filter_suggestions.suggestions_last
  - name: Segment
    title: Segment
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: sales_analytics
    explore: opportunity_history_waterfall
    listens_to_filters: []
    field: account.business_segment
  - name: Source
    title: Source
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: sales_analytics
    explore: opportunity_history_waterfall
    listens_to_filters: []
    field: opportunity.source
  - name: Stage
    title: Stage
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: sales_analytics
    explore: opportunity_history_waterfall
    listens_to_filters: []
    field: opportunity.custom_stage_name
