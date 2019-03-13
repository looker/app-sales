- dashboard: customer_lookup
  title: Customer Lookup
  layout: newspaper
  elements:
  - title: Account Name
    name: Account Name
    model: sales_analytics
    explore: account
    type: single_value
    fields: [account.name]
    limit: 500
    show_view_names: 'true'
    series_types: {}
    listen:
      Account: account.name
    row: 0
    col: 0
    width: 6
    height: 4
  - title: Logo
    name: Logo
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields: [account.logo]
    query_timezone: America/Los_Angeles
    series_types: {}
    listen:
      Account: account.name
    row: 4
    col: 0
    width: 3
    height: 5
  - title: Account Facts
    name: Account Facts
    model: sales_analytics
    explore: opportunity
    type: looker_single_record
    fields: [account.business_segment, account_owner.name, account.industry, account.website,
      account.billing_state, account.billing_city, account.number_of_employees]
    sorts: [account.business_segment]
    limit: 500
    dynamic_fields: [{table_calculation: account_owner, label: Account Owner, expression: "${account_owner.name}",
        value_format: !!null '', value_format_name: !!null '', _kind_hint: dimension,
        _type_hint: string}]
    query_timezone: America/Los_Angeles
    show_view_names: false
    series_types: {}
    hidden_fields: [account_owner.name]
    listen:
      Account: account.name
    row: 4
    col: 3
    width: 3
    height: 5
  - title: Account History
    name: Account History
    model: sales_analytics
    explore: opportunity
    type: table
    fields: [opportunity.name, opportunity_owner.created_date, opportunity.close_date,
      opportunity.source, opportunity_owner.name, opportunity.total_closed_won_amount]
    sorts: [opportunity_owner.created_date desc]
    limit: 500
    query_timezone: America/Los_Angeles
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    subtotals_at_bottom: false
    hide_totals: false
    hide_row_totals: false
    table_theme: gray
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    listen:
      Account: account.name
    row: 14
    col: 12
    width: 12
    height: 5
  - title: Next Steps
    name: Next Steps
    model: sales_analytics
    explore: opportunity
    type: table
    fields: [opportunity.next_step, opportunity.last_activity_date]
    sorts: [opportunity.next_step desc]
    limit: 500
    query_timezone: America/Los_Angeles
    show_view_names: true
    show_row_numbers: true
    truncate_column_names: false
    subtotals_at_bottom: false
    hide_totals: false
    hide_row_totals: false
    table_theme: gray
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    listen:
      Account: account.name
    row: 9
    col: 12
    width: 12
    height: 5
  - name: Days in Stages
    title: Days in Stages
    merged_queries:
    - model: sales_analytics
      explore: opportunity
      type: table
      fields: [opportunity_stage_history.avg_days_in_stage, opportunity_stage_history.stage]
      filters:
        opportunity_stage_history.stage: "-NULL"
      sorts: [opportunity_stage_history.stage]
      limit: 500
      column_limit: 50
      join_fields: []
    - model: sales_analytics
      explore: opportunity
      type: table
      fields: [opportunity_stage_history.stage, opportunity_stage_history.avg_days_in_stage]
      filters:
        opportunity_stage_history.stage: "-NULL"
      sorts: [opportunity_stage_history.avg_days_in_stage desc]
      limit: 500
      query_timezone: America/Los_Angeles
      join_fields:
      - source_field_name: opportunity_stage_history.stage
        field_name: opportunity_stage_history.stage
        __FILE: app-sales/customer_lookup.dashboard.lookml
        __LINE_NUM: 278
    trellis: ''
    stacking: ''
    color_application:
      collection_id: 5f313589-67ce-44ba-b084-ec5107a7bb7e
      palette_id: be92eae7-de25-46ae-8e4f-21cb0b69a1f3
      options:
        steps: 5
        __FILE: app-sales/customer_lookup.dashboard.lookml
        __LINE_NUM: 286
    show_value_labels: true
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: false
    show_view_names: false
    point_style: none
    series_colors:
      q1_opportunity_stage_history.avg_days_in_stage: "#c4c7c7"
      opportunity_stage_history.avg_days_in_stage: "#8643B1"
    series_labels:
      q1_opportunity_stage_history.avg_days_in_stage: Average (All Accounts)
      opportunity_stage_history.avg_days_in_stage: Days In Stage
    series_types: {}
    limit_displayed_rows: false
    y_axes: [{label: '', orientation: left, series: [{id: opportunity_stage_history.avg_days_in_stage,
            name: Days In Stage, axisId: opportunity_stage_history.avg_days_in_stage,
            __FILE: app-sales/customer_lookup.dashboard.lookml, __LINE_NUM: 302},
          {id: q1_opportunity_stage_history.avg_days_in_stage, name: Average (All
              Accounts), axisId: q1_opportunity_stage_history.avg_days_in_stage, __FILE: app-sales/customer_lookup.dashboard.lookml,
            __LINE_NUM: 304}], showLabels: false, showValues: false, unpinAxis: false,
        tickDensity: default, tickDensityCustom: 5, type: linear, __FILE: app-sales/customer_lookup.dashboard.lookml,
        __LINE_NUM: 302}]
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
    type: looker_column
    hidden_fields: []
    column_limit: 50
    listen:
    - Account: account.name
    -
    row: 9
    col: 0
    width: 12
    height: 10
  - title: Location
    name: Location
    model: sales_analytics
    explore: account
    type: looker_map
    fields: [account.billing_location]
    sorts: [account.billing_location]
    limit: 500
    map_plot_mode: points
    heatmap_gridlines: false
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: satellite_streets
    map_position: fit_data
    map_latitude: 38.010010466528584
    map_longitude: -120.32844543457033
    map_zoom: 8
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: icon
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: meters
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_view_names: 'true'
    show_legend: true
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    series_types: {}
    listen:
      Account: account.name
    row: 0
    col: 18
    width: 6
    height: 9
  - title: Task History
    name: Task History
    model: sales_analytics
    explore: opportunity
    type: table
    fields: [task.activity_date, task.description, task.type, task.status]
    sorts: [task.activity_date desc]
    limit: 500
    query_timezone: America/Los_Angeles
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    subtotals_at_bottom: false
    hide_totals: false
    hide_row_totals: false
    table_theme: gray
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    listen:
      Account: account.name
    row: 19
    col: 0
    width: 23
    height: 8
  - title: Revenue
    name: Revenue
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields: [account.account_comparitor, opportunity.average_amount_won]
    fill_fields: [account.account_comparitor]
    filters: {}
    sorts: [account.account_comparitor]
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: compared_to_avg, label: Compared to Avg,
        expression: "${opportunity.average_amount_won} - offset(${opportunity.average_amount_won},1)",
        value_format: '[>=1000000]$0.00,,"M";[>=1000]$0,"K";$0.00', value_format_name: !!null '',
        _kind_hint: measure, _type_hint: number}]
    query_timezone: UTC
    custom_color_enabled: true
    custom_color: ''
    show_single_value_title: true
    value_format: ''
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: false
    show_comparison_label: true
    comparison_label: ''
    series_types: {}
    hidden_fields: [account.name_comparitor, account.account_comparitor]
    listen:
      Account: account.account_select
    row: 0
    col: 12
    width: 6
    height: 4
  - title: Days As Customer
    name: Days As Customer
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields: [account.account_comparitor, account.average_days_as_customer]
    fill_fields: [account.account_comparitor]
    filters: {}
    sorts: [account.account_comparitor]
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: compared_to_avg, label: Compared to Avg,
        expression: "${account.average_days_as_customer} - offset(${account.average_days_as_customer},1)",
        value_format: !!null '', value_format_name: decimal_0, _kind_hint: measure,
        _type_hint: number}]
    query_timezone: UTC
    custom_color_enabled: true
    custom_color: ''
    show_single_value_title: true
    value_format: ''
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: false
    show_comparison_label: true
    comparison_label: Days Compared to Avg
    series_types: {}
    hidden_fields: [account.name_comparitor, account.account_comparitor]
    listen:
      Account: account.account_select
    row: 0
    col: 6
    width: 6
    height: 4
  - title: Days To Close
    name: Days To Close
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields: [opportunity.average_days_to_closed_won, account.account_comparitor]
    fill_fields: [account.account_comparitor]
    filters: {}
    sorts: [account.account_comparitor]
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: compared_to_avg, label: Compared to Avg,
        expression: "${opportunity.average_days_to_closed_won} - offset(${opportunity.average_days_to_closed_won},1)",
        value_format: !!null '', value_format_name: decimal_0, _kind_hint: measure,
        _type_hint: number}]
    query_timezone: UTC
    custom_color_enabled: true
    custom_color: ''
    show_single_value_title: true
    value_format: "#"
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: true
    show_comparison_label: true
    comparison_label: Days Compared to Avg
    series_types: {}
    hidden_fields: [account.name_comparitor, account.account_comparitor]
    listen:
      Account: account.account_select
    row: 4
    col: 6
    width: 6
    height: 5
  - title: CLTV
    name: CLTV
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields: [account.account_comparitor, account.average_customer_lifetime_value]
    fill_fields: [account.account_comparitor]
    filters: {}
    sorts: [account.account_comparitor]
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: compared_to_avg, label: Compared to Avg,
        expression: "${account.average_customer_lifetime_value} - offset(${account.average_customer_lifetime_value},1)",
        value_format: !!null '', value_format_name: usd_0, _kind_hint: measure, _type_hint: number}]
    query_timezone: UTC
    custom_color_enabled: true
    custom_color: ''
    show_single_value_title: true
    value_format: ''
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: false
    show_comparison_label: true
    comparison_label: Days Compared to Avg
    series_types: {}
    hidden_fields: [account.name_comparitor, account.account_comparitor]
    listen:
      Account: account.account_select
    row: 4
    col: 12
    width: 6
    height: 5
  filters:
  - name: Account
    title: Account
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: sales_analytics
    explore: account
    listens_to_filters: []
    field: account.name
