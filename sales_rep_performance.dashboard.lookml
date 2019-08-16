- dashboard: sales_rep_performance
  title: Sales Rep Performance
  extends: sales_analytics_base
  embed_style:
    background_color: "#ffffff"
    title_color: "#3a4245"
    tile_text_color: "#3a4245"
    text_tile_text_color: ''
  elements:
  - title: Rep Name
    name: Rep Name
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields: [opportunity_owner.name]
    sorts: [opportunity_owner.name]
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
    width: 24
    height: 2
  - title: Pipeline (QTD)
    name: Pipeline (QTD)
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields: [opportunity.total_pipeline_new_business_amount, opportunity.total_closed_won_new_business_amount,
      opportunity_owner.name, quota.quota_amount]
    filters:
      opportunity.close_date: this fiscal quarter
      quota.quota_amount: NOT NULL
    sorts: [opportunity.total_pipeline_new_business_amount desc]
    limit: 500
    dynamic_fields: [{table_calculation: gap, label: Gap, expression: 'if((${quota.quota_amount}
          - ${opportunity.total_closed_won_new_business_amount}) < 0,"Quota Reached,
          No",to_string(${quota.quota_amount} - ${opportunity.total_closed_won_new_business_amount}))',
        value_format: '[>=1000000]$0.00,,"M";[>=1000]$0,"K";$0.00', value_format_name: !!null '',
        _kind_hint: measure, _type_hint: string}]
    custom_color_enabled: true
    custom_color: ''
    show_single_value_title: true
    show_comparison: true
    comparison_type: progress_percentage
    comparison_reverse_colors: false
    show_comparison_label: true
    comparison_label: Gap
    show_view_names: 'true'
    hidden_fields: [opportunity.total_closed_won_new_business_amount, quota.quota_amount]
    listen:
      Sales Rep: opportunity_owner.name
    row: 2
    col: 4
    width: 4
    height: 4
  - title: Lifetime Bookings
    name: Lifetime Bookings
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields: [opportunity.total_closed_won_new_business_amount]
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
    row: 2
    col: 8
    width: 4
    height: 4
  - title: Current Customers
    name: Current Customers
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields: [account.count_customers]
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
    row: 6
    col: 8
    width: 4
    height: 4
  - title: Pipeline (YTD)
    name: Pipeline (YTD)
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields: [opportunity.total_closed_won_new_business_amount, opportunity.total_pipeline_new_business_amount,
      quota.yearly_quota]
    filters:
      opportunity.close_date: this fiscal year
      quota.quota_amount: NOT NULL
    sorts: [opportunity.total_pipeline_new_business_amount desc]
    limit: 500
    dynamic_fields: [{table_calculation: gap, label: Gap, expression: 'if((${quota.yearly_quota}
          - ${opportunity.total_closed_won_new_business_amount}) < 0,"Reached Quota,
          No",to_string(round((${quota.yearly_quota} - ${opportunity.total_closed_won_new_business_amount}),
          0)))

          ', value_format: '[>=1000000]$0.00,,"M";[>=1000]$0,"K";$0.00', value_format_name: !!null '',
        _kind_hint: measure, _type_hint: string}]
    custom_color_enabled: true
    custom_color: ''
    show_single_value_title: true
    show_comparison: true
    comparison_type: progress_percentage
    comparison_reverse_colors: false
    show_comparison_label: true
    comparison_label: ''
    show_view_names: 'true'
    hidden_fields: [opportunity.total_closed_won_new_business_amount, quota_numbers.quota_amount]
    listen:
      Sales Rep: opportunity_owner.name
    row: 6
    col: 4
    width: 4
    height: 4
  - title: Bookings (YTD)
    name: Bookings (YTD)
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields: [opportunity.total_closed_won_new_business_amount, quota.yearly_quota]
    filters:
      opportunity.close_date: this fiscal year
    sorts: [opportunity.total_closed_won_new_business_amount desc]
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
    width: 4
    height: 4
  - title: Stage Conversion Rates
    name: Stage Conversion Rates
    model: sales_analytics
    explore: opportunity
    type: looker_column
    fields: [opportunity_stage_history.stage, opportunity_stage_history.opps_in_each_stage,
      segment_lookup.grouping]
    pivots: [segment_lookup.grouping]
    filters:
      opportunity.is_renewal_upsell: 'No'
      opportunity_stage_history.stage: "-NULL"
    sorts: [segment_lookup.grouping 0, opportunity_stage_history.stage]
    limit: 20
    dynamic_fields: [{table_calculation: conversion_rates, label: Conversion Rates,
        expression: "${opportunity_stage_history.opps_in_each_stage}/ offset(${opportunity_stage_history.opps_in_each_stage},\
          \ -1)", value_format: !!null '', value_format_name: percent_0, _kind_hint: measure,
        _type_hint: number}]
    color_application:
      collection_id: 5f313589-67ce-44ba-b084-ec5107a7bb7e
      palette_id: 04e6ee8f-6a09-4649-891f-5bc66082e506
      options:
        steps: 5
        reverse: false
        __FILE: app-sales/sales_rep_performance.dashboard.lookml
        __LINE_NUM: 312
    x_axis_gridlines: false
    y_axis_gridlines: false
    show_view_names: false
    y_axes: [{label: '', orientation: left, series: [{id: Kevin Heller - 1 - conversion_rates,
            name: Kevin Heller, axisId: conversion_rates, __FILE: app-sales/sales_rep_performance.dashboard.lookml,
            __LINE_NUM: 319}, {id: Rest of Named Accounts - 2 - conversion_rates,
            name: Rest of Named Accounts, axisId: conversion_rates, __FILE: app-sales/sales_rep_performance.dashboard.lookml,
            __LINE_NUM: 321}, {id: Rest of Company - 3 - conversion_rates, name: Rest
              of Company, axisId: conversion_rates, __FILE: app-sales/sales_rep_performance.dashboard.lookml,
            __LINE_NUM: 323}], showLabels: false, showValues: false, unpinAxis: false,
        tickDensity: default, type: linear, __FILE: app-sales/sales_rep_performance.dashboard.lookml,
        __LINE_NUM: 319}]
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
    limit_displayed_rows: false
    limit_displayed_rows_values:
      show_hide: hide
      first_last: first
      num_rows: '1'
    legend_position: center
    point_style: none
    series_colors: {}
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    hidden_fields: [opportunity_stage_history.opps_in_each_stage]
    listen:
      Sales Rep: opportunity_owner.name_select
    row: 18
    col: 0
    width: 12
    height: 8
  - title: Bookings by Stage
    name: Bookings by Stage
    model: sales_analytics
    explore: opportunity
    type: looker_column
    fields: [segment_lookup.grouping, opportunity.average_new_deal_size, opportunity_stage_history.stage]
    pivots: [segment_lookup.grouping]
    filters:
      opportunity_stage_history.stage: "-NULL"
    sorts: [segment_lookup.grouping 0, opportunity_stage_history.stage]
    limit: 500
    column_limit: 3
    dynamic_fields: [{table_calculation: avg_new_deal_size, label: Avg New Deal Size,
        expression: 'if(is_null(${opportunity.average_new_deal_size}),0,${opportunity.average_new_deal_size})',
        value_format: '[>=1000000]$0.00,,"M";[>=1000]$0,"K";$0.00', value_format_name: !!null '',
        _kind_hint: measure, _type_hint: number}]
    stacking: ''
    trellis: ''
    color_application:
      collection_id: 5f313589-67ce-44ba-b084-ec5107a7bb7e
      custom:
        id: 3d22e0c3-cdc8-5f98-a391-a8a6410a165e
        label: Custom
        type: discrete
        colors:
        - "#BB55B4"
        - "#8643B1"
        - "#462C9D"
        __FILE: app-sales/sales_rep_performance.dashboard.lookml
        __LINE_NUM: 385
      options:
        steps: 5
        reverse: false
        __FILE: app-sales/sales_rep_performance.dashboard.lookml
        __LINE_NUM: 395
    show_value_labels: true
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: false
    show_view_names: false
    point_style: none
    series_colors:
      Kevin Heller - 1 - avg_new_deal_size: "#9f92cb"
      Rest of Named Accounts - 2 - avg_new_deal_size: "#735eae"
      Rest of Company - 3 - avg_new_deal_size: "#462c9d"
    series_types: {}
    limit_displayed_rows: false
    y_axes: [{label: '', orientation: left, series: [{id: Henry Crawford - 1 - avg_new_deal_size,
            name: Henry Crawford, axisId: avg_new_deal_size, __FILE: app-sales/sales_rep_performance.dashboard.lookml,
            __LINE_NUM: 412}, {id: Jeff De La Cruz - 1 - avg_new_deal_size, name: Jeff
              De La Cruz, axisId: avg_new_deal_size, __FILE: app-sales/sales_rep_performance.dashboard.lookml,
            __LINE_NUM: 414}, {id: Jean Louise Manalo - 1 - avg_new_deal_size, name: Jean
              Louise Manalo, axisId: avg_new_deal_size, __FILE: app-sales/sales_rep_performance.dashboard.lookml,
            __LINE_NUM: 416}], showLabels: false, showValues: false, unpinAxis: false,
        tickDensity: default, type: linear, __FILE: app-sales/sales_rep_performance.dashboard.lookml,
        __LINE_NUM: 412}]
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
    hidden_fields: [opportunity.average_new_deal_size]
    listen:
      Sales Rep: opportunity_owner.name_select
    row: 18
    col: 12
    width: 12
    height: 8
  - title: Bookings (QTD)
    name: Bookings (QTD)
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields: [opportunity.total_closed_won_new_business_amount, quota.quota_amount,
      quota.quota_start_date]
    filters:
      opportunity.close_date: this fiscal quarter
    sorts: [opportunity.total_closed_won_new_business_amount desc]
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
    y_axes: []
    listen:
      Sales Rep: opportunity_owner.name
    row: 2
    col: 0
    width: 4
    height: 4
  - title: "% to Quota (QoQ)"
    name: "% to Quota (QoQ)"
    model: sales_analytics
    explore: opportunity
    type: looker_column
    fields: [opportunity.close_fiscal_quarter, opportunity.total_closed_won_amount,
      quota.quota_amount]
    filters:
      opportunity.close_fiscal_quarter: 4 fiscal quarters
    sorts: [opportunity.close_fiscal_quarter]
    limit: 50
    column_limit: 50
    total: true
    dynamic_fields: [{table_calculation: gap, label: Gap, expression: "${quota.quota_amount}-${opportunity.total_closed_won_amount}",
        value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
        _type_hint: number}, {table_calculation: won, label: Won, expression: 'if(
          is_null(${over}),${quota}-${under},${quota})', value_format: !!null '',
        value_format_name: !!null '', _kind_hint: measure, _type_hint: number}, {
        table_calculation: over, label: Over, expression: 'if(${gap}<0,abs(${gap}),null)',
        value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
        _type_hint: number}, {table_calculation: under, label: Under, expression: 'if(${gap}>0,abs(${gap}),null)',
        value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
        _type_hint: number}, {table_calculation: quota, label: Quota, expression: "${quota.quota_amount}+${opportunity.total_closed_won_amount}*0",
        value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
        _type_hint: number}]
    color_application:
      collection_id: 5f313589-67ce-44ba-b084-ec5107a7bb7e
      palette_id: be92eae7-de25-46ae-8e4f-21cb0b69a1f3
      options:
        steps: 5
        __FILE: app-sales/sales_rep_performance.dashboard.lookml
        __LINE_NUM: 502
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axes: [{label: '', orientation: left, series: [{id: won, name: Won, axisId: won,
            __FILE: app-sales/sales_rep_performance.dashboard.lookml, __LINE_NUM: 508},
          {id: over, name: Over, axisId: over, __FILE: app-sales/sales_rep_performance.dashboard.lookml,
            __LINE_NUM: 510}, {id: under, name: Under, axisId: under, __FILE: app-sales/sales_rep_performance.dashboard.lookml,
            __LINE_NUM: 511}, {id: quota, name: Quota, axisId: quota, __FILE: app-sales/sales_rep_performance.dashboard.lookml,
            __LINE_NUM: 512}], showLabels: false, showValues: false, unpinAxis: false,
        tickDensity: default, type: linear, __FILE: app-sales/sales_rep_performance.dashboard.lookml,
        __LINE_NUM: 508}, {label: '', orientation: left, series: [{id: of_quota_met,
            name: "% of Quota Met", axisId: of_quota_met, __FILE: app-sales/sales_rep_performance.dashboard.lookml,
            __LINE_NUM: 515}], showLabels: true, showValues: true, unpinAxis: false,
        tickDensity: default, type: linear, __FILE: app-sales/sales_rep_performance.dashboard.lookml,
        __LINE_NUM: 515}]
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
    stacking: normal
    limit_displayed_rows: true
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '4'
    legend_position: center
    font_size: small
    label_value_format: '[>=1000000]$0.00,,"M";[>=1000]$0.00,"K";$0.00'
    series_types:
      calculation_3: line
      of_quota_met: line
      quota_measure: line
      quota: line
    point_style: circle
    series_colors:
      won: "#ede8ff"
      over: "#462C9D"
      under: "#87898f"
    series_point_styles:
      quota_measure: square
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    reference_lines: []
    ordering: none
    show_null_labels: false
    show_totals_labels: true
    show_silhouette: false
    totals_color: "#808080"
    hidden_fields: [opportunity.total_closed_won_revenue, quota_numbers.quarterly_quota,
      gap, opportunity.total_closed_won_amount, quota.quarterly_quota, quota.quota_amount]
    listen:
      Sales Rep: opportunity_owner.name
    row: 2
    col: 12
    width: 12
    height: 8
  - title: Biggest Wins
    name: Biggest Wins
    model: sales_analytics
    explore: opportunity
    type: looker_bar
    fields: [opportunity.name_id, opportunity.days_to_closed_won, account.logo64,
      opportunity.total_closed_won_new_business_amount]
    filters:
      opportunity.is_won: 'Yes'
      opportunity.is_included_in_quota: 'Yes'
    sorts: [opportunity.total_closed_won_new_business_amount desc]
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
          __FILE: app-sales/sales_rep_performance.dashboard.lookml
          __LINE_NUM: 83
        - color: "#462C9D"
          offset: 100
          __FILE: app-sales/sales_rep_performance.dashboard.lookml
          __LINE_NUM: 87
        __FILE: app-sales/sales_rep_performance.dashboard.lookml
        __LINE_NUM: 79
      options:
        steps: 5
        __FILE: app-sales/sales_rep_performance.dashboard.lookml
        __LINE_NUM: 94
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
    y_axes: [{label: '', orientation: left, series: [{id: opportunity.total_closed_won_new_business_amount,
            name: 'Closed Won ACV ', axisId: opportunity.total_closed_won_new_business_amount,
            __FILE: app-sales/sales_rep_performance.dashboard.lookml, __LINE_NUM: 109}],
        showLabels: false, showValues: false, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear, __FILE: app-sales/sales_rep_performance.dashboard.lookml,
        __LINE_NUM: 109}]
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
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: !!null '',
        font_color: !!null '', color_application: {collection_id: legacy, palette_id: legacy_diverging1,
          __FILE: app-sales/sales_rep_performance.dashboard.lookml, __LINE_NUM: 140},
        bold: false, italic: false, strikethrough: false, fields: !!null '', __FILE: app-sales/sales_rep_performance.dashboard.lookml,
        __LINE_NUM: 139}]
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    hidden_fields: [opportunity.days_to_closed_won, opportunity.name_id]
    listen:
      Sales Rep: opportunity_owner.name
    row: 26
    col: 17
    width: 7
    height: 9
  - title: Active Customers
    name: Active Customers
    model: sales_analytics
    explore: opportunity
    type: table
    fields: [opportunity.name_id, account.logo64, account.business_segment, opportunity.close_date,
      opportunity.days_as_customer, opportunity.total_closed_won_amount]
    filters:
      opportunity.close_date: before 0 minutes ago
      account.is_customer_core: 'Yes'
    sorts: [opportunity.close_date desc]
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
    row: 26
    col: 0
    width: 17
    height: 9
  filters:
  - name: Sales Rep
    title: Sales Rep
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: sales_analytics
    explore: opportunity
    listens_to_filters: []
    field: opportunity_owner.name_select
