- dashboard: sales_rep_performance
  title: Sales Rep Performance
  layout: newspaper
  query_timezone: query_saved
  elements:
  - title: Revenue (QTD)
    name: Revenue (QTD)
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields: [opportunity.total_closed_won_new_business_amount, quota.quarterly_quota]
    filters:
      opportunity.close_date: this quarter
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
    row: 2
    col: 0
    width: 4
    height: 4
  - title: Rep Name
    name: Rep Name
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields: [opportunity_owner.name]
    filters:
      opportunity.close_date: this year
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
  - title: Active Customers
    name: Active Customers
    model: sales_analytics
    explore: opportunity
    type: table
    fields: [account.name, account.logo64, account.business_segment, opportunity.close_date,
      opportunity.days_as_customer, opportunity.total_closed_won_amount]
    filters:
      account.is_customer: 'Yes'
      opportunity.close_date: before 0 minutes ago
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
    row: 48
    col: 0
    width: 17
    height: 9
  - title: Biggest Wins
    name: Biggest Wins
    model: sales_analytics
    explore: opportunity
    type: looker_bar
    fields: [opportunity.name, opportunity.total_closed_won_new_business_amount, opportunity.days_to_closed_won,
      account.logo64]
    filters:
      opportunity.is_won: 'Yes'
      opportunity.is_new_business: 'Yes'
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
    y_axes: [{label: '', orientation: left, series: [{id: opportunity.total_closed_won_new_business_amount,
            name: 'Closed Won ACV ', axisId: opportunity.total_closed_won_new_business_amount}],
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
        font_color: !!null '', color_application: {collection_id: legacy, palette_id: legacy_diverging1},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}]
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    hidden_fields: [opportunity.days_to_closed_won, opportunity.name]
    listen:
      Sales Rep: opportunity_owner.name
    row: 48
    col: 17
    width: 7
    height: 9
  - title: "% to Quota (QoQ)"
    name: "% to Quota (QoQ)"
    model: sales_analytics
    explore: opportunity
    type: looker_column
    fields: [opportunity.close_quarter, opportunity.total_closed_won_amount, quota.quarterly_quota]
    filters:
      opportunity.close_date: 4 quarters
    sorts: [opportunity.close_quarter]
    limit: 500
    column_limit: 50
    total: true
    dynamic_fields: [{table_calculation: gap, label: Gap, expression: "${quota.quarterly_quota}-${opportunity.total_closed_won_amount}",
        value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
        _type_hint: number}, {table_calculation: won, label: Won, expression: 'if(
          is_null(${over}),${quota}-${under},${quota})', value_format: !!null '',
        value_format_name: !!null '', _kind_hint: dimension, _type_hint: number},
      {table_calculation: over, label: Over, expression: 'if(${gap}<0,abs(${gap}),null)',
        value_format: !!null '', value_format_name: !!null '', _kind_hint: dimension,
        _type_hint: number}, {table_calculation: under, label: Under, expression: 'if(${gap}>0,abs(${gap}),null)',
        value_format: !!null '', value_format_name: !!null '', _kind_hint: dimension,
        _type_hint: number}, {table_calculation: quota, label: Quota, expression: "${quota.quarterly_quota}+${opportunity.total_closed_won_amount}*0",
        value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
        _type_hint: number}]
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
    y_axes: [{label: '', orientation: left, series: [{id: won, name: Won, axisId: won},
          {id: over, name: Over, axisId: over}, {id: under, name: Under, axisId: under},
          {id: quota, name: Quota, axisId: quota}], showLabels: false, showValues: false,
        unpinAxis: false, tickDensity: default, type: linear}, {label: '', orientation: left,
        series: [{id: of_quota_met, name: "% of Quota Met", axisId: of_quota_met}],
        showLabels: true, showValues: true, unpinAxis: false, tickDensity: default,
        type: linear}]
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
    hidden_fields: [opportunity.total_closed_won_revenue, quota_numbers.quarterly_quota,
      gap, opportunity.total_closed_won_amount, quota.quarterly_quota]
    listen:
      Sales Rep: opportunity_owner.name
    row: 2
    col: 12
    width: 12
    height: 8
  - title: Pipeline (QTD)
    name: Pipeline (QTD)
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields: [opportunity.total_pipeline_new_business_amount, opportunity.total_closed_won_new_business_amount,
      quota.quarterly_quota]
    filters:
      opportunity.close_date: this quarter
    sorts: [opportunity.total_pipeline_new_business_amount desc]
    limit: 500
    dynamic_fields: [{table_calculation: gap, label: Gap, expression: "${quota.quarterly_quota}\
          \ - ${opportunity.total_closed_won_new_business_amount}", value_format: '[>=1000000]$0.00,,"M";[>=1000]$0,"K";$0.00',
        value_format_name: !!null '', _kind_hint: measure, _type_hint: number}]
    custom_color_enabled: true
    custom_color: ''
    show_single_value_title: true
    show_comparison: true
    comparison_type: progress_percentage
    comparison_reverse_colors: false
    show_comparison_label: true
    comparison_label: Gap
    show_view_names: 'true'
    hidden_fields: [opportunity.total_closed_won_new_business_amount]
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
  - title: Lifetime Customers
    name: Lifetime Customers
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields: [opportunity.count_new_business_won]
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
      quota.quota_amount]
    filters:
      opportunity.close_date: this year
    sorts: [opportunity.total_pipeline_new_business_amount desc]
    limit: 500
    dynamic_fields: [{table_calculation: gap, label: Gap, expression: "${quota.quota_amount}\
          \ - ${opportunity.total_closed_won_new_business_amount}", value_format: '[>=1000000]$0.00,,"M";[>=1000]$0,"K";$0.00',
        value_format_name: !!null '', _kind_hint: measure, _type_hint: number}]
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
  - title: Revenue (YTD)
    name: Revenue (YTD)
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields: [opportunity.total_closed_won_new_business_amount, quota.quota_amount]
    filters:
      opportunity.close_date: this year
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
  - title: Quarter Leaderboard
    name: Quarter Leaderboard
    model: sales_analytics
    explore: opportunity
    type: looker_bar
    fields: [opportunity_owner.name, opportunity.total_closed_won_new_business_amount,
      opportunity_owner.rep_highlight_acv]
    filters:
      opportunity_owner.name: "-NULL"
      opportunity.close_date: this quarter
    sorts: [opportunity.total_closed_won_new_business_amount desc]
    limit: 10
    column_limit: 50
    dynamic_fields: [{table_calculation: all_others, label: All Others, expression: 'if(is_null(${opportunity_owner.rep_highlight_acv}),${opportunity.total_closed_won_new_business_amount},null)',
        value_format: '[>=1000000]$0.00,,"M";[>=1000]$0,"K";$0.00', value_format_name: !!null '',
        _kind_hint: measure, _type_hint: number}]
    query_timezone: America/Los_Angeles
    trellis: ''
    stacking: normal
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
      opportunity.average_amount_won: "#EE9093"
      all_others: "#ede8ff"
    series_types: {}
    limit_displayed_rows: false
    y_axes: [{label: '', orientation: left, series: [{id: opportunity.total_closed_won_new_business_amount,
            name: 'Closed Won ACV ', axisId: opportunity.total_closed_won_new_business_amount}],
        showLabels: false, showValues: false, unpinAxis: false, tickDensity: default,
        type: linear}]
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
    totals_color: "#462C9D"
    show_null_points: true
    interpolation: linear
    hidden_fields: [opportunity.total_closed_won_new_business_amount]
    listen:
      Sales Rep: opportunity_owner.rep_filter
    row: 10
    col: 4
    width: 10
    height: 6
  - title: All Time Leaderboard
    name: All Time Leaderboard
    model: sales_analytics
    explore: opportunity
    type: looker_bar
    fields: [opportunity_owner.name, opportunity.total_closed_won_new_business_amount,
      opportunity_owner.rep_highlight_acv]
    filters:
      opportunity_owner.name: "-NULL"
    sorts: [opportunity.total_closed_won_new_business_amount desc]
    limit: 10
    column_limit: 50
    dynamic_fields: [{table_calculation: all_others, label: All Others, expression: 'if(is_null(${opportunity_owner.rep_highlight_acv}),${opportunity.total_closed_won_new_business_amount},null)',
        value_format: '[>=1000000]$0.00,,"M";[>=1000]$0,"K";$0.00', value_format_name: !!null '',
        _kind_hint: measure, _type_hint: number}]
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
    hide_legend: true
    x_axis_gridlines: false
    y_axis_gridlines: false
    show_view_names: false
    point_style: none
    series_colors:
      opportunity.average_amount_won: "#EE9093"
      all_others: "#ede8ff"
    series_types: {}
    limit_displayed_rows: false
    y_axes: [{label: '', orientation: left, series: [{id: opportunity.total_closed_won_new_business_amount,
            name: 'Closed Won ACV ', axisId: opportunity.total_closed_won_new_business_amount}],
        showLabels: false, showValues: false, unpinAxis: false, tickDensity: default,
        type: linear}]
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
    totals_color: "#462C9D"
    show_null_points: true
    interpolation: linear
    hidden_fields: [opportunity.total_closed_won_new_business_amount]
    listen:
      Sales Rep: opportunity_owner.rep_filter
    row: 10
    col: 14
    width: 10
    height: 6
  - title: Stage Conversion Rates
    name: Stage Conversion Rates
    model: sales_analytics
    explore: opportunity
    type: looker_column
    fields: [opportunity_stage_history.conv_rate_stage_1, opportunity_stage_history.conv_rate_stage_2,
      opportunity_stage_history.conv_rate_stage_3, opportunity_stage_history.conv_rate_stage_4,
      opportunity_stage_history.conv_rate_stage_5, opportunity.close_quarter]
    fill_fields: [opportunity.close_quarter]
    filters:
      opportunity.close_date: 4 quarters
    sorts: [opportunity.close_quarter desc]
    limit: 500
    column_limit: 50
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
    point_style: none
    series_colors:
      opportunity_stage_history.conv_rate_stage_1: "#FFB690"
      opportunity_stage_history.conv_rate_stage_2: "#EE9093"
    series_types: {}
    limit_displayed_rows: false
    y_axes: [{label: '', orientation: left, series: [{id: opportunity_stage_history.conv_rate_stage_1,
            name: Stage 1 Conv Rate, axisId: opportunity_stage_history.conv_rate_stage_1},
          {id: opportunity_stage_history.conv_rate_stage_2, name: Stage 2 Conv Rate,
            axisId: opportunity_stage_history.conv_rate_stage_2}, {id: opportunity_stage_history.conv_rate_stage_3,
            name: Stage 3 Conv Rate, axisId: opportunity_stage_history.conv_rate_stage_3},
          {id: opportunity_stage_history.conv_rate_stage_4, name: Stage 4 Conv Rate,
            axisId: opportunity_stage_history.conv_rate_stage_4}, {id: opportunity_stage_history.conv_rate_stage_5,
            name: Stage 5 Conv Rate, axisId: opportunity_stage_history.conv_rate_stage_5}],
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
    hidden_fields: []
    listen:
      Sales Rep: opportunity_owner.name
    row: 16
    col: 0
    width: 12
    height: 8
  - title: Rank (QTD)
    name: Rank (QTD)
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields: [opportunity_owner.name, opportunity.total_closed_won_new_business_amount,
      opportunity_owner.rep_highlight_acv]
    filters:
      opportunity_owner.name: "-NULL"
      opportunity.close_date: this quarter
    sorts: [opportunity.total_closed_won_new_business_amount desc]
    limit: 5000
    column_limit: 50
    dynamic_fields: [{table_calculation: rank, label: Rank, expression: 'if(NOT is_null(${opportunity_owner.rep_highlight_acv}),row(),
          null)', value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
        _type_hint: number}, {table_calculation: format, label: Format, expression: "concat(\n\
          \tto_string(max(${rank})), \n  \n\n  if(\n  \tmod(max(${rank}),100) > 10\
          \ AND mod(max(${rank}),100) <= 20, \n  \t\t\"th\", \n  \t\tif(mod(max(${rank}),10)\
          \ = 1, \"st\", if(mod(max(${rank}),10) = 2, \n  \t\t\t\"nd\", \n  \t\t\t\
          if(mod(max(${rank}),10) = 3, \"rd\", \"th\")\n  \t\t\t)\n  \t\t)\n  \t)\n\
          )", value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
        _type_hint: string}]
    query_timezone: America/Los_Angeles
    trellis: ''
    stacking: normal
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
      opportunity.average_amount_won: "#EE9093"
      all_others: "#ede8ff"
    series_types: {}
    limit_displayed_rows: false
    y_axes: [{label: '', orientation: left, series: [{id: opportunity.total_closed_won_new_business_amount,
            name: 'Closed Won ACV ', axisId: opportunity.total_closed_won_new_business_amount}],
        showLabels: false, showValues: false, unpinAxis: false, tickDensity: default,
        type: linear}]
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
    totals_color: "#462C9D"
    show_null_points: true
    interpolation: linear
    hidden_fields: [opportunity.total_closed_won_new_business_amount, opportunity_owner.rep_highlight_acv,
      rank]
    listen:
      Sales Rep: opportunity_owner.rep_filter
    row: 10
    col: 0
    width: 4
    height: 3
  - title: Rank (All Time)
    name: Rank (All Time)
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields: [opportunity_owner.name, opportunity.total_closed_won_new_business_amount,
      opportunity_owner.rep_highlight_acv]
    filters:
      opportunity_owner.name: "-NULL"
    sorts: [opportunity.total_closed_won_new_business_amount desc]
    limit: 5000
    column_limit: 50
    dynamic_fields: [{table_calculation: rank, label: Rank, expression: 'if(NOT is_null(${opportunity_owner.rep_highlight_acv}),row(),
          null)', value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
        _type_hint: number}, {table_calculation: format_rank, label: Format Rank,
        expression: "concat(\n\tto_string(max(${rank})), \n  \n\n  if(\n  \tmod(max(${rank}),100)\
          \ > 10 AND mod(max(${rank}),100) <= 20, \n  \t\t\"th\", \n  \t\tif(mod(max(${rank}),10)\
          \ = 1, \"st\", if(mod(max(${rank}),10) = 2, \n  \t\t\t\"nd\", \n  \t\t\t\
          if(mod(max(${rank}),10) = 3, \"rd\", \"th\")\n  \t\t\t)\n  \t\t)\n  \t)\n\
          )", value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
        _type_hint: string}]
    query_timezone: America/Los_Angeles
    trellis: ''
    stacking: normal
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
      opportunity.average_amount_won: "#EE9093"
      all_others: "#ede8ff"
    series_types: {}
    limit_displayed_rows: false
    y_axes: [{label: '', orientation: left, series: [{id: opportunity.total_closed_won_new_business_amount,
            name: 'Closed Won ACV ', axisId: opportunity.total_closed_won_new_business_amount}],
        showLabels: false, showValues: false, unpinAxis: false, tickDensity: default,
        type: linear}]
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
    totals_color: "#462C9D"
    show_null_points: true
    interpolation: linear
    hidden_fields: [opportunity.total_closed_won_new_business_amount, opportunity_owner.rep_highlight_acv,
      rank]
    listen:
      Sales Rep: opportunity_owner.rep_filter
    row: 13
    col: 0
    width: 4
    height: 3
  - title: Revenue for Each Stage
    name: Revenue for Each Stage
    model: sales_analytics
    explore: opportunity
    type: looker_column
    fields: [segment_lookup.grouping, opportunity.custom_stage_name, opportunity.average_new_deal_size]
    pivots: [segment_lookup.grouping]
    filters:
      opportunity.custom_stage_name: "-Unknown"
    sorts: [opportunity.custom_stage_name, segment_lookup.grouping]
    limit: 500
    dynamic_fields: [{table_calculation: avg_new_deal_size, label: Avg New Deal Size,
        expression: 'if(is_null(${opportunity.average_new_deal_size}),0,${opportunity.average_new_deal_size})',
        value_format: '[>=1000000]$0.00,,"M";[>=1000]$0,"K";$0.00', value_format_name: !!null '',
        _kind_hint: measure, _type_hint: number}]
    query_timezone: UTC
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
      options:
        steps: 5
        reverse: false
    show_value_labels: true
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: false
    show_view_names: false
    point_style: none
    series_colors: {}
    series_types: {}
    limit_displayed_rows: false
    y_axes: [{label: '', orientation: left, series: [{id: Kevin Heller - 1 - avg_new_deal_size,
            name: Kevin Heller, axisId: avg_new_deal_size}, {id: Rest of Named Accounts
              - 2 - avg_new_deal_size, name: Rest of Named Accounts, axisId: avg_new_deal_size},
          {id: Rest of Company - 3 - avg_new_deal_size, name: Rest of Company, axisId: avg_new_deal_size}],
        showLabels: false, showValues: false, unpinAxis: false, tickDensity: default,
        type: linear}]
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
    row: 16
    col: 12
    width: 12
    height: 8
  - title: Win % Rank (vs My Segment)
    name: Win % Rank (vs My Segment)
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields: [win_percentage_comparison.win_percentage_rank, win_percentage_comparison.win_percentage_cohort]
    filters:
      opportunity.matches_name_select: 'Yes'
    sorts: [win_percentage_comparison.win_percentage_rank]
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: rank, label: rank, expression: "${win_percentage_comparison.win_percentage_rank}",
        value_format: !!null '', value_format_name: !!null '', _kind_hint: dimension,
        _type_hint: number}, {table_calculation: calculation_3, label: Calculation
          3, expression: "concat(\n    to_string(${rank}), \n  \n\n  if(\n      mod(${rank},100)\
          \ > 10 AND mod(${rank},100) <= 20, \n          \"th\", \n          if(mod(${rank},10)\
          \ = 1, \"st\", if(mod(${rank},10) = 2, \n              \"nd\", \n      \
          \        if(mod(${rank},10) = 3, \"rd\", \"th\")\n              )\n    \
          \      )\n      )\n)", value_format: !!null '', value_format_name: !!null '',
        _kind_hint: dimension, _type_hint: string}, {table_calculation: calculation_2,
        label: Calculation 2, expression: "${win_percentage_comparison.win_percentage_cohort}",
        value_format: !!null '', value_format_name: !!null '', _kind_hint: dimension,
        _type_hint: string}]
    query_timezone: America/Los_Angeles
    custom_color_enabled: true
    custom_color: ''
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: false
    series_types: {}
    hidden_fields: [rank, win_percentage_comparison.win_percentage_rank, win_percentage_comparison.win_percentage_cohort]
    listen:
      Sales Rep: opportunity_owner.name_select
    row: 32
    col: 17
    width: 7
    height: 4
  - title: Win % Rank (vs Rest of Company)
    name: Win % Rank (vs Rest of Company)
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields: [win_percentage_comparison.win_percentage_rank, win_percentage_comparison.win_percentage_cohort]
    filters: {}
    sorts: [win_percentage_comparison.win_percentage_rank]
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: rank, label: rank, expression: "${win_percentage_comparison.win_percentage_rank}",
        value_format: !!null '', value_format_name: !!null '', _kind_hint: dimension,
        _type_hint: number}, {table_calculation: calculation_3, label: Calculation
          3, expression: "concat(\n    to_string(${rank}), \n  \n\n  if(\n      mod(${rank},100)\
          \ > 10 AND mod(${rank},100) <= 20, \n          \"th\", \n          if(mod(${rank},10)\
          \ = 1, \"st\", if(mod(${rank},10) = 2, \n              \"nd\", \n      \
          \        if(mod(${rank},10) = 3, \"rd\", \"th\")\n              )\n    \
          \      )\n      )\n)", value_format: !!null '', value_format_name: !!null '',
        _kind_hint: dimension, _type_hint: string}, {table_calculation: calculation_2,
        label: Calculation 2, expression: "${win_percentage_comparison.win_percentage_cohort}",
        value_format: !!null '', value_format_name: !!null '', _kind_hint: dimension,
        _type_hint: string}]
    query_timezone: America/Los_Angeles
    custom_color_enabled: true
    custom_color: ''
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: false
    series_types: {}
    hidden_fields: [rank, win_percentage_comparison.win_percentage_rank, win_percentage_comparison.win_percentage_cohort]
    listen:
      Sales Rep: opportunity_owner.name
    row: 36
    col: 17
    width: 7
    height: 4
  - title: Sales Cycle Rank (vs My Segment)
    name: Sales Cycle Rank (vs My Segment)
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields: [sales_cycle_comparison.cycle_rank, sales_cycle_comparison.cycle_cohort]
    filters:
      opportunity_owner.name: ''
      opportunity.matches_name_select: 'Yes'
    sorts: [sales_cycle_comparison.cycle_rank]
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: rank, label: rank, expression: "${sales_cycle_comparison.cycle_rank}",
        value_format: !!null '', value_format_name: !!null '', _kind_hint: dimension,
        _type_hint: number}, {table_calculation: calculation_3, label: Calculation
          3, expression: "concat(\n    to_string(${rank}), \n  \n\n  if(\n      mod(${rank},100)\
          \ > 10 AND mod(${rank},100) <= 20, \n          \"th\", \n          if(mod(${rank},10)\
          \ = 1, \"st\", if(mod(${rank},10) = 2, \n              \"nd\", \n      \
          \        if(mod(${rank},10) = 3, \"rd\", \"th\")\n              )\n    \
          \      )\n      )\n)", value_format: !!null '', value_format_name: !!null '',
        _kind_hint: dimension, _type_hint: string}, {table_calculation: calculation_2,
        label: Calculation 2, expression: "${sales_cycle_comparison.cycle_cohort}",
        value_format: !!null '', value_format_name: !!null '', _kind_hint: dimension,
        _type_hint: string}]
    query_timezone: America/Los_Angeles
    custom_color_enabled: true
    custom_color: ''
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: false
    series_types: {}
    hidden_fields: [rank, sales_cycle_comparison.cycle_rank, sales_cycle_comparison.cycle_cohort]
    listen:
      Sales Rep: opportunity_owner.name_select
    row: 44
    col: 17
    width: 7
    height: 4
  - title: Sales Cycle Rank (vs Rest of Company)
    name: Sales Cycle Rank (vs Rest of Company)
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields: [sales_cycle_comparison.cycle_rank, sales_cycle_comparison.cycle_cohort]
    filters: {}
    sorts: [sales_cycle_comparison.cycle_rank]
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: rank, label: rank, expression: "${sales_cycle_comparison.cycle_rank}",
        value_format: !!null '', value_format_name: !!null '', _kind_hint: dimension,
        _type_hint: number}, {table_calculation: calculation_3, label: Calculation
          3, expression: "concat(\n    to_string(${rank}), \n  \n\n  if(\n      mod(${rank},100)\
          \ > 10 AND mod(${rank},100) <= 20, \n          \"th\", \n          if(mod(${rank},10)\
          \ = 1, \"st\", if(mod(${rank},10) = 2, \n              \"nd\", \n      \
          \        if(mod(${rank},10) = 3, \"rd\", \"th\")\n              )\n    \
          \      )\n      )\n)", value_format: !!null '', value_format_name: !!null '',
        _kind_hint: dimension, _type_hint: string}, {table_calculation: calculation_2,
        label: Calculation 2, expression: "${sales_cycle_comparison.cycle_cohort}",
        value_format: !!null '', value_format_name: !!null '', _kind_hint: dimension,
        _type_hint: string}]
    query_timezone: America/Los_Angeles
    custom_color_enabled: true
    custom_color: ''
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: false
    series_types: {}
    hidden_fields: [rank, sales_cycle_comparison.cycle_rank, sales_cycle_comparison.cycle_cohort]
    listen:
      Sales Rep: opportunity_owner.name
    row: 40
    col: 17
    width: 7
    height: 4
  - title: Deal Size (vs Segment)
    name: Deal Size (vs Segment)
    model: sales_analytics
    explore: opportunity
    type: looker_line
    fields: [user_age.age_at_close, new_deal_size_comparison.deal_size_cohort_comparitor,
      opportunity.average_new_deal_size]
    pivots: [new_deal_size_comparison.deal_size_cohort_comparitor]
    filters:
      user_age.age_at_close: "<36,NOT NULL"
      new_deal_size_comparison.deal_size_cohort_comparitor: "-NULL"
    sorts: [user_age.age_at_close, new_deal_size_comparison.deal_size_cohort_comparitor]
    limit: 500
    dynamic_fields: [{table_calculation: average_new_deal_size, label: Average New
          Deal Size, expression: 'mean(offset_list(${opportunity.average_new_deal_size},-6,12))',
        value_format: '[>=1000000]$0.00,,"M";[>=1000]$0,"K";$0.00', value_format_name: !!null '',
        _kind_hint: measure, _type_hint: number}]
    query_timezone: America/Los_Angeles
    stacking: ''
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
    y_axis_gridlines: true
    show_view_names: false
    point_style: none
    series_types: {}
    limit_displayed_rows: false
    y_axes: [{label: '', orientation: left, series: [{id: " Michael Kilbane - average_new_deal_size",
            name: " Michael Kilbane", axisId: average_new_deal_size}, {id: Bottom
              Third - average_new_deal_size, name: Bottom Third, axisId: average_new_deal_size},
          {id: Middle Third - average_new_deal_size, name: Middle Third, axisId: average_new_deal_size},
          {id: Top Third - average_new_deal_size, name: Top Third, axisId: average_new_deal_size}],
        showLabels: false, showValues: true, unpinAxis: false, tickDensity: default,
        type: linear}]
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
    show_null_points: true
    interpolation: linear
    hidden_fields: [opportunity.average_new_deal_size]
    listen:
      Sales Rep: opportunity_owner.name_select
    row: 24
    col: 0
    width: 17
    height: 8
  - title: Deal Size Rank (vs My Segment)
    name: Deal Size Rank (vs My Segment)
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields: [new_deal_size_comparison.deal_size_rank, new_deal_size_comparison.deal_size_cohort]
    filters:
      opportunity_owner.name: ''
      opportunity.matches_name_select: 'Yes'
    sorts: [new_deal_size_comparison.deal_size_rank]
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: rank, label: rank, expression: "${new_deal_size_comparison.deal_size_rank}",
        value_format: !!null '', value_format_name: !!null '', _kind_hint: dimension,
        _type_hint: number}, {table_calculation: calculation_3, label: Calculation
          3, expression: "concat(\n    to_string(${rank}), \n  \n\n  if(\n      mod(${rank},100)\
          \ > 10 AND mod(${rank},100) <= 20, \n          \"th\", \n          if(mod(${rank},10)\
          \ = 1, \"st\", if(mod(${rank},10) = 2, \n              \"nd\", \n      \
          \        if(mod(${rank},10) = 3, \"rd\", \"th\")\n              )\n    \
          \      )\n      )\n)", value_format: !!null '', value_format_name: !!null '',
        _kind_hint: dimension, _type_hint: string}, {table_calculation: calculation_2,
        label: Calculation 2, expression: "${new_deal_size_comparison.deal_size_cohort}",
        value_format: !!null '', value_format_name: !!null '', _kind_hint: dimension,
        _type_hint: string}]
    query_timezone: America/Los_Angeles
    custom_color_enabled: true
    custom_color: ''
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: false
    series_types: {}
    hidden_fields: [rank, new_deal_size_comparison.deal_size_rank, new_deal_size_comparison.deal_size_cohort]
    listen:
      Sales Rep: opportunity_owner.name_select
    row: 24
    col: 17
    width: 7
    height: 4
  - title: Deal Size Rank (vs Rest of Company)
    name: Deal Size Rank (vs Rest of Company)
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields: [new_deal_size_comparison.deal_size_rank, new_deal_size_comparison.deal_size_cohort]
    filters: {}
    sorts: [new_deal_size_comparison.deal_size_cohort]
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: rank, label: rank, expression: "${new_deal_size_comparison.deal_size_rank}",
        value_format: !!null '', value_format_name: !!null '', _kind_hint: dimension,
        _type_hint: number}, {table_calculation: calculation_3, label: Calculation
          3, expression: "concat(\n    to_string(${rank}), \n  \n\n  if(\n      mod(${rank},100)\
          \ > 10 AND mod(${rank},100) <= 20, \n          \"th\", \n          if(mod(${rank},10)\
          \ = 1, \"st\", if(mod(${rank},10) = 2, \n              \"nd\", \n      \
          \        if(mod(${rank},10) = 3, \"rd\", \"th\")\n              )\n    \
          \      )\n      )\n)", value_format: !!null '', value_format_name: !!null '',
        _kind_hint: dimension, _type_hint: string}, {table_calculation: calculation_2,
        label: Calculation 2, expression: "${new_deal_size_comparison.deal_size_cohort}",
        value_format: !!null '', value_format_name: !!null '', _kind_hint: dimension,
        _type_hint: string}]
    query_timezone: America/Los_Angeles
    custom_color_enabled: true
    custom_color: ''
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: false
    series_types: {}
    hidden_fields: [new_deal_size_comparison.deal_size_cohort, new_deal_size_comparison.deal_size_rank,
      rank]
    listen:
      Sales Rep: opportunity_owner.name
    row: 28
    col: 17
    width: 7
    height: 4
  - title: Average Sales Cycle (vs Segment)
    name: Average Sales Cycle (vs Segment)
    model: sales_analytics
    explore: opportunity
    type: looker_line
    fields: [sales_cycle_comparison.sales_cycle_cohort_comparitor, opportunity.average_days_to_closed_won,
      user_age.age_at_close]
    pivots: [sales_cycle_comparison.sales_cycle_cohort_comparitor]
    filters:
      sales_cycle_comparison.sales_cycle_cohort_comparitor: "-NULL"
      user_age.age_at_close: "<36,NOT NULL"
    sorts: [sales_cycle_comparison.sales_cycle_cohort_comparitor 0, user_age.age_at_close]
    limit: 500
    dynamic_fields: [{table_calculation: avg_days_to_closed_won, label: Avg Days To
          Closed Won, expression: 'mean(offset_list(${opportunity.average_days_to_closed_won},-5,10))',
        value_format: !!null '', value_format_name: decimal_2, _kind_hint: measure,
        _type_hint: number}]
    query_timezone: America/Los_Angeles
    stacking: ''
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
    y_axis_gridlines: true
    show_view_names: false
    point_style: none
    series_types: {}
    limit_displayed_rows: false
    y_axes: [{label: '', orientation: left, series: [{id: " Aditya Arya - avg_days_to_closed_won",
            name: " Aditya Arya", axisId: avg_days_to_closed_won}, {id: " Akira Igarashi\
              \ - avg_days_to_closed_won", name: " Akira Igarashi", axisId: avg_days_to_closed_won},
          {id: " Akshay Padhye - avg_days_to_closed_won", name: " Akshay Padhye",
            axisId: avg_days_to_closed_won}, {id: " Alec Short - avg_days_to_closed_won",
            name: " Alec Short", axisId: avg_days_to_closed_won}, {id: " Aleli Carley\
              \ - avg_days_to_closed_won", name: " Aleli Carley", axisId: avg_days_to_closed_won},
          {id: " Alex Mazur - avg_days_to_closed_won", name: " Alex Mazur", axisId: avg_days_to_closed_won},
          {id: " Amber Lindke - avg_days_to_closed_won", name: " Amber Lindke", axisId: avg_days_to_closed_won},
          {id: " Amy Webb - avg_days_to_closed_won", name: " Amy Webb", axisId: avg_days_to_closed_won},
          {id: " Angela Lambert - avg_days_to_closed_won", name: " Angela Lambert",
            axisId: avg_days_to_closed_won}, {id: " Annie Gray - avg_days_to_closed_won",
            name: " Annie Gray", axisId: avg_days_to_closed_won}, {id: " Arianna Williams\
              \ - avg_days_to_closed_won", name: " Arianna Williams", axisId: avg_days_to_closed_won},
          {id: " Bill Pencek - avg_days_to_closed_won", name: " Bill Pencek", axisId: avg_days_to_closed_won},
          {id: " Billy Kelly - avg_days_to_closed_won", name: " Billy Kelly", axisId: avg_days_to_closed_won},
          {id: " Brent Osborne - avg_days_to_closed_won", name: " Brent Osborne",
            axisId: avg_days_to_closed_won}, {id: " Brian Kelly - avg_days_to_closed_won",
            name: " Brian Kelly", axisId: avg_days_to_closed_won}, {id: " Brian Walter\
              \ - avg_days_to_closed_won", name: " Brian Walter", axisId: avg_days_to_closed_won},
          {id: " Brie Bernstein - avg_days_to_closed_won", name: " Brie Bernstein",
            axisId: avg_days_to_closed_won}, {id: " Britni Lynch - avg_days_to_closed_won",
            name: " Britni Lynch", axisId: avg_days_to_closed_won}, {id: " Caleb Little\
              \ - avg_days_to_closed_won", name: " Caleb Little", axisId: avg_days_to_closed_won},
          {id: " Casandra Liggin - avg_days_to_closed_won", name: " Casandra Liggin",
            axisId: avg_days_to_closed_won}, {id: " Casey Knapp - avg_days_to_closed_won",
            name: " Casey Knapp", axisId: avg_days_to_closed_won}, {id: " Chris Daniel\
              \ - avg_days_to_closed_won", name: " Chris Daniel", axisId: avg_days_to_closed_won},
          {id: " Chris Martin - avg_days_to_closed_won", name: " Chris Martin", axisId: avg_days_to_closed_won},
          {id: " Christian Lunoe - avg_days_to_closed_won", name: " Christian Lunoe",
            axisId: avg_days_to_closed_won}, {id: " Colin Murphy - avg_days_to_closed_won",
            name: " Colin Murphy", axisId: avg_days_to_closed_won}, {id: " Cory Hershey\
              \ - avg_days_to_closed_won", name: " Cory Hershey", axisId: avg_days_to_closed_won},
          {id: " Courtney Leonard - avg_days_to_closed_won", name: " Courtney Leonard",
            axisId: avg_days_to_closed_won}, {id: " Danielle Muzzini - avg_days_to_closed_won",
            name: " Danielle Muzzini", axisId: avg_days_to_closed_won}, {id: " Daryl\
              \ Weinhoff - avg_days_to_closed_won", name: " Daryl Weinhoff", axisId: avg_days_to_closed_won},
          {id: " David Belliot - avg_days_to_closed_won", name: " David Belliot",
            axisId: avg_days_to_closed_won}, {id: " Dermott Ryan - avg_days_to_closed_won",
            name: " Dermott Ryan", axisId: avg_days_to_closed_won}, {id: " Derrich\
              \ Beauchamp - avg_days_to_closed_won", name: " Derrich Beauchamp", axisId: avg_days_to_closed_won},
          {id: " Diego Simkin - avg_days_to_closed_won", name: " Diego Simkin", axisId: avg_days_to_closed_won},
          {id: " Dillon Ford - avg_days_to_closed_won", name: " Dillon Ford", axisId: avg_days_to_closed_won},
          {id: " Doug Berscak - avg_days_to_closed_won", name: " Doug Berscak", axisId: avg_days_to_closed_won},
          {id: " Eoin Mulcahy - avg_days_to_closed_won", name: " Eoin Mulcahy", axisId: avg_days_to_closed_won},
          {id: " Ethel Anderson - avg_days_to_closed_won", name: " Ethel Anderson",
            axisId: avg_days_to_closed_won}, {id: " Evelyn Shen - avg_days_to_closed_won",
            name: " Evelyn Shen", axisId: avg_days_to_closed_won}, {id: " Fabien Sabat\
              \ - avg_days_to_closed_won", name: " Fabien Sabat", axisId: avg_days_to_closed_won},
          {id: " Fernando Leon - avg_days_to_closed_won", name: " Fernando Leon",
            axisId: avg_days_to_closed_won}, {id: " Graham Norwood - avg_days_to_closed_won",
            name: " Graham Norwood", axisId: avg_days_to_closed_won}, {id: " Gurpal\
              \ Singh - avg_days_to_closed_won", name: " Gurpal Singh", axisId: avg_days_to_closed_won},
          {id: " Hank Ritter - avg_days_to_closed_won", name: " Hank Ritter", axisId: avg_days_to_closed_won},
          {id: " Hanna Givelber - avg_days_to_closed_won", name: " Hanna Givelber",
            axisId: avg_days_to_closed_won}, {id: " Holly Meadows Smith - avg_days_to_closed_won",
            name: " Holly Meadows Smith", axisId: avg_days_to_closed_won}, {id: " Jaleel\
              \ Mackey - avg_days_to_closed_won", name: " Jaleel Mackey", axisId: avg_days_to_closed_won},
          {id: " Jeff De La Cruz - avg_days_to_closed_won", name: " Jeff De La Cruz",
            axisId: avg_days_to_closed_won}, {id: " Jeff Garcia - avg_days_to_closed_won",
            name: " Jeff Garcia", axisId: avg_days_to_closed_won}, {id: " Jeff Van\
              \ Earwage - avg_days_to_closed_won", name: " Jeff Van Earwage", axisId: avg_days_to_closed_won},
          {id: " Jethro Law - avg_days_to_closed_won", name: " Jethro Law", axisId: avg_days_to_closed_won}],
        showLabels: false, showValues: true, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
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
    show_null_points: true
    interpolation: linear
    hidden_fields: [opportunity.average_days_to_closed_won]
    listen:
      Sales Rep: opportunity_owner.name_select
    row: 40
    col: 0
    width: 17
    height: 8
  - title: Win % (vs Segment)
    name: Win % (vs Segment)
    model: sales_analytics
    explore: opportunity
    type: looker_line
    fields: [user_age.age_at_close, opportunity.win_percentage, win_percentage_comparison.win_percentage_cohort_comparitor]
    pivots: [win_percentage_comparison.win_percentage_cohort_comparitor]
    filters:
      user_age.age_at_close: "<36,NOT NULL"
      win_percentage_comparison.win_percentage_cohort_comparitor: "-NULL"
    sorts: [win_percentage_comparison.win_percentage_cohort_comparitor 0, user_age.age_at_close]
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: calculation_1, label: Calculation 1, expression: 'mean(offset_list(${opportunity.win_percentage},-6,12))',
        value_format: !!null '', value_format_name: percent_2, _kind_hint: measure,
        _type_hint: number}]
    query_timezone: America/Los_Angeles
    stacking: ''
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
    y_axis_gridlines: true
    show_view_names: false
    point_style: none
    series_types: {}
    limit_displayed_rows: false
    y_axes: [{label: '', orientation: left, series: [{id: " Aditya Arya - calculation_1",
            name: " Aditya Arya", axisId: calculation_1}, {id: " Akira Igarashi -\
              \ calculation_1", name: " Akira Igarashi", axisId: calculation_1}, {
            id: " Akshay Padhye - calculation_1", name: " Akshay Padhye", axisId: calculation_1},
          {id: " Alec Short - calculation_1", name: " Alec Short", axisId: calculation_1},
          {id: " Aleli Carley - calculation_1", name: " Aleli Carley", axisId: calculation_1},
          {id: " Alex Mazur - calculation_1", name: " Alex Mazur", axisId: calculation_1},
          {id: " Amber Lindke - calculation_1", name: " Amber Lindke", axisId: calculation_1},
          {id: " Amy Webb - calculation_1", name: " Amy Webb", axisId: calculation_1},
          {id: " Angela Lambert - calculation_1", name: " Angela Lambert", axisId: calculation_1},
          {id: " Annie Gray - calculation_1", name: " Annie Gray", axisId: calculation_1},
          {id: " Arianna Williams - calculation_1", name: " Arianna Williams", axisId: calculation_1},
          {id: " Bill Pencek - calculation_1", name: " Bill Pencek", axisId: calculation_1},
          {id: " Billy Kelly - calculation_1", name: " Billy Kelly", axisId: calculation_1},
          {id: " Brent Osborne - calculation_1", name: " Brent Osborne", axisId: calculation_1},
          {id: " Brian Kelly - calculation_1", name: " Brian Kelly", axisId: calculation_1},
          {id: " Brian Walter - calculation_1", name: " Brian Walter", axisId: calculation_1},
          {id: " Brie Bernstein - calculation_1", name: " Brie Bernstein", axisId: calculation_1},
          {id: " Britni Lynch - calculation_1", name: " Britni Lynch", axisId: calculation_1},
          {id: " Caleb Little - calculation_1", name: " Caleb Little", axisId: calculation_1},
          {id: " Casandra Liggin - calculation_1", name: " Casandra Liggin", axisId: calculation_1},
          {id: " Casey Knapp - calculation_1", name: " Casey Knapp", axisId: calculation_1},
          {id: " Chris Daniel - calculation_1", name: " Chris Daniel", axisId: calculation_1},
          {id: " Chris Martin - calculation_1", name: " Chris Martin", axisId: calculation_1},
          {id: " Christian Lunoe - calculation_1", name: " Christian Lunoe", axisId: calculation_1},
          {id: " Colin Murphy - calculation_1", name: " Colin Murphy", axisId: calculation_1},
          {id: " Cory Hershey - calculation_1", name: " Cory Hershey", axisId: calculation_1},
          {id: " Courtney Leonard - calculation_1", name: " Courtney Leonard", axisId: calculation_1},
          {id: " Danielle Muzzini - calculation_1", name: " Danielle Muzzini", axisId: calculation_1},
          {id: " Daryl Weinhoff - calculation_1", name: " Daryl Weinhoff", axisId: calculation_1},
          {id: " David Belliot - calculation_1", name: " David Belliot", axisId: calculation_1},
          {id: " Dermott Ryan - calculation_1", name: " Dermott Ryan", axisId: calculation_1},
          {id: " Derrich Beauchamp - calculation_1", name: " Derrich Beauchamp", axisId: calculation_1},
          {id: " Diego Simkin - calculation_1", name: " Diego Simkin", axisId: calculation_1},
          {id: " Dillon Ford - calculation_1", name: " Dillon Ford", axisId: calculation_1},
          {id: " Doug Berscak - calculation_1", name: " Doug Berscak", axisId: calculation_1},
          {id: " Eoin Mulcahy - calculation_1", name: " Eoin Mulcahy", axisId: calculation_1},
          {id: " Ethel Anderson - calculation_1", name: " Ethel Anderson", axisId: calculation_1},
          {id: " Evelyn Shen - calculation_1", name: " Evelyn Shen", axisId: calculation_1},
          {id: " Fabien Sabat - calculation_1", name: " Fabien Sabat", axisId: calculation_1},
          {id: " Fernando Leon - calculation_1", name: " Fernando Leon", axisId: calculation_1},
          {id: " Graham Norwood - calculation_1", name: " Graham Norwood", axisId: calculation_1},
          {id: " Gurpal Singh - calculation_1", name: " Gurpal Singh", axisId: calculation_1},
          {id: " Hank Ritter - calculation_1", name: " Hank Ritter", axisId: calculation_1},
          {id: " Hanna Givelber - calculation_1", name: " Hanna Givelber", axisId: calculation_1},
          {id: " Holly Meadows Smith - calculation_1", name: " Holly Meadows Smith",
            axisId: calculation_1}, {id: " Jaleel Mackey - calculation_1", name: " Jaleel\
              \ Mackey", axisId: calculation_1}, {id: " Jeff De La Cruz - calculation_1",
            name: " Jeff De La Cruz", axisId: calculation_1}, {id: " Jeff Garcia -\
              \ calculation_1", name: " Jeff Garcia", axisId: calculation_1}, {id: " Jeff\
              \ Van Earwage - calculation_1", name: " Jeff Van Earwage", axisId: calculation_1},
          {id: " Jethro Law - calculation_1", name: " Jethro Law", axisId: calculation_1}],
        showLabels: false, showValues: true, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
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
    show_null_points: true
    interpolation: linear
    hidden_fields: [opportunity.win_percentage]
    listen:
      Sales Rep: opportunity_owner.name_select
    row: 32
    col: 0
    width: 17
    height: 8
  filters:
  - name: Sales Rep
    title: Sales Rep
    type: field_filter
    default_value: "{{ _user_attributes['name'] }}"
    allow_multiple_values: true
    required: false
    model: sales_analytics
    explore: opportunity
    listens_to_filters: []
    field: opportunity_owner.name_select
