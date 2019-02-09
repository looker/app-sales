- dashboard: sales_leadership_overview
  title: Sales Leadership Overview
  layout: newspaper
  elements:
  - title: Total Customers
    name: Total Customers
    model: sales_analytics
    explore: account
    type: single_value
    fields:
    - account.count
    filters:
      account.is_customer: 'yes'
      account.billing_state: ''
    sorts:
    - account.count desc
    limit: 1000
    column_limit: 50
    font_size: medium
    listen:
      Manager: account_owner.manager
      Business Segment: account.business_segment
    row: 4
    col: 12
    width: 6
    height: 4
  - title: New Bookings (This Quarter)
    name: New Bookings (This Quarter)
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields:
    - opportunity.close_year
    - opportunity.total_closed_won_amount
    pivots:
    - opportunity.close_year
    fill_fields:
    - opportunity.close_year
    filters:
      opportunity.close_date: 0 quarters ago for 1 quarter, 4 quarters ago for 1 quarter
    sorts:
    - opportunity.close_year desc
    dynamic_fields:
    - table_calculation: this_year
      label: This Year
      expression: 'pivot_index(${opportunity.total_closed_won_amount}, 1)

        '
      value_format: 0.0,, "M"; 0.0, "K"
      value_format_name:
      _kind_hint: supermeasure
      _type_hint: number
    - table_calculation: change
      label: Change
      expression: |2-

        (pivot_index(${opportunity.total_closed_won_amount}, 2) - pivot_index(${opportunity.total_closed_won_amount}, 1))/pivot_index(${opportunity.total_closed_won_amount}, 2)
      value_format:
      value_format_name: percent_0
      _kind_hint: supermeasure
      _type_hint: number
    custom_color_enabled: true
    custom_color: ''
    show_single_value_title: true
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: false
    show_comparison_label: false
    font_size: medium
    text_color: black
    hidden_fields: []
    listen:
      Manager: opportunity_owner.manager
      Business Segment: account.business_segment
    row: 0
    col: 12
    width: 6
    height: 4
  - title: New Customers (This Quarter)
    name: New Customers (This Quarter)
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields:
    - opportunity.count_new_business_won
    filters:
      opportunity.close_date: this quarter
    limit: 500
    column_limit: 50
    font_size: small
    listen:
      Manager: opportunity_owner.manager
      Business Segment: account.business_segment
    row: 0
    col: 18
    width: 6
    height: 4
  - title: QoQ Percent to Goal
    name: QoQ Percent to Goal
    model: sales_analytics
    explore: opportunity
    type: looker_line
    fields:
    - opportunity.day_of_quarter
    - opportunity.total_closed_won_amount
    - opportunity.close_quarter
    pivots:
    - opportunity.close_quarter
    fill_fields:
    - opportunity.close_quarter
    filters:
      opportunity.close_quarter: 5 quarters
    sorts:
    - opportunity.close_quarter desc 0
    - opportunity.day_of_quarter
    limit: 500
    column_limit: 50
    dynamic_fields:
    - table_calculation: quota
      label: Quota
      expression: 35000000 + if(is_null(${opportunity.total_closed_won_amount}),0,0)*0
      value_format:
      value_format_name:
      _kind_hint: measure
      _type_hint: number
    - table_calculation: of_quota
      label: "% of Quota"
      expression: running_total(${opportunity.total_closed_won_amount})/${quota}
      value_format:
      value_format_name: percent_2
      _kind_hint: measure
      _type_hint: number
    - table_calculation: goal
      label: Goal
      expression: pivot_where(pivot_column() = 1, 1)*0 + 1
      value_format:
      value_format_name:
      _kind_hint: supermeasure
      _type_hint: number
    stacking: ''
    color_application:
      collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7
      palette_id: fb7bb53e-b77b-4ab6-8274-9d420d3d73f3
      options:
        steps: 5
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    point_style: none
    series_colors:
      goal: "#75E2E2"
    series_types:
      goal: area
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    show_null_points: false
    interpolation: linear
    hidden_fields:
    - quota_quarter_goals.quota_sum
    - quota
    - opportunity.total_closed_won_amount
    listen:
      Manager: opportunity_owner.manager
      Business Segment: account.business_segment
    row: 0
    col: 0
    width: 12
    height: 8
  - title: Bookings YTD
    name: Bookings YTD
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields:
    - opportunity.total_closed_won_amount_ytd
    font_size: medium
    text_color: black
    listen:
      Manager: opportunity_owner.manager
      Business Segment: account.business_segment
    row: 4
    col: 18
    width: 6
    height: 4
  - title: Pipeline Overview
    name: Pipeline Overview
    model: sales_analytics
    explore: opportunity
    type: looker_column
    fields:
    - opportunity.probability_group
    - opportunity.close_month
    - opportunity.total_amount
    pivots:
    - opportunity.probability_group
    fill_fields:
    - opportunity.probability_group
    - opportunity.close_month
    filters:
      opportunity.close_month: 9 months ago for 12 months
    sorts:
    - opportunity.close_month
    - opportunity.probability_group 0
    limit: 500
    query_timezone: America/Los_Angeles
    stacking: normal
    color_application:
      collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7
      palette_id: fb7bb53e-b77b-4ab6-8274-9d420d3d73f3
      options:
        steps: 5
    show_value_labels: false
    label_density: 25
    label_color:
    - "#FFFFFF"
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: false
    show_view_names: true
    point_style: none
    series_colors: {}
    series_types: {}
    limit_displayed_rows: false
    hidden_series:
    - Lost - 6 - opportunity.total_amount
    - Under 20% - 5 - opportunity.total_amount
    y_axes:
    - label: Amount in Pipeline
      orientation: left
      series:
      - id: Won - 0 - opportunity.total_amount
        name: Won
        axisId: Won - 0 - opportunity.total_amount
      - id: Above 80% - 1 - opportunity.total_amount
        name: Above 80%
        axisId: Above 80% - 1 - opportunity.total_amount
      - id: 60 - 80% - 2 - opportunity.total_amount
        name: 60 - 80%
        axisId: 60 - 80% - 2 - opportunity.total_amount
      - id: 40 - 60% - 3 - opportunity.total_amount
        name: 40 - 60%
        axisId: 40 - 60% - 3 - opportunity.total_amount
      - id: 20 - 40% - 4 - opportunity.total_amount
        name: 20 - 40%
        axisId: 20 - 40% - 4 - opportunity.total_amount
      - id: Under 20% - 5 - opportunity.total_amount
        name: Under 20%
        axisId: Under 20% - 5 - opportunity.total_amount
      - id: Lost - 6 - opportunity.total_amount
        name: Lost
        axisId: Lost - 6 - opportunity.total_amount
      showLabels: true
      showValues: true
      valueFormat: $0.0,, "M"
      unpinAxis: false
      tickDensity: default
      tickDensityCustom: 5
      type: linear
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    x_axis_label: Opportunity Close Month
    show_x_axis_ticks: true
    x_axis_datetime_label: "%b %y"
    x_axis_scale: ordinal
    y_axis_scale_mode: linear
    label_value_format: ''
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    ordering: none
    show_null_labels: false
    show_totals_labels: true
    show_silhouette: false
    totals_color: "#707070"
    show_null_points: true
    interpolation: linear
    listen:
      Manager: opportunity_owner.manager
      Business Segment: account.business_segment
    row: 18
    col: 12
    width: 12
    height: 10
  - title: Bookings by Geography
    name: Bookings by Geography
    model: sales_analytics
    explore: opportunity
    type: looker_map
    fields:
    - account.billing_state
    - opportunity.total_closed_won_amount
    filters:
      account.billing_country: USA,United States
    limit: 500
    column_limit: 50
    filter_expression: length(${account.billing_state}) = 2
    map_plot_mode: points
    heatmap_gridlines: false
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: light
    map_position: custom
    map_latitude: 38.89103282648846
    map_longitude: -96.9291114807129
    map_zoom: 4
    map_scale_indicator: 'off'
    map_pannable: false
    map_zoomable: false
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: meters
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_view_names: false
    show_legend: true
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    map: usa
    map_projection: ''
    quantize_colors: true
    stacking: ''
    color_application:
      collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7
      palette_id: fb7bb53e-b77b-4ab6-8274-9d420d3d73f3
      options:
        steps: 5
    show_value_labels: true
    label_density: 25
    font_size: '12'
    legend_position: center
    hide_legend: true
    x_axis_gridlines: false
    y_axis_gridlines: true
    point_style: none
    series_colors: {}
    limit_displayed_rows: false
    y_axis_combined: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    y_axis_orientation:
    - left
    - right
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    hidden_fields:
    listen:
      Manager: opportunity_owner.manager
      Business Segment: account.business_segment
    row: 8
    col: 12
    width: 12
    height: 10
  - title: Rep Performance Overview
    name: Rep Performance Overview
    model: sales_analytics
    explore: opportunity
    type: table
    fields:
    - opportunity_owner.name
    - opportunity_owner.days_age
    - opportunity_owner.title
    - opportunity.total_closed_won_amount_ytd
    - opportunity.total_pipeline_amount_ytd
    - account_owner.manager
    filters:
      opportunity_owner.department: Sales
      opportunity_owner.title: Outside AE,AE,Inside AE,Account Executive,MM AE,Commercial
        AE
      opportunity.close_date: this year
    sorts:
    - opportunity.total_closed_won_amount_ytd desc
    limit: 500
    dynamic_fields:
    - table_calculation: quota
      label: Quota
      expression: 'if(${opportunity_owner.title}="Outside AE",500000,if(${opportunity_owner.title}="Inside
        AE",200000,if(${opportunity_owner.title}="MM AE",250000,275000))) '
      value_format:
      value_format_name:
      _kind_hint: dimension
      _type_hint: number
    - table_calculation: ytd
      label: YTD %
      expression: "${opportunity.total_closed_won_amount_ytd}/${quota}"
      value_format:
      value_format_name: percent_0
      _kind_hint: measure
      _type_hint: number
    - table_calculation: gap
      label: Gap
      expression: "${opportunity.total_closed_won_amount_ytd}-${quota}"
      value_format:
      value_format_name: usd_0
      _kind_hint: measure
      _type_hint: number
    - table_calculation: gap_coverage
      label: Gap Coverage
      expression: "${opportunity.total_pipeline_amount_ytd}/${gap}"
      value_format:
      value_format_name: percent_0
      _kind_hint: measure
      _type_hint: number
    query_timezone: America/Los_Angeles
    color_application:
      collection_id: legacy
      palette_id: looker_classic
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    subtotals_at_bottom: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: true
    conditional_formatting:
    - type: along a scale...
      value:
      background_color:
      font_color:
      color_application:
        collection_id: legacy
        palette_id: legacy_diverging1
      bold: false
      italic: false
      strikethrough: false
      fields:
      - ytd
    - type: along a scale...
      value:
      background_color:
      font_color:
      color_application:
        collection_id: legacy
        palette_id: legacy_diverging1
        options:
          steps: 5
          constraints:
            max:
              type: maximum
      bold: false
      italic: false
      strikethrough: false
      fields:
      - gap_coverage
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    listen:
      Manager: opportunity_owner.manager
      Business Segment: account.business_segment
    row: 18
    col: 0
    width: 12
    height: 10
  - title: Customers and Bookings by Segment
    name: Customers and Bookings by Segment
    model: sales_analytics
    explore: opportunity
    type: looker_column
    fields:
    - account.business_segment
    - account.count_customers
    - opportunity.total_closed_won_amount
    filters: {}
    sorts:
    - opportunity.close_month
    - account.business_segment
    - account.business_segment__sort_
    limit: 500
    column_limit: 50
    stacking: ''
    color_application:
      collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7
      palette_id: fb7bb53e-b77b-4ab6-8274-9d420d3d73f3
      options:
        steps: 5
    show_value_labels: true
    label_density: 25
    font_size: '12'
    legend_position: center
    hide_legend: true
    x_axis_gridlines: false
    y_axis_gridlines: false
    show_view_names: false
    point_style: none
    series_colors: {}
    limit_displayed_rows: false
    y_axis_combined: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    y_axis_orientation:
    - left
    - right
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    listen:
      Manager: opportunity_owner.manager
      Business Segment: account.business_segment
    row: 28
    col: 0
    width: 12
    height: 9
  - title: New Customers and Bookings by Source
    name: New Customers and Bookings by Source
    model: sales_analytics
    explore: opportunity
    type: looker_column
    fields:
    - opportunity.source
    - account.count_customers
    - opportunity.total_closed_won_amount
    filters:
      opportunity.type: New Business,Resell,Marketplace
    sorts:
    - account.count_customers desc
    column_limit: 50
    stacking: ''
    color_application:
      collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7
      palette_id: fb7bb53e-b77b-4ab6-8274-9d420d3d73f3
      options:
        steps: 5
    show_value_labels: true
    label_density: 25
    font_size: '12'
    legend_position: center
    hide_legend: true
    x_axis_gridlines: false
    y_axis_gridlines: false
    show_view_names: false
    point_style: none
    series_colors: {}
    limit_displayed_rows: false
    y_axis_combined: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    y_axis_orientation:
    - left
    - right
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    listen:
      Manager: opportunity_owner.manager
      Business Segment: account.business_segment
    row: 28
    col: 12
    width: 12
    height: 9
  - title: Lead To Win Funnel
    name: Lead To Win Funnel
    model: sales_analytics
    explore: lead
    type: looker_funnel
    fields:
    - lead.count
    - lead.converted_to_contact_count
    - opportunity.count_new_business
    - opportunity.count_new_business_won
    filters:
      lead.status: "-%Unqualified%"
      lead.created_date: this quarter
      lead.state: ''
    sorts:
    - lead.count desc
    limit: 500
    column_limit: 50
    leftAxisLabelVisible: false
    leftAxisLabel: ''
    rightAxisLabelVisible: false
    rightAxisLabel: ''
    color_application:
      collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7
      palette_id: fb7bb53e-b77b-4ab6-8274-9d420d3d73f3
      options:
        steps: 5
    smoothedBars: false
    orientation: automatic
    labelPosition: left
    percentType: total
    percentPosition: inline
    valuePosition: right
    labelColorEnabled: false
    labelColor: "#FFF"
    stacking: ''
    show_value_labels: true
    label_density: 10
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    series_labels:
      lead.count: Leads
      opportunity.count_new_business: Opportunities
      opportunity.count_new_business_won: Won Opportunities
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    series_types: {}
    listen:
      Manager: opportunity_owner.manager
      Business Segment: account.business_segment
    row: 8
    col: 0
    width: 12
    height: 10
  filters:
  - name: Manager
    title: Manager
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: sales_analytics
    explore: opportunity
    listens_to_filters: []
    field: opportunity_owner.manager
  - name: Business Segment
    title: Business Segment
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: sales_analytics
    explore: opportunity
    listens_to_filters: []
    field: account.business_segment
