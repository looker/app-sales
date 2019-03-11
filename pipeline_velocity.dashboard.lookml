- dashboard: pipeline_velocity
  title: Pipeline Velocity
  extends: sales_analystics_base
  elements:
  - title: Avg Days Stage 1 - 2
    name: Avg Days Stage 1 - 2
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields: [opportunity_stage_history.avg_days_stage_1_to_2]
    limit: 500
    query_timezone: America/Los_Angeles
    listen: {}
    row: 0
    col: 4
    width: 4
    height: 4
  - title: Avg Days Stage 2 - 3
    name: Avg Days Stage 2 - 3
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields: [opportunity_stage_history.avg_days_stage_2_to_3]
    limit: 500
    query_timezone: America/Los_Angeles
    listen: {}
    row: 0
    col: 8
    width: 4
    height: 4
  - title: Avg Days Stage 3 - 4
    name: Avg Days Stage 3 - 4
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields: [opportunity_stage_history.avg_days_stage_3_to_4]
    limit: 500
    query_timezone: America/Los_Angeles
    listen: {}
    row: 0
    col: 12
    width: 4
    height: 4
  - title: Avg Days Stage 4 - 5
    name: Avg Days Stage 4 - 5
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields: [opportunity_stage_history.avg_days_stage_4_to_5]
    limit: 500
    query_timezone: America/Los_Angeles
    listen: {}
    row: 0
    col: 16
    width: 4
    height: 4
  - title: Avg Days Stage 5 - 6
    name: Avg Days Stage 5 - 6
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields: [opportunity_stage_history.avg_days_stage_5_to_6]
    limit: 500
    query_timezone: America/Los_Angeles
    listen: {}
    row: 0
    col: 20
    width: 4
    height: 4
  - title: Avg Days Stage 1 - Close
    name: Avg Days Stage 1 - Close
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields: [opportunity.average_days_to_closed_won]
    limit: 500
    column_limit: 50
    row: 0
    col: 0
    width: 4
    height: 4
  - title: Avg Days Per Stage Per Rep
    name: Avg Days Per Stage Per Rep
    model: sales_analytics
    explore: opportunity
    type: looker_bar
    fields: [opportunity_owner.name, opportunity.total_closed_won_amount, opportunity_stage_history.avg_days_in_stage,
      opportunity_stage_history.stage]
    pivots: [opportunity_stage_history.stage]
    filters:
      opportunity_owner.name: "-NULL"
    sorts: [opportunity_stage_history.stage 0, sum_of_all_days desc]
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: sum_of_all_days, label: Sum of all days,
        expression: 'sum(pivot_row(${opportunity_stage_history.avg_days_in_stage}))',
        value_format: !!null '', value_format_name: !!null '', _kind_hint: supermeasure,
        _type_hint: number}]
    stacking: normal
    trellis: ''
    color_application:
      collection_id: 5f313589-67ce-44ba-b084-ec5107a7bb7e
      palette_id: be92eae7-de25-46ae-8e4f-21cb0b69a1f3
      options:
        steps: 5
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: false
    show_view_names: false
    point_style: none
    series_types: {}
    limit_displayed_rows: true
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '20'
    hidden_series: [opportunity_stage_history.stage___null - opportunity_stage_history.avg_days_in_stage]
    y_axes: [{label: '', orientation: bottom, series: [{id: Stage 1 - opportunity_stage_history.avg_days_in_stage,
            name: Stage 1, axisId: Stage 1 - opportunity_stage_history.avg_days_in_stage},
          {id: Stage 2 - opportunity_stage_history.avg_days_in_stage, name: Stage
              2, axisId: Stage 2 - opportunity_stage_history.avg_days_in_stage}, {
            id: Stage 3 - opportunity_stage_history.avg_days_in_stage, name: Stage
              3, axisId: Stage 3 - opportunity_stage_history.avg_days_in_stage}, {
            id: Stage 4 - opportunity_stage_history.avg_days_in_stage, name: Stage
              4, axisId: Stage 4 - opportunity_stage_history.avg_days_in_stage}, {
            id: Stage 5 - opportunity_stage_history.avg_days_in_stage, name: Stage
              5, axisId: Stage 5 - opportunity_stage_history.avg_days_in_stage}, {
            id: Stage 6 - opportunity_stage_history.avg_days_in_stage, name: Stage
              6, axisId: Stage 6 - opportunity_stage_history.avg_days_in_stage}, {
            id: opportunity_stage_history.stage___null - opportunity_stage_history.avg_days_in_stage,
            name: "∅", axisId: opportunity_stage_history.stage___null - opportunity_stage_history.avg_days_in_stage}],
        showLabels: false, showValues: false, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
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
    hidden_fields: [opportunity.total_closed_won_amount, sum_of_all_days]
    listen: {}
    row: 14
    col: 12
    width: 12
    height: 7
  - title: Avg Days Per Stage Per Account
    name: Avg Days Per Stage Per Account
    model: sales_analytics
    explore: opportunity
    type: looker_bar
    fields: [opportunity_stage_history.stage, opportunity.total_closed_won_amount,
      account.name, opportunity_stage_history.avg_days_in_stage]
    pivots: [opportunity_stage_history.stage]
    filters:
      account.is_customer: 'Yes'
      opportunity_stage_history.stage: "-NULL"
    sorts: [opportunity_stage_history.stage 0, sum_amount desc]
    limit: 2000
    column_limit: 50
    dynamic_fields: [{table_calculation: sum_amount, label: Sum Amount, expression: 'sum(pivot_row(${opportunity.total_closed_won_amount}))',
        value_format: !!null '', value_format_name: usd_0, _kind_hint: supermeasure,
        _type_hint: number}]
    stacking: normal
    trellis: ''
    color_application:
      collection_id: 5f313589-67ce-44ba-b084-ec5107a7bb7e
      palette_id: be92eae7-de25-46ae-8e4f-21cb0b69a1f3
      options:
        steps: 5
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: false
    show_view_names: false
    point_style: none
    series_types: {}
    limit_displayed_rows: true
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '20'
    hidden_series: [opportunity_stage_history.stage___null - opportunity_stage_history.avg_days_in_stage,
      Stage 0 - opportunity_stage_history.avg_days_in_stage]
    y_axes: [{label: '', orientation: bottom, series: [{id: Stage 1 - opportunity_stage_history.avg_days_in_stage,
            name: Stage 1, axisId: Stage 1 - opportunity_stage_history.avg_days_in_stage},
          {id: Stage 2 - opportunity_stage_history.avg_days_in_stage, name: Stage
              2, axisId: Stage 2 - opportunity_stage_history.avg_days_in_stage}, {
            id: Stage 3 - opportunity_stage_history.avg_days_in_stage, name: Stage
              3, axisId: Stage 3 - opportunity_stage_history.avg_days_in_stage}, {
            id: Stage 4 - opportunity_stage_history.avg_days_in_stage, name: Stage
              4, axisId: Stage 4 - opportunity_stage_history.avg_days_in_stage}, {
            id: Stage 5 - opportunity_stage_history.avg_days_in_stage, name: Stage
              5, axisId: Stage 5 - opportunity_stage_history.avg_days_in_stage}, {
            id: Stage 6 - opportunity_stage_history.avg_days_in_stage, name: Stage
              6, axisId: Stage 6 - opportunity_stage_history.avg_days_in_stage}, {
            id: opportunity_stage_history.stage___null - opportunity_stage_history.avg_days_in_stage,
            name: "∅", axisId: opportunity_stage_history.stage___null - opportunity_stage_history.avg_days_in_stage}],
        showLabels: false, showValues: false, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
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
    hidden_fields: [opportunity.total_closed_won_amount, sum_amount]
    listen: {}
    row: 14
    col: 0
    width: 12
    height: 7
  - title: Days in Stage vs Conversion Rate
    name: Days in Stage vs Conversion Rate
    model: sales_analytics
    explore: opportunity
    type: looker_column
    fields: [opportunity_stage_history.avg_days_in_stage, opportunity_stage_history.stage,
      opportunity_stage_history.opps_in_each_stage]
    filters:
      opportunity_stage_history.stage: "-NULL"
    sorts: [opportunity_stage_history.stage]
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: avg_conversion_rate, label: Avg Conversion
          Rate, expression: "${opportunity_stage_history.opps_in_each_stage}/offset(${opportunity_stage_history.opps_in_each_stage},\
          \ -1)", value_format: !!null '', value_format_name: percent_0, _kind_hint: measure,
        _type_hint: number}]
    query_timezone: America/Los_Angeles
    stacking: ''
    trellis: ''
    color_application:
      collection_id: 5f313589-67ce-44ba-b084-ec5107a7bb7e
      palette_id: b20fe57d-cb13-420f-815b-60e907a43148
      options:
        steps: 5
    show_value_labels: true
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: false
    show_view_names: false
    point_style: circle
    series_colors:
      opportunity_stage_history.conv_rate_stage_1: "#FFB690"
      opportunity_stage_history.conv_rate_stage_2: "#EE9093"
      opportunity_stage_history.avg_days_in_stage: "#FDA08A"
    series_types:
      avg_conversion_rate: line
    limit_displayed_rows: true
    limit_displayed_rows_values:
      show_hide: hide
      first_last: first
      num_rows: '1'
    y_axes: [{label: '', orientation: left, series: [{id: opportunity_stage_history.avg_days_in_stage,
            name: Avg Days In Stage, axisId: opportunity_stage_history.avg_days_in_stage}],
        showLabels: false, showValues: false, unpinAxis: false, tickDensity: default,
        type: linear}, {label: !!null '', orientation: right, series: [{id: avg_conversion_rate,
            name: Avg Conversion Rate, axisId: avg_conversion_rate}], showLabels: false,
        showValues: false, unpinAxis: false, tickDensity: default, type: linear}]
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
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_null_points: true
    interpolation: linear
    leftAxisLabelVisible: false
    leftAxisLabel: ''
    rightAxisLabelVisible: false
    rightAxisLabel: ''
    smoothedBars: false
    orientation: automatic
    labelPosition: left
    percentType: total
    percentPosition: inline
    valuePosition: right
    labelColorEnabled: false
    labelColor: "#FFF"
    hidden_fields: [opportunity_stage_history.opps_in_each_stage]
    listen: {}
    row: 4
    col: 0
    width: 24
    height: 10
