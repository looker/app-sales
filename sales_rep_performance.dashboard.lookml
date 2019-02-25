- dashboard: sales_rep_performance
  title: Sales Rep Performance
  layout: newspaper
  query_timezone: query_saved
  elements:
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
      Sales Rep: opportunity_owner.name
      Sales Segment: opportunity_owner.department_select
    row: 3
    col: 6
    width: 6
    height: 4
  - title: QTD Revenue
    name: QTD Revenue
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
    - opportunity.total_pipeline_amount
    - opportunity_owner.name
    - quota_numbers.quarterly_quota
    - opportunity.total_new_closed_won_amount_qtd
    filters:
      opportunity.created_date: this quarter
      opportunity_owner.is_sales_rep: 'Yes'
    sorts:
    - opportunity.total_new_closed_won_amount_qtd desc
    limit: 500
    dynamic_fields:
    - table_calculation: gap
      label: Gap
      expression: if(${quota_numbers.quarterly_quota}-${opportunity.total_new_closed_won_amount_qtd}
        > 0, ${quota_numbers.quarterly_quota}-${opportunity.total_new_closed_won_amount_qtd},
        0)
      value_format:
      value_format_name: usd_0
      _kind_hint: measure
      _type_hint: number
    - table_calculation: gap_coverage
      label: Gap Coverage
      expression: "${opportunity.total_pipeline_amount}/${gap}"
      value_format:
      value_format_name: percent_0
      _kind_hint: measure
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
    - Total Revenue Pipeline
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    show_null_labels: false
    series_types: {}
    hidden_fields:
    - gap
    - opportunity.total_closed_won_new_business_revenue
    - quota_numbers.quarterly_quota
    - opportunity_owner.name
    - opportunity.total_pipeline_amount
    listen:
      Sales Rep: opportunity_owner.name
      Sales Segment: opportunity_owner.department_select
    row: 7
    col: 0
    width: 6
    height: 4
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
  - title: YTD Revenue
    name: YTD Revenue
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
      Sales Rep: opportunity_owner.name
      Sales Segment: opportunity_owner.department_select
    row: 3
    col: 12
    width: 6
    height: 4
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
      Sales Segment: opportunity_owner.department_select
    row: 18
    col: 16
    width: 8
    height: 7
  - title: Recent Wins
    name: Recent Wins
    model: sales_analytics
    explore: opportunity
    type: table
    fields:
    - opportunity.name
    - opportunity.total_closed_won_new_business_amount
    - opportunity.days_to_closed_won
    filters:
      opportunity.close_date: last 90 days
      opportunity.is_won: 'Yes'
      opportunity.is_new_business: 'Yes'
    sorts:
    - opportunity.total_closed_won_new_business_amount desc
    limit: 500
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    subtotals_at_bottom: false
    hide_totals: false
    hide_row_totals: false
    table_theme: white
    limit_displayed_rows: false
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
    font_size: small
    series_types: {}
    listen:
      Sales Rep: opportunity_owner.name
      Sales Segment: opportunity_owner.department_select
    row: 18
    col: 0
    width: 8
    height: 7
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
      collection_id: 5f313589-67ce-44ba-b084-ec5107a7bb7e
      palette_id: be92eae7-de25-46ae-8e4f-21cb0b69a1f3
      options:
        steps: 5
    smoothedBars: true
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
      Sales Rep: lead_owner.name
      Sales Segment: opportunity_owner.department_select
    row: 32
    col: 0
    width: 8
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
      collection_id: 5f313589-67ce-44ba-b084-ec5107a7bb7e
      palette_id: be92eae7-de25-46ae-8e4f-21cb0b69a1f3
      options:
        steps: 5
    smoothedBars: true
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
    row: 32
    col: 8
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
      collection_id: 5f313589-67ce-44ba-b084-ec5107a7bb7e
      palette_id: be92eae7-de25-46ae-8e4f-21cb0b69a1f3
      options:
        steps: 5
    smoothedBars: true
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
      Sales Segment: account.business_segment
    row: 32
    col: 16
    width: 8
    height: 7
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
    trellis: ''
    stacking: ''
    color_application:
      collection_id: 5f313589-67ce-44ba-b084-ec5107a7bb7e
      palette_id: be92eae7-de25-46ae-8e4f-21cb0b69a1f3
      options:
        steps: 5
    show_value_labels: true
    label_density: 25
    font_size: small
    legend_position: center
    hide_legend: false
    x_axis_gridlines: false
    y_axis_gridlines: false
    show_view_names: false
    point_style: none
    series_colors: {}
    limit_displayed_rows: false
    y_axes:
    - label: ''
      orientation: bottom
      series:
      - id: opportunity.win_percentage
        name: Win Percentage
        axisId: opportunity.win_percentage
      showLabels: false
      showValues: false
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
    height: 7
  - title: Total Revenue YTD Comparison
    name: Total Revenue YTD Comparison
    model: sales_analytics
    explore: opportunity
    type: looker_bar
    fields:
    - opportunity_owner.rep_comparitor
    - opportunity.total_closed_won_amount_ytd
    filters:
      opportunity_owner.department: Sales
      opportunity_owner.rep_comparitor: "-2 - Rest of Unknown"
    sorts:
    - opportunity_owner.rep_comparitor
    limit: 500
    trellis: ''
    stacking: ''
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
    series_colors:
      opportunity.total_closed_won_amount_ytd: "#D978A1"
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
    height: 7
  - title: Pipeline Revenue YTD Comparison
    name: Pipeline Revenue YTD Comparison
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
    trellis: ''
    stacking: ''
    color_application:
      collection_id: 5f313589-67ce-44ba-b084-ec5107a7bb7e
      palette_id: be92eae7-de25-46ae-8e4f-21cb0b69a1f3
      options:
        steps: 5
    show_value_labels: true
    label_density: 25
    font_size: small
    legend_position: center
    hide_legend: false
    x_axis_gridlines: false
    y_axis_gridlines: false
    show_view_names: false
    point_style: none
    series_colors:
      opportunity.total_pipeline_amount_ytd: "#FDA08A"
    limit_displayed_rows: false
    y_axes:
    - label: ''
      orientation: bottom
      series:
      - id: opportunity.total_pipeline_amount_ytd
        name: Pipeline ACV  YTD
        axisId: opportunity.total_pipeline_amount_ytd
      showLabels: false
      showValues: false
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
    height: 7
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
      expression: 400000 + 0.8*${opportunity.total_closed_won_amount}
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
      collection_id: 5f313589-67ce-44ba-b084-ec5107a7bb7e
      palette_id: be92eae7-de25-46ae-8e4f-21cb0b69a1f3
      options:
        steps: 5
    show_value_labels: true
    label_density: 25
    font_size: small
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    point_style: circle
    series_colors:
      opportunity.total_closed_won_amount: "#C762AD"
      of_quota_met: "#683AAE"
    series_types:
      calculation_3: line
      of_quota_met: line
    limit_displayed_rows: false
    y_axes:
    - label: ''
      orientation: left
      series:
      - id: opportunity.total_closed_won_amount
        name: 'Total Closed Won Amount '
        axisId: opportunity.total_closed_won_amount
      showLabels: false
      showValues: false
      unpinAxis: false
      tickDensity: default
      tickDensityCustom: 5
      type: linear
    - label:
      orientation: right
      series:
      - id: of_quota_met
        name: "% of Quota Met"
        axisId: of_quota_met
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
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    reference_lines: []
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    hidden_fields:
    - quota
    - opportunity.total_closed_won_revenue
    listen:
      Sales Rep: opportunity_owner.name
    row: 3
    col: 18
    width: 6
    height: 8
  - title: Pipeline YTD
    name: Pipeline YTD
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields:
    - opportunity_owner.name
    - opportunity.total_closed_won_amount_ytd
    - opportunity.total_pipeline_amount
    - quota_numbers.quota_amount
    filters:
      opportunity.created_date: this year
    sorts:
    - opportunity.total_closed_won_amount_ytd desc
    limit: 500
    dynamic_fields:
    - table_calculation: gap
      label: Gap
      expression: if((${quota_numbers.quota_amount}-${opportunity.total_closed_won_amount_ytd})>0,${quota_numbers.quota_amount}-${opportunity.total_closed_won_amount_ytd},0)
      value_format:
      value_format_name: usd_0
      _kind_hint: measure
      _type_hint: number
    - table_calculation: gap_coverage
      label: Gap Coverage
      expression: "${opportunity.total_pipeline_amount}/${gap}"
      value_format:
      value_format_name: percent_0
      _kind_hint: measure
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
    - Total Revenue Pipeline
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    show_null_labels: false
    series_types: {}
    hidden_fields:
    - gap
    - opportunity.total_closed_won_revenue_ytd
    - opportunity.total_closed_won_amount_ytd
    listen:
      Sales Rep: opportunity_owner.name
      Sales Segment: opportunity_owner.department_select
    row: 7
    col: 12
    width: 6
    height: 4
  - title: Open Opportunities
    name: Open Opportunities
    model: sales_analytics
    explore: opportunity
    type: looker_bar
    fields:
    - opportunity.custom_stage_name
    - opportunity.count_open
    pivots:
    - opportunity.custom_stage_name
    filters:
      opportunity.custom_stage_name: "-Unknown,-Closed Won"
    sorts:
    - opportunity.custom_stage_name
    limit: 500
    query_timezone: America/Los_Angeles
    trellis: ''
    stacking: normal
    color_application:
      collection_id: 5f313589-67ce-44ba-b084-ec5107a7bb7e
      palette_id: b20fe57d-cb13-420f-815b-60e907a43148
      options:
        steps: 5
    show_value_labels: true
    label_density: 25
    legend_position: left
    hide_legend: false
    x_axis_gridlines: false
    y_axis_gridlines: false
    show_view_names: false
    point_style: none
    series_colors: {}
    series_types: {}
    limit_displayed_rows: false
    y_axes:
    - label: ''
      orientation: bottom
      series:
      - id: Validate - 0 - opportunity.count_open
        name: Validate
        axisId: Validate - 0 - opportunity.count_open
      - id: Qualify - 1 - opportunity.count_open
        name: Qualify
        axisId: Qualify - 1 - opportunity.count_open
      - id: Develop - 2 - opportunity.count_open
        name: Develop
        axisId: Develop - 2 - opportunity.count_open
      - id: Develop Positive - 3 - opportunity.count_open
        name: Develop Positive
        axisId: Develop Positive - 3 - opportunity.count_open
      - id: Negotiate - 4 - opportunity.count_open
        name: Negotiate
        axisId: Negotiate - 4 - opportunity.count_open
      - id: Sales Submitted - 5 - opportunity.count_open
        name: Sales Submitted
        axisId: Sales Submitted - 5 - opportunity.count_open
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
    x_axis_label: Open Opportunities
    show_x_axis_ticks: false
    x_axis_scale: ordinal
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
      Sales Rep: opportunity_owner.name
    row: 11
    col: 0
    width: 12
    height: 7
  - title: Open Opportunity Amount
    name: Open Opportunity Amount
    model: sales_analytics
    explore: opportunity
    type: looker_bar
    fields:
    - opportunity.total_pipeline_amount
    - opportunity.custom_stage_name
    pivots:
    - opportunity.custom_stage_name
    filters:
      opportunity.custom_stage_name: "-Unknown,-Closed Won"
    sorts:
    - opportunity.custom_stage_name
    limit: 500
    query_timezone: America/Los_Angeles
    trellis: ''
    stacking: normal
    color_application:
      collection_id: 5f313589-67ce-44ba-b084-ec5107a7bb7e
      palette_id: b20fe57d-cb13-420f-815b-60e907a43148
      options:
        steps: 5
    show_value_labels: true
    label_density: 25
    legend_position: left
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    point_style: none
    series_colors: {}
    series_types: {}
    limit_displayed_rows: false
    hidden_series:
    - Closed Lost - opportunity.total_pipeline_amount
    y_axes:
    - label: ''
      orientation: bottom
      series:
      - id: Develop - opportunity.total_pipeline_amount
        name: Develop
        axisId: Develop - opportunity.total_pipeline_amount
      - id: Develop Positive - opportunity.total_pipeline_amount
        name: Develop Positive
        axisId: Develop Positive - opportunity.total_pipeline_amount
      - id: Negotiate - opportunity.total_pipeline_amount
        name: Negotiate
        axisId: Negotiate - opportunity.total_pipeline_amount
      - id: Qualify - opportunity.total_pipeline_amount
        name: Qualify
        axisId: Qualify - opportunity.total_pipeline_amount
      - id: Qualify Renewal - opportunity.total_pipeline_amount
        name: Qualify Renewal
        axisId: Qualify Renewal - opportunity.total_pipeline_amount
      - id: Validate - opportunity.total_pipeline_amount
        name: Validate
        axisId: Validate - opportunity.total_pipeline_amount
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
    show_x_axis_ticks: false
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: true
    totals_color: "#3a3080"
    listen:
      Sales Rep: opportunity_owner.name
    row: 11
    col: 12
    width: 12
    height: 7
  - title: My Active Leads
    name: My Active Leads
    model: sales_analytics
    explore: lead
    type: table
    fields:
    - lead.created_date
    - lead.name
    - lead.email
    - lead.phone
    - lead.last_activity_date
    - task.calls
    - task.emails
    - task.meetings
    filters:
      lead.is_converted: 'No'
    limit: 500
    query_timezone: America/Los_Angeles
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    subtotals_at_bottom: false
    hide_totals: false
    hide_row_totals: false
    series_labels:
      lead.created_date: Lead Created Date
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    listen:
      Sales Rep: lead_owner.name
    row: 39
    col: 0
    width: 24
    height: 7
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
    row: 18
    col: 8
    width: 8
    height: 7
  - name: Conversion Rate over time
    title: Conversion Rate over time
    merged_queries:
    - model: sales_analytics
      explore: opportunity
      type: looker_area
      fields:
      - opportunity.close_quarter
      - opportunity.win_percentage
      fill_fields:
      - opportunity.close_quarter
      filters:
        opportunity.close_quarter: 8 quarters
        opportunity.is_new_business: 'Yes'
      sorts:
      - opportunity.close_quarter
      limit: 500
      query_timezone: UTC
      series_types: {}
    - model: sales_analytics
      explore: opportunity
      type: table
      fields:
      - opportunity.close_quarter
      - opportunity.win_percentage
      fill_fields:
      - opportunity.close_quarter
      filters:
        opportunity.close_quarter: 8 quarters
        opportunity.is_new_business: 'Yes'
      sorts:
      - opportunity.close_quarter desc
      limit: 500
      query_timezone: UTC
      join_fields:
      - source_field_name: opportunity.close_quarter
        field_name: opportunity.close_quarter
    trellis: ''
    stacking: ''
    color_application:
      collection_id: 5f313589-67ce-44ba-b084-ec5107a7bb7e
      palette_id: be92eae7-de25-46ae-8e4f-21cb0b69a1f3
      options:
        steps: 5
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    point_style: none
    series_colors: {}
    series_labels:
      opportunity.win_percentage: Individual Rep – Win Rate
      q1_opportunity.win_percentage: Rest of the Company – Win Rate
    series_types: {}
    limit_displayed_rows: false
    hidden_series: []
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
    type: looker_area
    listen:
    - Sales Rep: opportunity_owner.name
    -
    row: 46
    col: 0
    width: 24
    height: 7
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
