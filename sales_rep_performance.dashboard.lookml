- dashboard: sales_rep_performance
  title: Sales Rep Performance
  layout: newspaper
  query_timezone: query_saved
  elements:
  - title: Untitled
    name: Untitled
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields:
    - opportunity.amount
    limit: 1
    dynamic_fields:
    - table_calculation: calculation_1
      label: Calculation 1
      expression: '" "'
      value_format:
      value_format_name:
      _kind_hint: dimension
      _type_hint: string
    custom_color_enabled: true
    custom_color: ''
    show_single_value_title: false
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    show_view_names: 'true'
    hidden_fields:
    - opportunity.amount
    series_types: {}
    row: 16
    col: 11
    width: 2
    height: 12
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
    custom_color_enabled: true
    custom_color: ''
    show_single_value_title: false
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    font_size: small
    listen:
      Sales Rep: opportunity_owner.name
    row: 0
    col: 0
    width: 12
    height: 6
  - title: Lifetime Bookings
    name: Lifetime Bookings
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields:
    - opportunity.total_closed_won_new_business_amount
    limit: 500
    column_limit: 50
    custom_color_enabled: true
    custom_color: ''
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    comparison_label: Opps Won
    font_size: small
    listen:
      Sales Rep: opportunity_owner.name
    row: 0
    col: 12
    width: 5
    height: 3
  - title: Lifetime Customers
    name: Lifetime Customers
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields:
    - opportunity.count_new_business_won
    limit: 5
    column_limit: 50
    custom_color_enabled: true
    custom_color: ''
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    font_size: small
    listen:
      Sales Rep: opportunity_owner.name
    row: 3
    col: 12
    width: 5
    height: 3
  - title: Biggest Wins
    name: Biggest Wins
    model: sales_analytics
    explore: opportunity
    type: looker_bar
    fields:
    - opportunity.name
    - opportunity.total_closed_won_new_business_amount
    - opportunity.days_to_closed_won
    filters:
      opportunity.is_won: 'Yes'
      opportunity.is_new_business: 'Yes'
    sorts:
    - opportunity.total_closed_won_new_business_amount desc
    limit: 5
    trellis: ''
    stacking: ''
    color_application:
      collection_id: 5f313589-67ce-44ba-b084-ec5107a7bb7e
      custom:
        id: a168681c-ceaf-aafc-f70f-cb3109b3c060
        label: Custom
        type: continuous
        stops:
        - color: "#462C9D"
          offset: 0
        - color: "#462C9D"
          offset: 100
      options:
        steps: 5
    show_value_labels: true
    label_density: 25
    font_size: small
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    point_style: none
    series_colors:
      opportunity.total_closed_won_new_business_amount: "#462C9D"
    series_types: {}
    limit_displayed_rows: false
    y_axes:
    - label: ''
      orientation: left
      series:
      - id: opportunity.total_closed_won_new_business_amount
        name: 'Closed Won ACV '
        axisId: opportunity.total_closed_won_new_business_amount
      showLabels: false
      showValues: false
      unpinAxis: false
      tickDensity: default
      tickDensityCustom: 5
      type: linear
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
    show_row_numbers: true
    truncate_column_names: false
    subtotals_at_bottom: false
    hide_totals: false
    hide_row_totals: false
    table_theme: white
    enable_conditional_formatting: false
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
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    hidden_fields:
    - opportunity.days_to_closed_won
    listen:
      Sales Rep: opportunity_owner.name
    row: 0
    col: 17
    width: 7
    height: 6
  - title: Revenue YTD
    name: Revenue YTD
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields:
    - opportunity.total_closed_won_new_business_amount
    - quota_numbers.quota_amount
    filters:
      opportunity.close_date: this year
    sorts:
    - opportunity.total_closed_won_new_business_amount desc
    limit: 500
    custom_color_enabled: true
    custom_color: ''
    show_single_value_title: true
    show_comparison: true
    comparison_type: progress_percentage
    comparison_reverse_colors: false
    show_comparison_label: true
    comparison_label: Quota
    font_size: small
    series_types: {}
    hidden_fields: []
    listen:
      Sales Rep: opportunity_owner.name
    row: 11
    col: 0
    width: 6
    height: 5
  - title: Pipeline QTD
    name: Pipeline QTD
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields:
    - quota_numbers.quarterly_quota
    - opportunity.total_pipeline_new_business_amount
    - opportunity.total_closed_won_new_business_amount
    filters:
      opportunity.close_date: this quarter
    sorts:
    - opportunity.total_pipeline_new_business_amount desc
    limit: 500
    dynamic_fields:
    - table_calculation: gap
      label: Gap
      expression: "${quota_numbers.quarterly_quota} - ${opportunity.total_closed_won_new_business_amount}"
      value_format: '[>=1000000]$0.00,,"M";[>=1000]$0,"K";$0.00'
      value_format_name:
      _kind_hint: measure
      _type_hint: number
    custom_color_enabled: true
    custom_color: ''
    show_single_value_title: true
    show_comparison: true
    comparison_type: progress_percentage
    comparison_reverse_colors: false
    show_comparison_label: true
    comparison_label: Gap
    show_view_names: 'true'
    hidden_fields:
    - opportunity.total_closed_won_new_business_amount
    listen:
      Sales Rep: opportunity_owner.name
    row: 6
    col: 6
    width: 6
    height: 5
  - title: "% to Quota (QoQ)"
    name: "% to Quota (QoQ)"
    model: sales_analytics
    explore: opportunity
    type: looker_column
    fields:
    - opportunity.close_quarter
    - quota_numbers.quarterly_quota
    - opportunity.total_closed_won_amount
    filters:
      opportunity.close_date: 4 quarters
    sorts:
    - opportunity.close_quarter
    limit: 500
    column_limit: 50
    total: true
    dynamic_fields:
    - table_calculation: gap
      label: Gap
      expression: "${quota_numbers.quarterly_quota}-${opportunity.total_closed_won_amount}"
      value_format:
      value_format_name:
      _kind_hint: measure
      _type_hint: number
    - table_calculation: won
      label: Won
      expression: if( is_null(${over}),${quota}-${under},${quota})
      value_format:
      value_format_name:
      _kind_hint: measure
      _type_hint: number
    - table_calculation: over
      label: Over
      expression: if(${gap}<0,abs(${gap}),null)
      value_format:
      value_format_name:
      _kind_hint: measure
      _type_hint: number
    - table_calculation: under
      label: Under
      expression: if(${gap}>0,abs(${gap}),null)
      value_format:
      value_format_name:
      _kind_hint: measure
      _type_hint: number
    - table_calculation: quota
      label: Quota
      expression: "${quota_numbers.quarterly_quota}+${opportunity.total_closed_won_amount}*0"
      value_format:
      value_format_name:
      _kind_hint: measure
      _type_hint: number
    trellis: ''
    stacking: normal
    color_application:
      collection_id: 5f313589-67ce-44ba-b084-ec5107a7bb7e
      palette_id: be92eae7-de25-46ae-8e4f-21cb0b69a1f3
      options:
        steps: 5
    show_value_labels: false
    label_density: 25
    font_size: small
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    point_style: circle
    series_colors:
      won: "#C4E9D8"
      over: "#81eb99"
      under: "#F7968D"
    series_types:
      calculation_3: line
      of_quota_met: line
      quota_measure: line
      quota: line
    series_point_styles:
      quota_measure: square
    limit_displayed_rows: false
    y_axes:
    - label: ''
      orientation: left
      series:
      - id: won
        name: Won
        axisId: won
      - id: over
        name: Over
        axisId: over
      - id: under
        name: Under
        axisId: under
      - id: quota
        name: Quota
        axisId: quota
      showLabels: false
      showValues: false
      unpinAxis: false
      tickDensity: default
      type: linear
    - label: ''
      orientation: left
      series:
      - id: of_quota_met
        name: "% of Quota Met"
        axisId: of_quota_met
      showLabels: true
      showValues: true
      unpinAxis: false
      tickDensity: default
      type: linear
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    label_value_format: '[>=1000000]$0.00,,"M";[>=1000]$0.00,"K";$0.00'
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    reference_lines: []
    ordering: none
    show_null_labels: false
    show_totals_labels: true
    show_silhouette: false
    totals_color: "#808080"
    hidden_fields:
    - opportunity.total_closed_won_revenue
    - quota_numbers.quarterly_quota
    - gap
    - opportunity.total_closed_won_amount
    listen:
      Sales Rep: opportunity_owner.name
    row: 6
    col: 12
    width: 12
    height: 10
  - title: Revenue QTD
    name: Revenue QTD
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields:
    - opportunity.total_closed_won_new_business_amount
    - quota_numbers.quarterly_quota
    filters:
      opportunity.close_date: this quarter
    sorts:
    - opportunity.total_closed_won_new_business_amount desc
    limit: 500
    custom_color_enabled: true
    custom_color: ''
    show_single_value_title: true
    show_comparison: true
    comparison_type: progress_percentage
    comparison_reverse_colors: false
    show_comparison_label: true
    comparison_label: Quota
    font_size: small
    series_types: {}
    hidden_fields: []
    listen:
      Sales Rep: opportunity_owner.name
    row: 6
    col: 0
    width: 6
    height: 5
  - title: Pipeline YTD
    name: Pipeline YTD
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields:
    - quota_numbers.quota_amount
    - opportunity.total_closed_won_new_business_amount
    - opportunity.total_pipeline_new_business_amount
    filters:
      opportunity.close_date: this year
    sorts:
    - opportunity.total_pipeline_new_business_amount desc
    limit: 500
    dynamic_fields:
    - table_calculation: gap
      label: Gap
      expression: "${quota_numbers.quota_amount} - ${opportunity.total_closed_won_new_business_amount}"
      value_format: '[>=1000000]$0.00,,"M";[>=1000]$0,"K";$0.00'
      value_format_name:
      _kind_hint: measure
      _type_hint: number
    custom_color_enabled: true
    custom_color: ''
    show_single_value_title: true
    show_comparison: true
    comparison_type: progress_percentage
    comparison_reverse_colors: false
    show_comparison_label: true
    comparison_label: ''
    show_view_names: 'true'
    hidden_fields:
    - opportunity.total_closed_won_new_business_amount
    - quota_numbers.quota_amount
    listen:
      Sales Rep: opportunity_owner.name
    row: 11
    col: 6
    width: 6
    height: 5
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
    - opportunity.total_closed_won_amount
    filters:
      account.is_customer: 'Yes'
      opportunity.close_date: before 0 minutes ago
    sorts:
    - opportunity.close_date desc
    limit: 50
    column_limit: 50
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    subtotals_at_bottom: false
    hide_totals: false
    hide_row_totals: false
    series_labels:
      account.logo64: Logo
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    font_size: small
    series_types: {}
    listen:
      Sales Rep: opportunity_owner.name
    row: 16
    col: 13
    width: 11
    height: 12
  - title: Active Opportunities
    name: Active Opportunities
    model: sales_analytics
    explore: opportunity
    type: table
    fields:
    - opportunity.name
    - opportunity.id_url
    - account.logo64
    - opportunity.created_date
    - opportunity.next_step
    - opportunity.stage_name
    - opportunity.days_open
    - opportunity.total_amount
    filters:
      opportunity.is_renewal_upsell: 'No'
      opportunity.is_closed: 'No'
    sorts:
    - opportunity.name
    limit: 50
    column_limit: 50
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    subtotals_at_bottom: false
    hide_totals: false
    hide_row_totals: false
    series_labels:
      account.logo64: Logo
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    font_size: small
    series_types: {}
    listen:
      Sales Rep: opportunity_owner.name
    row: 16
    col: 0
    width: 11
    height: 12
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
