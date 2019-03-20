- dashboard: pipeline_velocity
  title: Pipeline Velocity
  extends: sales_analytics_base
  elements:
  - title: 'Days in Pipeline: Top Deals'
    name: 'Days in Pipeline: Top Deals'
    model: sales_analytics
    explore: opportunity
    type: looker_bar
    fields: [opportunity_stage_history.highest_stage_reached, opportunity_stage_history.avg_days_in_stage,
      account.name, opportunity.total_closed_won_amount]
    pivots: [opportunity_stage_history.highest_stage_reached]
    filters:
      opportunity_stage_history.highest_stage_reached: "-NULL"
      account.is_customer: 'Yes'
      opportunity.is_new_business: 'Yes'
    sorts: [opportunity_stage_history.highest_stage_reached 0, total desc]
    limit: 2000
    dynamic_fields: [{table_calculation: total, label: Total, expression: 'sum(pivot_row(${opportunity.total_closed_won_amount}))',
        value_format: !!null '', value_format_name: usd_0, _kind_hint: supermeasure,
        _type_hint: number}]
    query_timezone: America/Los_Angeles
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
    point_style: circle
    series_types: {}
    limit_displayed_rows: true
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '20'
    y_axes: [{label: '', orientation: left, series: [{id: opportunity_stage_history.avg_days_in_stage,
            name: Avg Days In Stage, axisId: opportunity_stage_history.avg_days_in_stage}],
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
    show_null_points: true
    interpolation: linear
    hidden_fields: [opportunity.total_closed_won_amount, total]
    listen:
      Opportunity Name: opportunity.name
      Manager Name: opportunity_owner.manager
    row: 7
    col: 0
    width: 12
    height: 11
  - title: Avg Days Stage 1 - Close
    name: Avg Days Stage 1 - Close
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields: [opportunity.average_days_to_closed_won]
    limit: 500
    column_limit: 50
    listen:
      Opportunity Name: opportunity.name
      Manager Name: opportunity_owner.manager
    row: 0
    col: 0
    width: 5
    height: 7
  - title: Days in Stage
    name: Days in Stage
    model: sales_analytics
    explore: opportunity
    type: looker_area
    fields: [opportunity_stage_history.highest_stage_reached, opportunity_stage_history.avg_days_in_stage]
    filters:
      opportunity.is_renewal_upsell: 'No'
      opportunity_stage_history.highest_stage_reached: "-NULL"
      opportunity.created_date: 9 months
    sorts: [opportunity_stage_history.highest_stage_reached]
    limit: 500
    query_timezone: America/Los_Angeles
    stacking: ''
    trellis: ''
    color_application:
      collection_id: 5f313589-67ce-44ba-b084-ec5107a7bb7e
      palette_id: be92eae7-de25-46ae-8e4f-21cb0b69a1f3
      options:
        steps: 5
    show_value_labels: true
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: false
    show_view_names: false
    point_style: circle_outline
    series_colors:
      opportunity_stage_history.avg_days_in_stage: "#C762AD"
    series_types: {}
    limit_displayed_rows: false
    y_axes: [{label: '', orientation: left, series: [{id: opportunity_stage_history.avg_days_in_stage,
            name: Avg Days In Stage, axisId: opportunity_stage_history.avg_days_in_stage}],
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
    show_null_points: true
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    listen:
      Opportunity Name: opportunity.name
      Manager Name: opportunity_owner.manager
    row: 0
    col: 17
    width: 7
    height: 7
  - title: Conversion Rate By Stage
    name: Conversion Rate By Stage
    model: sales_analytics
    explore: opportunity
    type: looker_column
    fields: [opportunity_stage_history.opps_in_stage_1, opportunity_stage_history.opps_in_stage_2,
      opportunity_stage_history.opps_in_stage_3, opportunity_stage_history.opps_in_stage_4,
      opportunity_stage_history.opps_in_stage_5, opportunity_stage_history.opps_in_stage_6]
    filters:
      opportunity.created_date: 9 months
      opportunity.is_new_business: 'Yes'
    limit: 500
    query_timezone: America/Los_Angeles
    stacking: ''
    trellis: ''
    color_application:
      collection_id: 5f313589-67ce-44ba-b084-ec5107a7bb7e
      palette_id: be92eae7-de25-46ae-8e4f-21cb0b69a1f3
      options:
        steps: 5
    show_value_labels: true
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: false
    show_view_names: false
    point_style: none
    limit_displayed_rows: false
    y_axes: [{label: '', orientation: left, series: [{id: opportunity_stage_history.opps_in_stage_1,
            name: Opps In Stage 1, axisId: opportunity_stage_history.opps_in_stage_1},
          {id: opportunity_stage_history.opps_in_stage_2, name: Opps In Stage 2, axisId: opportunity_stage_history.opps_in_stage_2},
          {id: opportunity_stage_history.opps_in_stage_3, name: Opps In Stage 3, axisId: opportunity_stage_history.opps_in_stage_3},
          {id: opportunity_stage_history.opps_in_stage_4, name: Opps In Stage 4, axisId: opportunity_stage_history.opps_in_stage_4},
          {id: opportunity_stage_history.opps_in_stage_5, name: Opps In Stage 5, axisId: opportunity_stage_history.opps_in_stage_5},
          {id: opportunity_stage_history.opps_in_stage_6, name: Opps In Stage 6, axisId: opportunity_stage_history.opps_in_stage_6}],
        showLabels: false, showValues: false, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: log}]
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: false
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    ordering: none
    show_null_labels: false
    show_dropoff: true
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    listen:
      Opportunity Name: opportunity.name
      Manager Name: opportunity_owner.manager
    row: 0
    col: 5
    width: 12
    height: 7
  - title: 'Rep: Average Days in Stage'
    name: 'Rep: Average Days in Stage'
    model: sales_analytics
    explore: opportunity
    type: looker_bar
    fields: [opportunity_stage_history.highest_stage_reached, opportunity_stage_history.avg_days_in_stage,
      opportunity.total_closed_won_amount, opportunity_owner.name]
    pivots: [opportunity_stage_history.highest_stage_reached]
    filters:
      opportunity_stage_history.highest_stage_reached: "-NULL"
      account.is_customer: 'Yes'
      opportunity_owner.name: "-NULL"
      opportunity.is_new_business: 'Yes'
      opportunity.created_date: 9 months
    sorts: [opportunity_stage_history.highest_stage_reached 0, opportunity_stage_history.avg_days_in_stage
        desc 0]
    limit: 1000
    dynamic_fields: [{table_calculation: total, label: Total, expression: 'sum(pivot_row(${opportunity.total_closed_won_amount}))',
        value_format: !!null '', value_format_name: usd_0, _kind_hint: supermeasure,
        _type_hint: number}]
    query_timezone: America/Los_Angeles
    stacking: normal
    trellis: ''
    color_application:
      collection_id: 5f313589-67ce-44ba-b084-ec5107a7bb7e
      palette_id: b20fe57d-cb13-420f-815b-60e907a43148
      options:
        steps: 5
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: false
    show_view_names: false
    point_style: circle
    series_types: {}
    limit_displayed_rows: true
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '10'
    hidden_series: [Stage 2 - 3 - opportunity_stage_history.avg_days_in_stage, Stage
        3 - 4 - opportunity_stage_history.avg_days_in_stage, Stage 5 - 6 - opportunity_stage_history.avg_days_in_stage]
    y_axes: [{label: '', orientation: left, series: [{id: opportunity_stage_history.avg_days_in_stage,
            name: Avg Days In Stage, axisId: opportunity_stage_history.avg_days_in_stage}],
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
    show_null_points: true
    interpolation: linear
    hidden_fields: [opportunity.total_closed_won_amount, total]
    listen:
      Opportunity Name: opportunity.name
      Manager Name: opportunity_owner.manager
    row: 7
    col: 12
    width: 12
    height: 11
  filters:
  - name: Opportunity Name
    title: Opportunity Name
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: sales_analytics
    explore: opportunity
    listens_to_filters: []
    field: opportunity.name
  - name: Manager Name
    title: Manager Name
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: sales_analytics
    explore: opportunity
    listens_to_filters: []
    field: opportunity_owner.manager
