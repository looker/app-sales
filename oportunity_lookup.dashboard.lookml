- dashboard: oportunity_lookup
  title: Oportunity Lookup
  extends: sales_analytics_base
  elements:
  - title: Logo
    name: Logo
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields: [account.logo]
    query_timezone: America/Los_Angeles
    series_types: {}
    listen:
      Opportunity: opportunity.name
    row: 7
    col: 4
    width: 4
    height: 7
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
      Opportunity: opportunity.name
    row: 7
    col: 0
    width: 4
    height: 7
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
      Opportunity: opportunity.name
    row: 14
    col: 0
    width: 12
    height: 7
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
      Opportunity: opportunity.name
    row: 7
    col: 18
    width: 6
    height: 7
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
      Opportunity: opportunity.name
    row: 14
    col: 12
    width: 12
    height: 7
  - title: Projected Clost Date
    name: Projected Clost Date
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields: [opportunity.close_date]
    fill_fields: [opportunity.close_date]
    sorts: [opportunity.close_date desc]
    limit: 500
    query_timezone: UTC
    custom_color_enabled: true
    custom_color: ''
    show_single_value_title: true
    single_value_title: Projected Close Date
    value_format: "#"
    show_comparison: false
    comparison_type: change
    comparison_reverse_colors: true
    show_comparison_label: true
    comparison_label: Days Compared to Avg
    series_types: {}
    hidden_fields: [account.name_comparitor]
    listen:
      Opportunity: opportunity.name
    row: 3
    col: 18
    width: 6
    height: 4
  - title: Opp Stage
    name: Opp Stage
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields: [opportunity.stage_name]
    sorts: [opportunity.stage_name]
    limit: 500
    column_limit: 50
    query_timezone: UTC
    custom_color_enabled: true
    custom_color: ''
    show_single_value_title: false
    value_format: ''
    show_comparison: false
    comparison_type: change
    comparison_reverse_colors: false
    show_comparison_label: false
    comparison_label: ''
    series_types: {}
    hidden_fields: [account.name_comparitor]
    listen:
      Opportunity: opportunity.name
    row: 3
    col: 12
    width: 6
    height: 4
  - title: Opportunity Name
    name: Opportunity Name
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields: [opportunity.name]
    limit: 500
    query_timezone: America/Los_Angeles
    series_types: {}
    listen:
      Opportunity: opportunity.name
    row: 0
    col: 0
    width: 24
    height: 3
  - title: Revenue
    name: Revenue
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields: [opportunity.average_amount_won, opportunity.opportunity_comparitor]
    fill_fields: [opportunity.opportunity_comparitor]
    sorts: [opportunity.opportunity_comparitor]
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: compared_to_avg_raw, label: Compared to Avg
          Raw, expression: 'if(is_null(${opportunity.average_amount_won})=yes, 0,
          ${opportunity.average_amount_won}) - offset(${opportunity.average_amount_won},1)',
        value_format: '[>=1000000]$0.00,,"M";[>=1000]$0,"K";$0.00', value_format_name: !!null '',
        _kind_hint: measure, _type_hint: number}, {table_calculation: compared_to_avg,
        label: Compared to Avg, expression: "if(abs(${compared_to_avg_raw}) >= 1000000,\
          \ concat(round(${compared_to_avg_raw}/1000000,1),\"M\"), \n  \n    if(abs(${compared_to_avg_raw})\
          \ >= 1000, concat(round(${compared_to_avg_raw}/1000,1),\"K\"), to_string(${compared_to_avg_raw}))\n\
          \        )", value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
        _type_hint: string}]
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
    hidden_fields: [account.name_comparitor, compared_to_avg_raw]
    listen:
      Opportunity: opportunity.opportunity_select
    row: 3
    col: 0
    width: 6
    height: 4
  - title: Days in Each Stage
    name: Days in Each Stage
    model: sales_analytics
    explore: opportunity
    type: looker_column
    fields: [opportunity_stage_history.avg_days_in_stage, opportunity_stage_history.stage,
      opportunity.opportunity_comparitor]
    pivots: [opportunity.opportunity_comparitor]
    fill_fields: [opportunity.opportunity_comparitor]
    filters:
      opportunity_stage_history.stage: "-NULL"
    sorts: [opportunity_stage_history.stage, opportunity.opportunity_comparitor]
    limit: 500
    column_limit: 50
    query_timezone: UTC
    color_application:
      collection_id: 5f313589-67ce-44ba-b084-ec5107a7bb7e
      palette_id: be92eae7-de25-46ae-8e4f-21cb0b69a1f3
      options:
        steps: 5
        __FILE: app-sales/customer_lookup.dashboard.lookml
        __LINE_NUM: 329
    x_axis_gridlines: false
    y_axis_gridlines: false
    show_view_names: false
    y_axes: [{label: '', orientation: left, series: [{axisId: opportunity_stage_history.avg_days_in_stage,
            id: Selected Opportunity - 0 - opportunity_stage_history.avg_days_in_stage,
            name: Selected Opportunity}, {axisId: opportunity_stage_history.avg_days_in_stage,
            id: All Other Opportunities - 1 - opportunity_stage_history.avg_days_in_stage,
            name: All Other Opportunities}], showLabels: false, showValues: false,
        unpinAxis: false, tickDensity: default, type: linear}]
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: true
    limit_displayed_rows_values:
      show_hide: hide
      first_last: first
      num_rows: '1'
    legend_position: center
    series_types: {}
    point_style: none
    series_colors:
      Selected Account - 0 - opportunity_stage_history.avg_days_in_stage: "#9F4AB4"
      All Other Accounts - 1 - opportunity_stage_history.avg_days_in_stage: "#FDA08A"
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    custom_color_enabled: true
    custom_color: ''
    show_single_value_title: true
    value_format: "#"
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: true
    show_comparison_label: true
    comparison_label: Days Compared to Avg
    hidden_fields: [account.name_comparitor]
    listen:
      Opportunity: opportunity.opportunity_select
    row: 7
    col: 8
    width: 10
    height: 7
  - title: Days In Stage
    name: Days In Stage
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields: [opportunity_stage_history.stage, opportunity.opportunity_comparitor,
      opportunity_stage_history.avg_days_in_stage]
    pivots: [opportunity.opportunity_comparitor]
    fill_fields: [opportunity.opportunity_comparitor]
    filters: {}
    sorts: [opportunity_stage_history.stage desc, opportunity.opportunity_comparitor]
    limit: 500
    column_limit: 50
    query_timezone: UTC
    custom_color_enabled: true
    custom_color: ''
    show_single_value_title: true
    value_format: ''
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    comparison_label: Compared to Avg
    series_types: {}
    hidden_fields: [account.name_comparitor, opportunity_stage_history.stage]
    listen:
      Opportunity: opportunity.opportunity_select
    row: 3
    col: 6
    width: 6
    height: 4
  filters:
  - name: Opportunity
    title: Opportunity
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: sales_analytics
    explore: opportunity
    listens_to_filters: []
    field: opportunity.name
