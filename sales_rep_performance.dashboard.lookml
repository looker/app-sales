- dashboard: sales_rep_performance
  title: Sales Rep Performance
  layout: newspaper
  query_timezone: query_saved
  elements:
  - title: Rep Name
    name: Rep Name
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields:
    - opportunity_owner.name
    filters:
      opportunity.close_date: this year
    sorts:
    - opportunity_owner.name
    limit: 1
    column_limit: 50
    font_size: small
    listen:
      Sales Rep: opportunity_owner.name
    row: 0
    col: 0
    width: 24
    height: 3
  - title: Full Funnel for Rep
    name: Full Funnel for Rep
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
      opportunity_owner.name: ''
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
      Sales Rep: account_owner.name
      Sales Segment: opportunity_owner.department_select
    row: 18
    col: 0
    width: 7
    height: 7
  - title: Full Funnel for Rest of Company
    name: Full Funnel for Rest of Company
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
      opportunity_owner.name: ''
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
    listen: {}
    row: 18
    col: 7
    width: 8
    height: 7
  - title: Full Funnel for Rest of Segment
    name: Full Funnel for Rest of Segment
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
      opportunity_owner.name: ''
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
      Sales Segment: opportunity_owner.department_select
    row: 18
    col: 15
    width: 9
    height: 7
  - title: Wins This Quarter
    name: Wins This Quarter
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields:
    - opportunity.count_new_business_won
    filters:
      opportunity.close_date: this quarter
    limit: 500
    font_size: small
    listen:
      Sales Rep: account_owner.name
      Sales Segment: opportunity_owner.department_select
    row: 3
    col: 6
    width: 6
    height: 4
  - title: Pipeline YTD
    name: Pipeline YTD
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields:
    - opportunity_owner.title
    - opportunity.total_pipeline_amount
    - opportunity.total_closed_won_amount_ytd
    filters:
      opportunity.created_date: this quarter
    sorts:
    - opportunity.total_pipeline_amount desc
    limit: 500
    dynamic_fields:
    - table_calculation: gap
      label: Gap
      expression: "${opportunity.total_closed_won_amount_ytd}-${quota}"
      value_format:
      value_format_name: usd_0
      _kind_hint: measure
      _type_hint: number
    - table_calculation: gap_coverage
      label: Gap Coverage
      expression: "${opportunity.total_closed_won_amount_ytd}/${gap}"
      value_format:
      value_format_name: percent_0
      _kind_hint: measure
      _type_hint: number
    - table_calculation: quota
      label: Quota
      expression: 'if(${opportunity_owner.title}="Outside AE",500000,if(${opportunity_owner.title}="Inside
        AE",200000,if(${opportunity_owner.title}="MM AE",250000,275000))) '
      value_format:
      value_format_name: usd_0
      _kind_hint: dimension
      _type_hint: number
    custom_color_enabled: true
    custom_color: ''
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    stacking: ''
    show_value_labels: true
    label_density: 25
    font_size: small
    legend_position: center
    hide_legend: false
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_labels:
    - Total Amount Pipeline
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    show_null_labels: false
    series_types: {}
    hidden_fields:
    - opportunity_owner.title
    - gap
    - quota
    - opportunity.total_closed_won_amount_ytd
    listen:
      Sales Rep: opportunity_owner.name
      Sales Segment: opportunity_owner.department_select
    row: 7
    col: 12
    width: 6
    height: 4
  - title: Projected Wins
    name: Projected Wins
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields:
    - opportunity.probable_wins
    - opportunity.count_new_business_won
    filters:
      opportunity.close_date: this quarter, next quarter
    limit: 500
    column_limit: 50
    dynamic_fields:
    - table_calculation: wins_probable_wins
      label: Wins + Probable Wins
      expression: "${opportunity.probable_wins}+${opportunity.count_new_business_won}"
      value_format:
      value_format_name:
      _kind_hint: measure
      _type_hint: number
    font_size: small
    hidden_fields:
    - opportunity.probable_wins
    - opportunity.count_new_business_won
    listen:
      Sales Rep: opportunity_owner.name
      Sales Segment: opportunity_owner.department_select
    row: 7
    col: 6
    width: 6
    height: 4
  - title: QTD Bookings
    name: QTD Bookings
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields:
    - opportunity.total_closed_won_new_business_amount
    filters:
      opportunity.close_date: this quarter
    limit: 500
    font_size: small
    listen:
      Sales Rep: opportunity_owner.name
      Sales Segment: opportunity_owner.department_select
    row: 3
    col: 0
    width: 6
    height: 4
  - title: Pipeline This Quarter
    name: Pipeline This Quarter
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields:
    - opportunity_owner.title
    - opportunity.total_closed_won_new_business_amount
    - opportunity.total_pipeline_amount
    filters:
      opportunity.created_date: this quarter
    sorts:
    - opportunity.total_pipeline_amount desc
    limit: 500
    dynamic_fields:
    - table_calculation: gap
      label: Gap
      expression: "${opportunity.total_closed_won_new_business_amount}-${quota}"
      value_format:
      value_format_name: usd_0
      _kind_hint: measure
      _type_hint: number
    - table_calculation: gap_coverage
      label: Gap Coverage
      expression: "${opportunity.total_closed_won_new_business_amount}/${gap}"
      value_format:
      value_format_name: percent_0
      _kind_hint: measure
      _type_hint: number
    - table_calculation: quota
      label: Quota
      expression: 'if(${opportunity_owner.title}="Outside AE",500000,if(${opportunity_owner.title}="Inside
        AE",200000,if(${opportunity_owner.title}="MM AE",250000,275000))) '
      value_format:
      value_format_name: usd_0
      _kind_hint: dimension
      _type_hint: number
    custom_color_enabled: true
    custom_color: ''
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    stacking: ''
    show_value_labels: true
    label_density: 25
    font_size: small
    legend_position: center
    hide_legend: false
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_labels:
    - Total Amount Pipeline
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    show_null_labels: false
    series_types: {}
    hidden_fields:
    - opportunity_owner.title
    - gap
    - quota
    - opportunity.total_closed_won_new_business_amount
    listen:
      Sales Rep: opportunity_owner.name
      Sales Segment: opportunity_owner.department_select
    row: 7
    col: 0
    width: 6
    height: 4
  - title: YTD Bookings
    name: YTD Bookings
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields:
    - opportunity.total_closed_won_new_business_amount
    filters:
      opportunity.close_date: this year
    limit: 500
    font_size: small
    listen:
      Sales Rep: account_owner.name
      Sales Segment: opportunity_owner.department_select
    row: 3
    col: 12
    width: 6
    height: 4
  - title: Recent Wins
    name: Recent Wins
    model: sales_analytics
    explore: opportunity
    type: table
    fields:
    - opportunity.name
    - opportunity.total_closed_won_new_business_amount
    filters:
      opportunity.close_date: this quarter
      opportunity.is_won: 'Yes'
      opportunity.type: New Business
    sorts:
    - opportunity.total_closed_won_new_business_amount desc
    limit: 500
    font_size: small
    series_types: {}
    listen:
      Sales Rep: account_owner.name
      Sales Segment: opportunity_owner.department_select
    row: 11
    col: 0
    width: 6
    height: 7
  - title: Total Bookings YTD Comparison
    name: Total Bookings YTD Comparison
    model: sales_analytics
    explore: opportunity
    type: looker_bar
    fields:
    - opportunity.total_closed_won_amount_ytd
    - opportunity_owner.rep_comparitor
    filters:
      opportunity_owner.department: Sales
      opportunity_owner.rep_comparitor: "-2 - Rest of Unknown"
    sorts:
    - opportunity_owner.rep_comparitor
    limit: 500
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    point_style: none
    series_types: {}
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
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    listen:
      Sales Rep: opportunity_owner.name_select
      Sales Segment: opportunity_owner.department_select
    row: 25
    col: 0
    width: 8
    height: 6
  - title: Win Rate Comparison
    name: Win Rate Comparison
    model: sales_analytics
    explore: opportunity
    type: looker_bar
    fields:
    - opportunity_owner.rep_comparitor
    - opportunity.win_percentage
    filters:
      opportunity_owner.rep_comparitor: "-2 - Rest of Unknown"
    sorts:
    - opportunity_owner.rep_comparitor
    limit: 500
    stacking: ''
    show_value_labels: true
    label_density: 25
    font_size: small
    legend_position: center
    hide_legend: false
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    point_style: none
    limit_displayed_rows: false
    y_axes:
    - label: ''
      orientation: bottom
      series:
      - id: opportunity.win_percentage
        name: Win Percentage
        axisId: opportunity.win_percentage
      showLabels: true
      showValues: true
      unpinAxis: false
      tickDensity: default
      type: linear
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_labels:
    - Opportunity Win Rate
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
    listen:
      Sales Rep: opportunity_owner.name_select
      Sales Segment: opportunity_owner.department_select
    row: 25
    col: 8
    width: 8
    height: 6
  - title: Pipeline Amount YTD Comparison
    name: Pipeline Amount YTD Comparison
    model: sales_analytics
    explore: opportunity
    type: looker_bar
    fields:
    - opportunity_owner.rep_comparitor
    - opportunity.total_pipeline_amount_ytd
    filters:
      opportunity_owner.department: Sales
      opportunity_owner.rep_comparitor: "-2 - Rest of Unknown"
    sorts:
    - opportunity_owner.rep_comparitor
    limit: 500
    stacking: ''
    show_value_labels: true
    label_density: 25
    font_size: small
    legend_position: center
    hide_legend: false
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    point_style: none
    limit_displayed_rows: false
    y_axes:
    - label: ''
      orientation: bottom
      series:
      - id: opportunity.total_pipeline_amount_ytd
        name: Total Pipeline Amount Ytd
        axisId: opportunity.total_pipeline_amount_ytd
      showLabels: true
      showValues: true
      unpinAxis: false
      tickDensity: default
      type: linear
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_labels:
    - Opportunity Win Rate
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
    listen:
      Sales Rep: opportunity_owner.name_select
      Sales Segment: opportunity_owner.department_select
    row: 25
    col: 16
    width: 8
    height: 6
  - title: Active Customers
    name: Active Customers
    model: sales_analytics
    explore: opportunity
    type: table
    fields:
    - account.name
    - account.logo64
    - account.business_segment
    - opportunity.close_date
    - opportunity.days_as_customer
    - opportunity.total_amount
    filters:
      account.is_customer: 'Yes'
    sorts:
    - opportunity.total_amount desc
    limit: 50
    column_limit: 50
    font_size: small
    series_types: {}
    listen:
      Sales Rep: opportunity_owner.name
      Sales Segment: opportunity_owner.department_select
    row: 11
    col: 14
    width: 10
    height: 7
  - title: Active Prospects
    name: Active Prospects
    model: sales_analytics
    explore: opportunity
    type: table
    fields:
    - opportunity.name
    - account.business_segment
    - opportunity.probability_group
    - opportunity.total_amount
    filters:
      opportunity.created_date: this quarter
      opportunity.stage_name: "-Closed Won"
    sorts:
    - opportunity.name
    limit: 50
    column_limit: 50
    font_size: small
    series_types: {}
    listen:
      Sales Rep: opportunity_owner.name
      Sales Segment: opportunity_owner.department_select
    row: 11
    col: 6
    width: 8
    height: 7
  - title: "% to Quota (QoQ)"
    name: "% to Quota (QoQ)"
    model: sales_analytics
    explore: opportunity
    type: looker_column
    fields:
    - opportunity.close_quarter
    - opportunity.total_closed_won_amount
    fill_fields:
    - opportunity.close_quarter
    filters:
      opportunity.close_date: 4 quarters
    sorts:
    - opportunity.close_quarter
    limit: 500
    column_limit: 50
    dynamic_fields:
    - table_calculation: quota
      label: Quota
      expression: 400000 + 0*${opportunity.total_closed_won_amount}
      value_format:
      value_format_name: usd_0
      _kind_hint: measure
      _type_hint: number
    - table_calculation: of_quota_met
      label: "% of Quota Met"
      expression: "${opportunity.total_closed_won_amount}/${quota}"
      value_format:
      value_format_name: percent_2
      _kind_hint: measure
      _type_hint: number
    trellis: ''
    stacking: ''
    color_application:
      collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7
      palette_id: fb7bb53e-b77b-4ab6-8274-9d420d3d73f3
      options:
        steps: 5
    show_value_labels: false
    label_density: 25
    font_size: small
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    point_style: circle
    series_colors:
      calculation_3: "#72D16D"
      percent_of_quota_met: "#B1399E"
    series_types:
      calculation_3: line
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
    reference_lines:
    - reference_type: line
      range_start: max
      range_end: min
      margin_top: deviation
      margin_value: mean
      margin_bottom: deviation
      label_position: right
      color: "#000000"
      line_value: '1'
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    hidden_fields:
    - quota
    - opportunity.total_closed_won_amount
    listen:
      Sales Rep: opportunity_owner.name
    row: 3
    col: 18
    width: 6
    height: 8
  filters:
  - name: Sales Rep
    title: Sales Rep
    type: field_filter
    default_value: Kevin Heller
    allow_multiple_values: true
    required: false
    model: sales_analytics
    explore: opportunity
    listens_to_filters: []
    field: opportunity_owner.name_select
  - name: Sales Segment
    title: Sales Segment
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: sales_analytics
    explore: opportunity
    listens_to_filters: []
    field: opportunity_owner.department_select
