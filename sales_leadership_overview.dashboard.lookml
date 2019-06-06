- dashboard: sales_leadership_quarter_overview
  title: Sales Leadership Quarter Overview
  extends:  sales_analytics_base
  embed_style:
    background_color: "#ffffff"
    title_color: "#3a4245"
    tile_text_color: "#3a4245"
    text_tile_text_color: ''
  elements:
  - title: Customers
    name: Customers
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields: [account.count_customers, opportunity.count_new_business_won_ytd]
    filters:
      account.business_segment: ''
    limit: 500
    column_limit: 50
    custom_color_enabled: true
    custom_color: ''
    show_single_value_title: true
    single_value_title: ''
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: false
    show_comparison_label: true
    comparison_label: New Customers - YTD
    font_size: small
    hidden_fields:
    listen:
      Sales Rep: opportunity_owner.name
      Manager: opportunity_owner.manager
      Region: opportunity_owner.ae_region
      Opportunity Type: opportunity.type
    row: 4
    col: 15
    width: 3
    height: 4
  - title: New Customers
    name: New Customers
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields: [opportunity.count_new_business_won, opportunity.close_fiscal_quarter]
    pivots: [opportunity.close_fiscal_quarter]
    fill_fields: [opportunity.close_fiscal_quarter]
    filters:
      opportunity.close_fiscal_quarter: this fiscal quarter, last fiscal quarter
    sorts: [opportunity.close_fiscal_quarter desc]
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: change, label: Change, expression: 'pivot_index(${opportunity.count_new_business_won},
          1) - pivot_index(${opportunity.count_new_business_won}, 2)', value_format: !!null '',
        value_format_name: decimal_0, _kind_hint: supermeasure, _type_hint: number}]
    filter_expression: |-
      # Only compare QTDs
      ${opportunity.day_of_fiscal_quarter} <= ${opportunity.current_day_of_fiscal_quarter}
    custom_color_enabled: true
    custom_color: ''
    show_single_value_title: true
    single_value_title: ''
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: false
    show_comparison_label: true
    comparison_label: vs. Last Quarter
    font_size: small
    hidden_fields:
    listen:
      Sales Rep: opportunity_owner.name
      Manager: opportunity_owner.manager
      Region: opportunity_owner.ae_region
      Opportunity Type: opportunity.type
    row: 4
    col: 18
    width: 3
    height: 4
  - title: of Quota
    name: of Quota
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields: [opportunity.percent_of_quarter_reached, opportunity.percent_of_quota_reached]
    filters:
      opportunity.close_fiscal_quarter: this fiscal quarter
    limit: 1000
    column_limit: 50
    custom_color_enabled: true
    custom_color: ''
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    comparison_label: Quarter Complete
    font_size: medium
    text_color: black
    hidden_fields: [opportunity.total_closed_won_revenue, quota_numbers.quarterly_aggregate_quota_measure]
    listen:
      Sales Rep: opportunity_owner.name
      Manager: opportunity_owner.manager
      Region: opportunity_owner.ae_region
      Opportunity Type: opportunity.type
    row: 4
    col: 21
    width: 3
    height: 4
  - title: Quota Attainment
    name: Quota Attainment
    model: sales_analytics
    explore: opportunity
    type: looker_area
    fields: [opportunity.total_closed_won_new_business_amount, opportunity.close_quarter_pivot,
      opportunity.day_of_fiscal_quarter, quota.quarterly_aggregate_quota_measure]
    pivots: [opportunity.close_quarter_pivot]
    fill_fields: [opportunity.close_quarter_pivot]
    filters:
      opportunity.close_date: before 1 days from now
      opportunity.close_fiscal_quarter: this fiscal quarter, last fiscal quarter,
        4 fiscal quarters ago for 1 fiscal quarter
    sorts: [opportunity.close_quarter_pivot 0, opportunity.day_of_fiscal_quarter]
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: running_total_of_amount, label: Running Total
          of Amount, expression: 'running_total(${opportunity.total_closed_won_new_business_amount})',
        value_format: !!null '', value_format_name: usd_0, _kind_hint: measure, _type_hint: number},
      {table_calculation: percent_of_quota, label: Percent of Quota, expression: "${running_total_of_amount}/${quota.quarterly_aggregate_quota_measure}",
        value_format: !!null '', value_format_name: percent_2, _kind_hint: measure,
        _type_hint: number}, {table_calculation: goal, label: Goal, expression: 'if(mod(row(),2)
          = 0,pivot_where(pivot_column() = 1, 1)*0 + 1,null)', value_format: !!null '',
        value_format_name: !!null '', _kind_hint: supermeasure, _type_hint: number}]
    color_application:
      collection_id: 5f313589-67ce-44ba-b084-ec5107a7bb7e
      palette_id: be92eae7-de25-46ae-8e4f-21cb0b69a1f3
      options:
        steps: 5
        __FILE: app-sales/sales_leadership_overview_2.dashboard.lookml
        __LINE_NUM: 390
    x_axis_gridlines: false
    y_axis_gridlines: false
    show_view_names: false
    y_axes: [{label: '', orientation: left, series: [{id: 2019-01 - of_quota, name: This
              Quarter, axisId: of_quota, __FILE: app-sales/sales_leadership_overview_2.dashboard.lookml,
            __LINE_NUM: 396}, {id: 2018-10 - of_quota, name: Last Quarter, axisId: of_quota,
            __FILE: app-sales/sales_leadership_overview_2.dashboard.lookml, __LINE_NUM: 398},
          {id: 2018-07 - of_quota, name: 2018-Q3 - % of Quota, axisId: of_quota, __FILE: app-sales/sales_leadership_overview_2.dashboard.lookml,
            __LINE_NUM: 400}, {id: 2018-04 - of_quota, name: 2018-Q2 - % of Quota,
            axisId: of_quota, __FILE: app-sales/sales_leadership_overview_2.dashboard.lookml,
            __LINE_NUM: 401}, {id: 2018-01 - of_quota, name: 2018-Q1 - % of Quota,
            axisId: of_quota, __FILE: app-sales/sales_leadership_overview_2.dashboard.lookml,
            __LINE_NUM: 403}, {id: goal, name: Goal, axisId: goal, __FILE: app-sales/sales_leadership_overview_2.dashboard.lookml,
            __LINE_NUM: 405}], showLabels: true, showValues: true, maxValue: !!null '',
        minValue: !!null '', valueFormat: 0%, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear, __FILE: app-sales/sales_leadership_overview_2.dashboard.lookml,
        __LINE_NUM: 396}]
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    hidden_series: [2018-10 - calculation_5, 2018-07 - percent_of_quota, 2018-07 -
        calculation_5, 2018-04 - calculation_5, 2018-01 - calculation_5, 2018-04 -
        percent_of_quota]
    legend_position: center
    series_types:
      goal: scatter
    point_style: none
    series_colors: {}
    series_labels:
      2019-01 - of_quota: This Quarter
      2018-10 - of_quota: Last Quarter
      2019-01 - percent_of_quota: This Quarter
      2018-10 - percent_of_quota: Last Quarter
      2018-01 - percent_of_quota: This Quarter - Last Year
      This Quarter - 0 - percent_of_quota: This Quarter
      Last Quarter - 1 - percent_of_quota: Last Quarter
      Last Year - 2 - percent_of_quota: Last Year
    series_point_styles: {}
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: false
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    hidden_fields: [quota_quarter_goals.quota_sum, opportunity.total_closed_won_revenue,
      opportunity.total_closed_won_new_business_amount, running_total_of_amount, current_date,
      quota_numbers.quarterly_aggregate_quota_measure, aggregate_quota.quarterly_aggregate_quota_measure,
      quota.quarterly_aggregate_quota_measure]
    listen:
      Sales Rep: opportunity_owner.name
      Manager: opportunity_owner.manager
      Region: opportunity_owner.ae_region
      Opportunity Type: opportunity.type
    row: 0
    col: 0
    width: 15
    height: 13
  - title: New Bookings
    name: New Bookings
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields: [opportunity.total_closed_won_new_business_amount, opportunity.close_fiscal_quarter]
    pivots: [opportunity.close_fiscal_quarter]
    fill_fields: [opportunity.close_fiscal_quarter]
    filters:
      opportunity.close_fiscal_quarter: this fiscal quarter, last fiscal quarter
    sorts: [opportunity.close_fiscal_quarter desc]
    dynamic_fields: [{table_calculation: qoq_change, label: QoQ Change, expression: 'pivot_index(${opportunity.total_closed_won_new_business_amount},
          1) - pivot_index(${opportunity.total_closed_won_new_business_amount}, 2)',
        value_format: !!null '', value_format_name: usd_0, _kind_hint: supermeasure,
        _type_hint: number}, {table_calculation: formatted_yoy_change, label: Formatted
          YoY Change, expression: "concat(if(${qoq_change} > 0, \"+\", \"\"),if(abs(${qoq_change})\
          \ >= 1000000, concat(round(${qoq_change}/1000000,1),\"M\"), \n  \n    if(abs(${qoq_change})\
          \ >= 1000, concat(round(${qoq_change}/1000,1),\"K\"), to_string(${qoq_change}))\n\
          \        ))", value_format: !!null '', value_format_name: !!null '', _kind_hint: supermeasure,
        _type_hint: string}]
    filter_expression: |-
      # Only compare QTDs
      ${opportunity.day_of_fiscal_quarter} <= ${opportunity.current_day_of_fiscal_quarter}
    color_application:
      collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7
      palette_id: fb7bb53e-b77b-4ab6-8274-9d420d3d73f3
    custom_color_enabled: true
    custom_color: ''
    show_single_value_title: true
    single_value_title: ''
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    comparison_label: vs. Last Quarter
    font_size: medium
    text_color: black
    hidden_fields: [opportunity.total_closed_won_revenue, change, yoy_change, qoq_change]
    listen:
      Sales Rep: opportunity_owner.name
      Manager: opportunity_owner.manager
      Region: opportunity_owner.ae_region
      Opportunity Type: opportunity.type
    row: 0
    col: 15
    width: 9
    height: 4
  - title: Performance vs Quota (QTD)
    name: Performance vs Quota (QTD)
    model: sales_analytics
    explore: opportunity
    type: looker_line
    fields: [opportunity.close_date, opportunity.total_closed_won_new_business_amount,
      quota.quarterly_aggregate_quota_measure]
    fill_fields: [opportunity.close_date]
    filters:
      account.business_segment: ''
      opportunity.close_fiscal_quarter: this fiscal quarter
    sorts: [opportunity.close_date]
    limit: 1000
    column_limit: 50
    dynamic_fields: [{table_calculation: quota_per_day, label: Quota Per Day, expression: "${quota_as_table_calc}/count(row())",
        value_format: !!null '', value_format_name: usd_0, _kind_hint: measure, _type_hint: number},
      {table_calculation: grab_quota_value, label: Grab Quota Value, expression: "#\
          \ Used to account for the fact that the measure might be null for dates\
          \ that are dimensino-filled in.\n# We take the max of an offset list of\
          \ our quuarterly agg quota measure column, so as long as at least one row\
          \ has a non-dimension filled close date, we can grab the quota value\n\n\
          if(row() = 1, max(offset_list(${quota.quarterly_aggregate_quota_measure},0,91)),null)",
        value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
        _type_hint: number}, {table_calculation: quota_as_table_calc, label: Quota
          as Table Calc, expression: 'offset(${grab_quota_value},-1*(row()-1))', value_format: !!null '',
        value_format_name: !!null '', _kind_hint: measure, _type_hint: number}, {
        table_calculation: cumulative_quota, label: Cumulative Quota, expression: 'running_total(${quota_per_day})
          + ${opportunity.total_closed_won_new_business_amount}*0', value_format: '[>=1000000]$0.00,,"M";[>=1000]$0.00,"K";$0.00',
        value_format_name: !!null '', _kind_hint: measure, _type_hint: number}, {
        table_calculation: cumulative_total_won, label: Cumulative Total Won, expression: 'running_total(${opportunity.total_closed_won_new_business_amount})',
        value_format: '[>=1000000]$0.00,,"M";[>=1000]$0.00,"K";$0.00', value_format_name: !!null '',
        _kind_hint: measure, _type_hint: number}, {table_calculation: is_before_today,
        label: Is before today, expression: "${opportunity.close_date} < now()", value_format: !!null '',
        value_format_name: !!null '', _kind_hint: dimension, _type_hint: yesno}]
    trellis: ''
    stacking: ''
    color_application:
      collection_id: 5f313589-67ce-44ba-b084-ec5107a7bb7e
      palette_id: be92eae7-de25-46ae-8e4f-21cb0b69a1f3
      options:
        steps: 5
        __FILE: app-sales/sales_leadership_overview_2.dashboard.lookml
        __LINE_NUM: 502
    show_value_labels: false
    label_density: 25
    font_size: medium
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: false
    show_view_names: false
    point_style: none
    series_colors:
      cumulative_total_won: "#FFB690"
    series_types:
      cumulative_total_won: column
    limit_displayed_rows: false
    hidden_series: []
    y_axes: [{label: !!null '', orientation: left, series: [{id: cumulative_quota,
            name: Cumulative Quota, axisId: cumulative_quota, __FILE: app-sales/sales_leadership_overview_2.dashboard.lookml,
            __LINE_NUM: 519}, {id: cumulative_total_won, name: Cumulative Total Won,
            axisId: cumulative_total_won, __FILE: app-sales/sales_leadership_overview_2.dashboard.lookml,
            __LINE_NUM: 521}], showLabels: false, showValues: true, unpinAxis: false,
        tickDensity: default, type: linear, __FILE: app-sales/sales_leadership_overview_2.dashboard.lookml,
        __LINE_NUM: 519}]
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
    show_null_points: false
    interpolation: linear
    discontinuous_nulls: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    custom_color_enabled: true
    custom_color: ''
    show_single_value_title: true
    show_comparison: false
    comparison_type: change
    comparison_reverse_colors: false
    show_comparison_label: false
    text_color: black
    hidden_fields: [opportunity.total_closed_won_revenue, quota_per_day, quota_numbers.quarterly_aggregate_quota_measure,
      quota_as_table_calc, grab_quota_value, opportunity.total_closed_won_new_business_amount,
      aggregate_quota.quarterly_aggregate_quota_measure, quota.quarterly_aggregate_quota_measure]
    hidden_points_if_no: [is_before_today]
    listen:
      Sales Rep: opportunity_owner.name
      Manager: opportunity_owner.manager
      Region: opportunity_owner.ae_region
      Opportunity Type: opportunity.type
    row: 8
    col: 15
    width: 9
    height: 5
  - title: Bookings by Geography
    name: Bookings by Geography
    model: sales_analytics
    explore: opportunity
    type: looker_map
    fields: [account.billing_state, opportunity.total_closed_won_new_business_amount]
    filters:
      account.billing_country: USA,United States
      opportunity.total_closed_won_new_business_amount: ">0"
      opportunity.close_fiscal_quarter: this fiscal quarter
    sorts: [opportunity.total_closed_won_new_business_amount desc]
    limit: 500
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
    map_value_colors: ["#170658", "#a49bc1"]
    quantize_map_value_colors: false
    reverse_map_value_colors: true
    listen:
      Sales Rep: opportunity_owner.name
      Manager: opportunity_owner.manager
      Region: opportunity_owner.ae_region
      Opportunity Type: opportunity.type
    row: 13
    col: 12
    width: 12
    height: 13
  - title: Funnel
    name: Funnel
    model: sales_analytics
    explore: opportunity
    type: looker_funnel
    fields: [opportunity_stage_history.stage, opportunity_stage_history.opps_in_each_stage]
    filters:
      opportunity_stage_history.stage: "-NULL,-EMPTY"
      opportunity.close_fiscal_quarter: this fiscal quarter
    sorts: [opportunity_stage_history.opps_in_each_stage desc]
    limit: 500
    leftAxisLabelVisible: false
    leftAxisLabel: ''
    rightAxisLabelVisible: false
    rightAxisLabel: ''
    color_application:
      collection_id: 5f313589-67ce-44ba-b084-ec5107a7bb7e
      custom:
        id: '09c2057c-4bc3-f84e-75df-f66f7d9a4287'
        label: Custom
        type: discrete
        colors:
        - "#593A69"
        - "#715180"
        - "#896997"
        - "#A181AE"
        - "#B998C5"
        - "#D1B0DC"
        - "#EAC8F3"
        __FILE: app-sales/sales_leadership_overview_2.dashboard.lookml
        __LINE_NUM: 584
      options:
        steps: 5
        __FILE: app-sales/sales_leadership_overview_2.dashboard.lookml
        __LINE_NUM: 598
    smoothedBars: true
    orientation: automatic
    labelPosition: left
    percentType: total
    percentPosition: inline
    valuePosition: right
    labelColorEnabled: false
    labelColor: "#FFF"
    series_types: {}
    listen:
      Sales Rep: opportunity_owner.name
      Manager: opportunity_owner.manager
      Region: opportunity_owner.ae_region
      Opportunity Type: opportunity.type
    row: 13
    col: 0
    width: 12
    height: 13
  - title: Quarterly New Bookings by Source
    name: Quarterly New Bookings by Source
    model: sales_analytics
    explore: opportunity
    type: looker_column
    fields: [opportunity.source, opportunity.total_closed_won_new_business_amount,
      opportunity.close_fiscal_quarter]
    pivots: [opportunity.source]
    fill_fields: [opportunity.close_fiscal_quarter]
    filters:
      account.business_segment: "-Unknown"
      opportunity.close_fiscal_quarter: 4 fiscal quarters
    sorts: [opportunity.source 0, opportunity.close_fiscal_quarter]
    limit: 500
    column_limit: 10
    trellis: ''
    stacking: normal
    color_application:
      collection_id: 5f313589-67ce-44ba-b084-ec5107a7bb7e
      custom:
        id: 9befdbdb-5826-6369-9c96-58be74dfe360
        label: Custom
        type: continuous
        stops:
        - color: "#f3dbe0"
          offset: 0
          __FILE: app-sales/sales_leadership_overview_2.dashboard.lookml
          __LINE_NUM: 176
        - color: "#D978A1"
          offset: 100
          __FILE: app-sales/sales_leadership_overview_2.dashboard.lookml
          __LINE_NUM: 180
        __FILE: app-sales/sales_leadership_overview_2.dashboard.lookml
        __LINE_NUM: 172
      options:
        steps: 5
        __FILE: app-sales/sales_leadership_overview_2.dashboard.lookml
        __LINE_NUM: 187
    show_value_labels: false
    label_density: 25
    font_size: '12'
    legend_position: center
    hide_legend: false
    x_axis_gridlines: false
    y_axis_gridlines: false
    show_view_names: false
    point_style: none
    series_colors: {}
    limit_displayed_rows: false
    y_axes: [{label: '', orientation: left, series: [{id: Alliances - opportunity.total_closed_won_new_business_amount,
            name: Alliances, axisId: Alliances - opportunity.total_closed_won_new_business_amount,
            __FILE: app-sales/sales_leadership_overview_2.dashboard.lookml, __LINE_NUM: 201},
          {id: Marketing - opportunity.total_closed_won_new_business_amount, name: Marketing,
            axisId: Marketing - opportunity.total_closed_won_new_business_amount,
            __FILE: app-sales/sales_leadership_overview_2.dashboard.lookml, __LINE_NUM: 204},
          {id: Other - opportunity.total_closed_won_new_business_amount, name: Other,
            axisId: Other - opportunity.total_closed_won_new_business_amount, __FILE: app-sales/sales_leadership_overview_2.dashboard.lookml,
            __LINE_NUM: 207}, {id: SDR - opportunity.total_closed_won_new_business_amount,
            name: SDR, axisId: SDR - opportunity.total_closed_won_new_business_amount,
            __FILE: app-sales/sales_leadership_overview_2.dashboard.lookml, __LINE_NUM: 209}],
        showLabels: false, showValues: false, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear, __FILE: app-sales/sales_leadership_overview_2.dashboard.lookml,
        __LINE_NUM: 201}]
    y_axis_combined: false
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
    y_axis_orientation: [left, right]
    ordering: none
    show_null_labels: false
    show_totals_labels: true
    show_silhouette: false
    totals_color: "#808080"
    listen:
      Sales Rep: opportunity_owner.name
      Manager: opportunity_owner.manager
      Region: opportunity_owner.ae_region
      Opportunity Type: opportunity.type
    row: 26
    col: 0
    width: 12
    height: 6
  - title: Pipeline Forecast
    name: Pipeline Forecast
    model: sales_analytics
    explore: opportunity
    type: looker_column
    fields: [opportunity.total_pipeline_amount, opportunity.custom_stage_name, opportunity.close_fiscal_quarter]
    pivots: [opportunity.custom_stage_name]
    fill_fields: [opportunity.close_fiscal_quarter]
    filters:
      opportunity.custom_stage_name: "-Unknown"
      opportunity.close_fiscal_quarter: 0 fiscal quarters ago for 4 fiscal quarters
    sorts: [opportunity.custom_stage_name 0, opportunity.close_fiscal_quarter]
    limit: 500
    stacking: normal
    trellis: ''
    color_application:
      collection_id: 5f313589-67ce-44ba-b084-ec5107a7bb7e
      custom:
        id: 1246f89a-2e59-24c6-cbc6-cdef2825eb9b
        label: Custom
        type: continuous
        stops:
        - color: "#FED8A0"
          offset: 0
          __FILE: app-sales/sales_leadership_overview_2.dashboard.lookml
          __LINE_NUM: 640
        - color: "#C762AD"
          offset: 50
          __FILE: app-sales/sales_leadership_overview_2.dashboard.lookml
          __LINE_NUM: 644
        - color: "#462C9D"
          offset: 100
          __FILE: app-sales/sales_leadership_overview_2.dashboard.lookml
          __LINE_NUM: 648
        __FILE: app-sales/sales_leadership_overview_2.dashboard.lookml
        __LINE_NUM: 636
      options:
        steps: 5
        __FILE: app-sales/sales_leadership_overview_2.dashboard.lookml
        __LINE_NUM: 655
    show_value_labels: false
    label_density: 25
    label_color: ["#FFFFFF"]
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: false
    show_view_names: false
    point_style: none
    series_colors: {}
    series_types: {}
    limit_displayed_rows: false
    hidden_series: [Lost - 6 - opportunity.total_revenue, Under 20% - 5 - opportunity.total_revenue,
      Won - 0 - opportunity.total_pipeline_amount, Lost - 6 - opportunity.total_pipeline_amount,
      Closed Won - 6 - opportunity.total_pipeline_amount]
    y_axes: [{label: Amount in Pipeline, orientation: left, series: [{id: Won - 0
              - opportunity.total_pipeline_amount, name: Won, axisId: Won - 0 - opportunity.total_pipeline_amount,
            __FILE: app-sales/sales_leadership_overview_2.dashboard.lookml, __LINE_NUM: 672},
          {id: Above 80% - 1 - opportunity.total_pipeline_amount, name: Above 80%,
            axisId: Above 80% - 1 - opportunity.total_pipeline_amount, __FILE: app-sales/sales_leadership_overview_2.dashboard.lookml,
            __LINE_NUM: 675}, {id: 60 - 80% - 2 - opportunity.total_pipeline_amount,
            name: 60 - 80%, axisId: 60 - 80% - 2 - opportunity.total_pipeline_amount,
            __FILE: app-sales/sales_leadership_overview_2.dashboard.lookml, __LINE_NUM: 677},
          {id: 40 - 60% - 3 - opportunity.total_pipeline_amount, name: 40 - 60%, axisId: 40
              - 60% - 3 - opportunity.total_pipeline_amount, __FILE: app-sales/sales_leadership_overview_2.dashboard.lookml,
            __LINE_NUM: 680}, {id: 20 - 40% - 4 - opportunity.total_pipeline_amount,
            name: 20 - 40%, axisId: 20 - 40% - 4 - opportunity.total_pipeline_amount,
            __FILE: app-sales/sales_leadership_overview_2.dashboard.lookml, __LINE_NUM: 682},
          {id: Under 20% - 5 - opportunity.total_pipeline_amount, name: Under 20%,
            axisId: Under 20% - 5 - opportunity.total_pipeline_amount, __FILE: app-sales/sales_leadership_overview_2.dashboard.lookml,
            __LINE_NUM: 685}, {id: Lost - 6 - opportunity.total_pipeline_amount, name: Lost,
            axisId: Lost - 6 - opportunity.total_pipeline_amount, __FILE: app-sales/sales_leadership_overview_2.dashboard.lookml,
            __LINE_NUM: 687}], showLabels: false, showValues: false, valueFormat: '$0.0,,
          "M"', unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear,
        __FILE: app-sales/sales_leadership_overview_2.dashboard.lookml, __LINE_NUM: 672}]
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    x_axis_label: ''
    show_x_axis_ticks: true
    x_axis_datetime_label: ''
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
      Sales Rep: opportunity_owner.name
      Manager: opportunity_owner.manager
      Region: opportunity_owner.ae_region
      Opportunity Type: opportunity.type
    row: 32
    col: 0
    width: 24
    height: 10
  - title: Quarterly New Bookings by Business Segment
    name: Quarterly New Bookings by Business Segment
    model: sales_analytics
    explore: opportunity
    type: looker_column
    fields: [account.business_segment, opportunity.total_closed_won_new_business_amount,
      opportunity.close_fiscal_quarter]
    pivots: [account.business_segment]
    fill_fields: [opportunity.close_fiscal_quarter]
    filters:
      account.business_segment: "-Unknown"
      opportunity.close_fiscal_quarter: 4 fiscal quarters
    sorts: [account.business_segment 0, opportunity.close_fiscal_quarter]
    limit: 500
    column_limit: 50
    row_total: right
    color_application:
      collection_id: 5f313589-67ce-44ba-b084-ec5107a7bb7e
      palette_id: b20fe57d-cb13-420f-815b-60e907a43148
      options:
        steps: 5
        __FILE: app-sales/sales_leadership_overview_2.dashboard.lookml
        __LINE_NUM: 261
    x_axis_gridlines: false
    y_axis_gridlines: false
    show_view_names: false
    y_axes: [{label: '', orientation: left, series: [{id: Small Business - 0 - opportunity.total_closed_won_new_business_amount,
            name: Small Business, axisId: Small Business - 0 - opportunity.total_closed_won_new_business_amount,
            __FILE: app-sales/sales_leadership_overview_2.dashboard.lookml, __LINE_NUM: 267},
          {id: Mid-Market - 1 - opportunity.total_closed_won_new_business_amount,
            name: Mid-Market, axisId: Mid-Market - 1 - opportunity.total_closed_won_new_business_amount,
            __FILE: app-sales/sales_leadership_overview_2.dashboard.lookml, __LINE_NUM: 270},
          {id: Enterprise - 2 - opportunity.total_closed_won_new_business_amount,
            name: Enterprise, axisId: Enterprise - 2 - opportunity.total_closed_won_new_business_amount,
            __FILE: app-sales/sales_leadership_overview_2.dashboard.lookml, __LINE_NUM: 273}],
        showLabels: false, showValues: false, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear, __FILE: app-sales/sales_leadership_overview_2.dashboard.lookml,
        __LINE_NUM: 267}]
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
    limit_displayed_rows: false
    hide_legend: false
    legend_position: center
    font_size: '12'
    point_style: none
    series_colors:
      Mid-Market - 1 - opportunity.total_closed_won_new_business_amount: "#735eae"
      Small Business - 0 - opportunity.total_closed_won_new_business_amount: "#9f92cb"
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: false
    y_axis_orientation: [left, right]
    ordering: none
    show_null_labels: false
    show_totals_labels: true
    show_silhouette: false
    totals_color: "#808080"
    listen:
      Sales Rep: opportunity_owner.name
      Manager: opportunity_owner.manager
      Region: opportunity_owner.ae_region
      Opportunity Type: opportunity.type
    row: 26
    col: 12
    width: 12
    height: 6
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
    field: opportunity_owner.name
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
  - name: Region
    title: Region
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: sales_analytics
    explore: opportunity
    listens_to_filters: []
    field: opportunity_owner.ae_region
  - name: Opportunity Type
    title: Opportunity Type
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: sales_analytics
    explore: opportunity
    listens_to_filters: []
    field: opportunity.type
