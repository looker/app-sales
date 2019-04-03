- dashboard: sales_leadership_quarter_overview
  title: Sales Leadership Quarter Overview
  extends: sales_analytics_base
  embed_style:
    background_color: "#ffffff"
    title_color: "#3a4245"
    tile_text_color: "#3a4245"
    text_tile_text_color: ''
  elements:
  - title: New Customers
    name: New Customers
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields: [opportunity.count_new_business_won, opportunity.close_year]
    pivots: [opportunity.close_year]
    fill_fields: [opportunity.close_year]
    filters:
      opportunity.close_date: 0 quarters ago for 1 quarter, 4 quarters ago for 1 quarter
      opportunity.type: New Business
    sorts: [opportunity.close_year desc]
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: this_quarter, label: This Quarter, expression: 'pivot_index(${opportunity.count_new_business_won},
          1)

          ', value_format: !!null '', value_format_name: !!null '', _kind_hint: supermeasure,
        _type_hint: number}, {table_calculation: change, label: Change, expression: "(pivot_index(${opportunity.count_new_business_won},\
          \ 1) - pivot_index(${opportunity.count_new_business_won}, 2))/pivot_index(${opportunity.count_new_business_won},\
          \ 2)", value_format: !!null '', value_format_name: percent_0, _kind_hint: supermeasure,
        _type_hint: number}]
    filter_expression: "((extract_years(now())=extract_years(${opportunity.close_year})\n\
      \   AND ${opportunity.close_year} <= now())\n\nOR \n\n(((extract_years(now())-1)=extract_years(${opportunity.close_year})\n\
      \  AND ${opportunity.close_year} <= add_years(-1,now()))\n\nAND\n\n(extract_months(${opportunity.close_date})\
      \ = extract_months(now())\nAND\nextract_days(${opportunity.close_date}) <= extract_days(now()))\n\
      \nOR\n\nextract_months(${opportunity.close_date}) < extract_months(now())))"
    custom_color_enabled: true
    custom_color: ''
    show_single_value_title: true
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: false
    show_comparison_label: false
    font_size: small
    hidden_fields: [opportunity.count_new_business_won]
    listen: {}
    row: 2
    col: 18
    width: 3
    height: 4
  - title: Pipeline Forecast
    name: Pipeline Forecast
    model: sales_analytics
    explore: opportunity
    type: looker_column
    fields: [opportunity.close_quarter, opportunity.total_pipeline_amount, opportunity.custom_stage_name]
    pivots: [opportunity.custom_stage_name]
    fill_fields: [opportunity.close_quarter]
    filters:
      opportunity.close_quarter: 0 quarters ago for 4 quarters
      opportunity.custom_stage_name: "-Unknown"
    sorts: [opportunity.close_quarter, opportunity.custom_stage_name]
    limit: 500
    query_timezone: America/Los_Angeles
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
          __FILE: app-sales/sales_leadership_overview.dashboard.lookml
          __LINE_NUM: 69
        - color: "#C762AD"
          offset: 50
          __FILE: app-sales/sales_leadership_overview.dashboard.lookml
          __LINE_NUM: 71
        - color: "#462C9D"
          offset: 100
          __FILE: app-sales/sales_leadership_overview.dashboard.lookml
          __LINE_NUM: 73
        __FILE: app-sales/sales_leadership_overview.dashboard.lookml
        __LINE_NUM: 65
      options:
        steps: 5
        __FILE: app-sales/sales_leadership_overview.dashboard.lookml
        __LINE_NUM: 76
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
            __FILE: app-sales/sales_leadership_overview.dashboard.lookml, __LINE_NUM: 91},
          {id: Above 80% - 1 - opportunity.total_pipeline_amount, name: Above 80%,
            axisId: Above 80% - 1 - opportunity.total_pipeline_amount, __FILE: app-sales/sales_leadership_overview.dashboard.lookml,
            __LINE_NUM: 93}, {id: 60 - 80% - 2 - opportunity.total_pipeline_amount,
            name: 60 - 80%, axisId: 60 - 80% - 2 - opportunity.total_pipeline_amount,
            __FILE: app-sales/sales_leadership_overview.dashboard.lookml, __LINE_NUM: 94},
          {id: 40 - 60% - 3 - opportunity.total_pipeline_amount, name: 40 - 60%, axisId: 40
              - 60% - 3 - opportunity.total_pipeline_amount, __FILE: app-sales/sales_leadership_overview.dashboard.lookml,
            __LINE_NUM: 96}, {id: 20 - 40% - 4 - opportunity.total_pipeline_amount,
            name: 20 - 40%, axisId: 20 - 40% - 4 - opportunity.total_pipeline_amount,
            __FILE: app-sales/sales_leadership_overview.dashboard.lookml, __LINE_NUM: 98},
          {id: Under 20% - 5 - opportunity.total_pipeline_amount, name: Under 20%,
            axisId: Under 20% - 5 - opportunity.total_pipeline_amount, __FILE: app-sales/sales_leadership_overview.dashboard.lookml,
            __LINE_NUM: 100}, {id: Lost - 6 - opportunity.total_pipeline_amount, name: Lost,
            axisId: Lost - 6 - opportunity.total_pipeline_amount, __FILE: app-sales/sales_leadership_overview.dashboard.lookml,
            __LINE_NUM: 101}], showLabels: false, showValues: false, valueFormat: '$0.0,,
          "M"', unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear,
        __FILE: app-sales/sales_leadership_overview.dashboard.lookml, __LINE_NUM: 91}]
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
    listen: {}
    row: 36
    col: 0
    width: 24
    height: 10
  - title: Quarterly New Bookings by Business Segment
    name: Quarterly New Bookings by Business Segment
    model: sales_analytics
    explore: opportunity
    type: looker_column
    fields: [account.business_segment, opportunity.close_quarter, opportunity.total_closed_won_new_business_amount]
    pivots: [account.business_segment]
    fill_fields: [opportunity.close_quarter]
    filters:
      account.business_segment: "-Unknown"
      opportunity.close_quarter: 4 quarters
    sorts: [account.business_segment, account.business_segment__sort_, opportunity.close_quarter]
    limit: 500
    column_limit: 50
    row_total: right
    trellis: ''
    stacking: normal
    color_application:
      collection_id: 5f313589-67ce-44ba-b084-ec5107a7bb7e
      palette_id: a418cd33-fecf-4932-9933-dbd6652c610b
      options:
        steps: 5
        __FILE: app-sales/sales_leadership_overview.dashboard.lookml
        __LINE_NUM: 154
    show_value_labels: false
    label_density: 25
    font_size: '12'
    legend_position: center
    hide_legend: false
    x_axis_gridlines: false
    y_axis_gridlines: false
    show_view_names: false
    point_style: none
    series_colors:
      Mid-Market - 1 - opportunity.total_closed_won_new_business_amount: "#735eae"
      Small Business - 0 - opportunity.total_closed_won_new_business_amount: "#9f92cb"
    limit_displayed_rows: false
    y_axes: [{label: '', orientation: left, series: [{id: Small Business - 0 - opportunity.total_closed_won_new_business_amount,
            name: Small Business, axisId: Small Business - 0 - opportunity.total_closed_won_new_business_amount,
            __FILE: app-sales/sales_leadership_overview.dashboard.lookml, __LINE_NUM: 168},
          {id: Mid-Market - 1 - opportunity.total_closed_won_new_business_amount,
            name: Mid-Market, axisId: Mid-Market - 1 - opportunity.total_closed_won_new_business_amount,
            __FILE: app-sales/sales_leadership_overview.dashboard.lookml, __LINE_NUM: 170},
          {id: Enterprise - 2 - opportunity.total_closed_won_new_business_amount,
            name: Enterprise, axisId: Enterprise - 2 - opportunity.total_closed_won_new_business_amount,
            __FILE: app-sales/sales_leadership_overview.dashboard.lookml, __LINE_NUM: 172}],
        showLabels: false, showValues: false, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear, __FILE: app-sales/sales_leadership_overview.dashboard.lookml,
        __LINE_NUM: 168}]
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
    listen: {}
    row: 30
    col: 0
    width: 12
    height: 6
  - title: Quarterly New Bookings by Source
    name: Quarterly New Bookings by Source
    model: sales_analytics
    explore: opportunity
    type: looker_column
    fields: [opportunity.close_quarter, opportunity.source, opportunity.total_closed_won_new_business_amount]
    pivots: [opportunity.source]
    fill_fields: [opportunity.close_quarter]
    filters:
      account.business_segment: "-Unknown"
      opportunity.close_quarter: 4 quarters
    sorts: [opportunity.close_quarter, opportunity.source]
    limit: 500
    column_limit: 50
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
          __FILE: app-sales/sales_leadership_overview.dashboard.lookml
          __LINE_NUM: 222
        - color: "#D978A1"
          offset: 100
          __FILE: app-sales/sales_leadership_overview.dashboard.lookml
          __LINE_NUM: 224
        __FILE: app-sales/sales_leadership_overview.dashboard.lookml
        __LINE_NUM: 218
      options:
        steps: 5
        __FILE: app-sales/sales_leadership_overview.dashboard.lookml
        __LINE_NUM: 227
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
            __FILE: app-sales/sales_leadership_overview.dashboard.lookml, __LINE_NUM: 239},
          {id: Marketing - opportunity.total_closed_won_new_business_amount, name: Marketing,
            axisId: Marketing - opportunity.total_closed_won_new_business_amount,
            __FILE: app-sales/sales_leadership_overview.dashboard.lookml, __LINE_NUM: 241},
          {id: Other - opportunity.total_closed_won_new_business_amount, name: Other,
            axisId: Other - opportunity.total_closed_won_new_business_amount, __FILE: app-sales/sales_leadership_overview.dashboard.lookml,
            __LINE_NUM: 243}, {id: SDR - opportunity.total_closed_won_new_business_amount,
            name: SDR, axisId: SDR - opportunity.total_closed_won_new_business_amount,
            __FILE: app-sales/sales_leadership_overview.dashboard.lookml, __LINE_NUM: 244}],
        showLabels: false, showValues: false, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear, __FILE: app-sales/sales_leadership_overview.dashboard.lookml,
        __LINE_NUM: 239}]
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
    listen: {}
    row: 30
    col: 12
    width: 12
    height: 6
  - title: Customers
    name: Customers
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields: [account.count_customers, opportunity.count_new_business_won_ytd]
    filters:
      opportunity_owner.manager: ''
      account.business_segment: ''
    limit: 500
    column_limit: 50
    custom_color_enabled: true
    custom_color: ''
    show_single_value_title: true
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: false
    show_comparison_label: true
    comparison_label: YTD
    font_size: small
    hidden_fields:
    listen: {}
    row: 2
    col: 15
    width: 3
    height: 4
  - title: Bookings By Business Segment
    name: Bookings By Business Segment
    model: sales_analytics
    explore: opportunity
    type: looker_donut_multiples
    fields: [account.business_segment, opportunity.total_closed_won_new_business_amount,
      opportunity.close_year]
    pivots: [account.business_segment]
    fill_fields: [opportunity.close_year]
    filters:
      account.business_segment: "-Unknown"
      opportunity.close_quarter: this quarter, last year
    sorts: [account.business_segment, account.business_segment__sort_, opportunity.close_year]
    limit: 500
    column_limit: 50
    row_total: right
    show_value_labels: true
    font_size: 25
    hide_legend: false
    color_application:
      collection_id: 5f313589-67ce-44ba-b084-ec5107a7bb7e
      palette_id: a418cd33-fecf-4932-9933-dbd6652c610b
      options:
        steps: 5
        __FILE: app-sales/sales_leadership_overview.dashboard.lookml
        __LINE_NUM: 321
    series_colors:
      Enterprise - 2 - opportunity.total_closed_won_new_business_amount: "#462c9d"
      Mid-Market - 1 - opportunity.total_closed_won_new_business_amount: "#735eae"
      Small Business - 0 - opportunity.total_closed_won_new_business_amount: "#9f92cb"
    trellis: ''
    stacking: normal
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: false
    show_view_names: false
    point_style: none
    limit_displayed_rows: false
    y_axes: [{label: '', orientation: left, series: [{id: Small Business - 0 - opportunity.total_closed_won_new_business_amount,
            name: Small Business, axisId: Small Business - 0 - opportunity.total_closed_won_new_business_amount,
            __FILE: app-sales/sales_leadership_overview.dashboard.lookml, __LINE_NUM: 335},
          {id: Mid-Market - 1 - opportunity.total_closed_won_new_business_amount,
            name: Mid-Market, axisId: Mid-Market - 1 - opportunity.total_closed_won_new_business_amount,
            __FILE: app-sales/sales_leadership_overview.dashboard.lookml, __LINE_NUM: 337},
          {id: Enterprise - 2 - opportunity.total_closed_won_new_business_amount,
            name: Enterprise, axisId: Enterprise - 2 - opportunity.total_closed_won_new_business_amount,
            __FILE: app-sales/sales_leadership_overview.dashboard.lookml, __LINE_NUM: 339}],
        showLabels: false, showValues: false, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear, __FILE: app-sales/sales_leadership_overview.dashboard.lookml,
        __LINE_NUM: 335}]
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
    y_axis_orientation: [left, right]
    ordering: none
    show_null_labels: false
    show_totals_labels: true
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    listen: {}
    row: 24
    col: 0
    width: 12
    height: 6
  - title: Bookings by Source
    name: Bookings by Source
    model: sales_analytics
    explore: opportunity
    type: looker_donut_multiples
    fields: [opportunity.total_closed_won_new_business_amount, opportunity.close_year,
      opportunity.source]
    pivots: [opportunity.source]
    fill_fields: [opportunity.close_year]
    filters:
      account.business_segment: "-Unknown"
      opportunity.close_quarter: this quarter, last year
    sorts: [opportunity.close_year, opportunity.source]
    limit: 500
    column_limit: 50
    row_total: right
    show_value_labels: true
    font_size: 25
    hide_legend: false
    color_application:
      collection_id: 5f313589-67ce-44ba-b084-ec5107a7bb7e
      custom:
        id: 2489d897-97ba-c479-3978-b11422ddc318
        label: Custom
        type: continuous
        stops:
        - color: "#f3dbe0"
          offset: 0
          __FILE: app-sales/sales_leadership_overview.dashboard.lookml
          __LINE_NUM: 393
        - color: "#D978A1"
          offset: 100
          __FILE: app-sales/sales_leadership_overview.dashboard.lookml
          __LINE_NUM: 395
        __FILE: app-sales/sales_leadership_overview.dashboard.lookml
        __LINE_NUM: 389
      options:
        steps: 5
        __FILE: app-sales/sales_leadership_overview.dashboard.lookml
        __LINE_NUM: 398
    series_colors: {}
    trellis: ''
    stacking: normal
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: false
    show_view_names: false
    point_style: none
    limit_displayed_rows: false
    y_axes: [{label: '', orientation: left, series: [{id: Small Business - 0 - opportunity.total_closed_won_new_business_amount,
            name: Small Business, axisId: Small Business - 0 - opportunity.total_closed_won_new_business_amount,
            __FILE: app-sales/sales_leadership_overview.dashboard.lookml, __LINE_NUM: 409},
          {id: Mid-Market - 1 - opportunity.total_closed_won_new_business_amount,
            name: Mid-Market, axisId: Mid-Market - 1 - opportunity.total_closed_won_new_business_amount,
            __FILE: app-sales/sales_leadership_overview.dashboard.lookml, __LINE_NUM: 411},
          {id: Enterprise - 2 - opportunity.total_closed_won_new_business_amount,
            name: Enterprise, axisId: Enterprise - 2 - opportunity.total_closed_won_new_business_amount,
            __FILE: app-sales/sales_leadership_overview.dashboard.lookml, __LINE_NUM: 413}],
        showLabels: false, showValues: false, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear, __FILE: app-sales/sales_leadership_overview.dashboard.lookml,
        __LINE_NUM: 409}]
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
    y_axis_orientation: [left, right]
    ordering: none
    show_null_labels: false
    show_totals_labels: true
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    listen: {}
    row: 24
    col: 12
    width: 12
    height: 6
  - title: Quota Attainment
    name: Quota Attainment
    model: sales_analytics
    explore: opportunity
    type: looker_area
    fields: [opportunity.day_of_quarter, opportunity.total_closed_won_new_business_amount,
      opportunity.close_quarter, quota.quarterly_aggregate_quota_measure]
    pivots: [opportunity.close_quarter]
    filters:
      opportunity.close_quarter: this quarter, last quarter, 4 quarters ago for 1
        quarter
      opportunity_owner.manager: ''
      account.business_segment: ''
    sorts: [opportunity.close_quarter desc, opportunity.day_of_quarter]
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: running_total_of_amount, label: Running Total
          of Amount, expression: 'if(diff_days(trunc_days(now()),add_days(${opportunity.day_of_quarter}
          - 1,${opportunity.close_quarter})) > 0, null,running_total(${opportunity.total_closed_won_new_business_amount}))',
        value_format: !!null '', value_format_name: usd_0, _kind_hint: measure, _type_hint: number},
      {table_calculation: percent_of_quota, label: Percent of Quota, expression: "${running_total_of_amount}/${quota.quarterly_aggregate_quota_measure}",
        value_format: !!null '', value_format_name: percent_2, _kind_hint: measure,
        _type_hint: number}, {table_calculation: goal, label: Goal, expression: 'if(mod(row(),2)
          = 0,pivot_where(pivot_column() = 1, 1)*0 + 1,null)', value_format: !!null '',
        value_format_name: !!null '', _kind_hint: supermeasure, _type_hint: number}]
    trellis: ''
    stacking: ''
    color_application:
      collection_id: 5f313589-67ce-44ba-b084-ec5107a7bb7e
      palette_id: be92eae7-de25-46ae-8e4f-21cb0b69a1f3
      options:
        steps: 5
        __FILE: app-sales/sales_leadership_overview.dashboard.lookml
        __LINE_NUM: 472
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: false
    show_view_names: false
    point_style: none
    series_colors: {}
    series_labels:
      2019-01 - of_quota: This Quarter
      2018-10 - of_quota: Last Quarter
      2019-01 - percent_of_quota: This Quarter
      2018-10 - percent_of_quota: Last Quarter
      2018-01 - percent_of_quota: This Quarter - Last Year
    series_types:
      goal: scatter
    series_point_styles: {}
    limit_displayed_rows: false
    hidden_series: [2018-10 - calculation_5, 2018-07 - percent_of_quota, 2018-07 -
        calculation_5, 2018-04 - calculation_5, 2018-01 - calculation_5, 2018-04 -
        percent_of_quota]
    y_axes: [{label: '', orientation: left, series: [{id: 2019-01 - of_quota, name: This
              Quarter, axisId: of_quota, __FILE: app-sales/sales_leadership_overview.dashboard.lookml,
            __LINE_NUM: 494}, {id: 2018-10 - of_quota, name: Last Quarter, axisId: of_quota,
            __FILE: app-sales/sales_leadership_overview.dashboard.lookml, __LINE_NUM: 495},
          {id: 2018-07 - of_quota, name: 2018-Q3 - % of Quota, axisId: of_quota, __FILE: app-sales/sales_leadership_overview.dashboard.lookml,
            __LINE_NUM: 496}, {id: 2018-04 - of_quota, name: 2018-Q2 - % of Quota,
            axisId: of_quota, __FILE: app-sales/sales_leadership_overview.dashboard.lookml,
            __LINE_NUM: 497}, {id: 2018-01 - of_quota, name: 2018-Q1 - % of Quota,
            axisId: of_quota, __FILE: app-sales/sales_leadership_overview.dashboard.lookml,
            __LINE_NUM: 498}, {id: goal, name: Goal, axisId: goal, __FILE: app-sales/sales_leadership_overview.dashboard.lookml,
            __LINE_NUM: 499}], showLabels: true, showValues: true, maxValue: !!null '',
        minValue: !!null '', valueFormat: 0%, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear, __FILE: app-sales/sales_leadership_overview.dashboard.lookml,
        __LINE_NUM: 494}]
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
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    hidden_fields: [quota_quarter_goals.quota_sum, opportunity.total_closed_won_revenue,
      opportunity.total_closed_won_new_business_amount, running_total_of_amount, current_date,
      quota_numbers.quarterly_aggregate_quota_measure, quota.quarterly_aggregate_quota_measure]
    listen: {}
    row: 0
    col: 0
    width: 15
    height: 11
  - title: of Quota
    name: of Quota
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields: [opportunity.close_quarter, opportunity.total_closed_won_new_business_amount,
      quota.quarterly_aggregate_quota_measure]
    fill_fields: [opportunity.close_quarter]
    filters:
      opportunity.close_year: this quarter,next quarter
      opportunity_owner.manager: ''
      account.business_segment: ''
    sorts: [opportunity.close_quarter]
    limit: 1000
    column_limit: 50
    dynamic_fields: [{table_calculation: of_quota_hit, label: "% of Quota Hit", expression: "${opportunity.total_closed_won_new_business_amount}\
          \ / ${quota.quarterly_aggregate_quota_measure}", value_format: !!null '',
        value_format_name: percent_0, _kind_hint: measure, _type_hint: number}, {
        table_calculation: current_day_of_the_quarter, label: Current Day of the Quarter,
        expression: 'diff_days(${opportunity.close_quarter},trunc_days(now())) + 1',
        value_format: !!null '', value_format_name: !!null '', _kind_hint: dimension,
        _type_hint: number}, {table_calculation: number_of_days_in_the_quarter, label: Number
          of Days in the Quarter, expression: 'diff_days(${opportunity.close_quarter},offset(${opportunity.close_quarter},1))',
        value_format: !!null '', value_format_name: !!null '', _kind_hint: dimension,
        _type_hint: number}, {table_calculation: percent_of_the_way_through_the_quarter,
        label: Percent of the way through the quarter, expression: "${current_day_of_the_quarter}/${number_of_days_in_the_quarter}",
        value_format: !!null '', value_format_name: percent_0, _kind_hint: dimension,
        _type_hint: number}]
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
    hidden_fields: [opportunity.total_closed_won_revenue, opportunity.total_closed_won_new_business_amount,
      opportunity.close_quarter, current_day_of_the_quarter, number_of_days_in_the_quarter,
      quota_numbers.quarterly_aggregate_quota_measure, quota.quarterly_aggregate_quota_measure]
    listen: {}
    row: 2
    col: 21
    width: 3
    height: 4
  - title: Rep Performance Overview
    name: Rep Performance Overview
    model: sales_analytics
    explore: opportunity
    type: table
    fields: [opportunity_owner.name, opportunity_owner.tenure, opportunity_owner.title,
      account_owner.manager, quota.quarterly_quota, opportunity.total_new_closed_won_amount_qtd,
      opportunity.total_pipeline_amount]
    filters:
      opportunity_owner.is_sales_rep: 'Yes'
      opportunity_owner.manager: ''
      account.business_segment: ''
    sorts: [to_quota desc]
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: closed_won, label: Closed Won, expression: "${opportunity.total_new_closed_won_amount_qtd}",
        value_format: '[>=1000000]$0.0,,"M";[>=1000]$0,"K";$0.00', value_format_name: !!null '',
        _kind_hint: measure, _type_hint: number}, {table_calculation: to_quota, label: "%\
          \ to Quota", expression: 'if(${opportunity.total_new_closed_won_amount_qtd}/${quota.quarterly_quota}
          > 1, 1, ${opportunity.total_new_closed_won_amount_qtd}/${quota.quarterly_quota})',
        value_format: !!null '', value_format_name: percent_0, _kind_hint: measure,
        _type_hint: number}, {table_calculation: gap, label: Gap, expression: 'if((${quota.quarterly_quota}-${opportunity.total_new_closed_won_amount_qtd})>0,${quota.quarterly_quota}-${opportunity.total_new_closed_won_amount_qtd},0)',
        value_format: '[>=1000000]$0.0,,"M";[>=1000]$0,"K";$0.00', value_format_name: !!null '',
        _kind_hint: measure, _type_hint: number}, {table_calculation: pipeline_acv,
        label: Pipeline ACV, expression: "${opportunity.total_pipeline_amount}", value_format: '[>=1000000]$0.0,,"M";[>=1000]$0,"K";$0.00',
        value_format_name: !!null '', _kind_hint: measure, _type_hint: number}, {
        table_calculation: coverage, label: Coverage, expression: 'if(${gap}=0, null,
          ${opportunity.total_pipeline_amount}/${gap})', value_format: !!null '',
        value_format_name: percent_0, _kind_hint: measure, _type_hint: number}]
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
    series_labels:
      opportunity.total_new_closed_won_amount_qtd: Closed Won
      opportunity.total_pipeline_amount: Pipeline
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: true
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: !!null '',
        font_color: !!null '', color_application: {collection_id: legacy, palette_id: legacy_diverging1,
          options: {steps: 5, __FILE: app-sales/sales_leadership_overview.dashboard.lookml,
            __LINE_NUM: 620}, __FILE: app-sales/sales_leadership_overview.dashboard.lookml,
          __LINE_NUM: 619}, bold: false, italic: false, strikethrough: false, fields: [
          to_quota], __FILE: app-sales/sales_leadership_overview.dashboard.lookml,
        __LINE_NUM: 618}, {type: along a scale..., value: 1, background_color: !!null '',
        font_color: !!null '', color_application: {collection_id: legacy, palette_id: legacy_diverging1,
          options: {steps: 5, constraints: {max: {type: number, value: 0.1, __FILE: app-sales/sales_leadership_overview.dashboard.lookml,
                __LINE_NUM: 623}, min: {type: number, value: 0, __FILE: app-sales/sales_leadership_overview.dashboard.lookml,
                __LINE_NUM: 624}, mid: {type: number, value: 0.5, __FILE: app-sales/sales_leadership_overview.dashboard.lookml,
                __LINE_NUM: 624}, __FILE: app-sales/sales_leadership_overview.dashboard.lookml,
              __LINE_NUM: 623}, __FILE: app-sales/sales_leadership_overview.dashboard.lookml,
            __LINE_NUM: 623}, __FILE: app-sales/sales_leadership_overview.dashboard.lookml,
          __LINE_NUM: 622}, bold: false, italic: false, strikethrough: false, fields: [
          coverage], __FILE: app-sales/sales_leadership_overview.dashboard.lookml,
        __LINE_NUM: 621}]
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    hidden_fields: [opportunity.total_new_closed_won_amount_qtd, opportunity.total_pipeline_amount]
    listen: {}
    row: 46
    col: 0
    width: 24
    height: 10
  - title: Performance vs Quota (QTD)
    name: Performance vs Quota (QTD)
    model: sales_analytics
    explore: opportunity
    type: looker_line
    fields: [opportunity.close_date, opportunity.total_closed_won_new_business_amount,
      quota.quarterly_aggregate_quota_measure]
    fill_fields: [opportunity.close_date]
    filters:
      opportunity.close_year: this quarter
      opportunity_owner.manager: ''
      account.business_segment: ''
    sorts: [opportunity.close_date]
    limit: 1000
    column_limit: 50
    dynamic_fields: [{table_calculation: quota_per_day, label: Quota Per Day, expression: "${quota_as_table_calc}/count(row())",
        value_format: !!null '', value_format_name: usd_0, _kind_hint: dimension,
        _type_hint: number}, {table_calculation: grab_quota_value, label: Grab Quota
          Value, expression: "# Used to account for the fact that the measure might\
          \ be null for dates that are dimensino-filled in.\n# We take the max of\
          \ an offset list of our quuarterly agg quota measure column, so as long\
          \ as at least one row has a non-dimension filled close date, we can grab\
          \ the quota value\n\nif(row() = 1, max(offset_list(${quota.quarterly_aggregate_quota_measure},0,91)),null)",
        value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
        _type_hint: number}, {table_calculation: quota_as_table_calc, label: Quota
          as Table Calc, expression: 'offset(${grab_quota_value},-1*(row()-1))', value_format: !!null '',
        value_format_name: !!null '', _kind_hint: dimension, _type_hint: 'null'},
      {table_calculation: cumulative_quota, label: Cumulative Quota, expression: 'running_total(${quota_per_day})
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
        __FILE: app-sales/sales_leadership_overview.dashboard.lookml
        __LINE_NUM: 676
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
            name: Cumulative Quota, axisId: cumulative_quota, __FILE: app-sales/sales_leadership_overview.dashboard.lookml,
            __LINE_NUM: 691}, {id: cumulative_total_won, name: Cumulative Total Won,
            axisId: cumulative_total_won, __FILE: app-sales/sales_leadership_overview.dashboard.lookml,
            __LINE_NUM: 692}], showLabels: false, showValues: true, unpinAxis: false,
        tickDensity: default, type: linear, __FILE: app-sales/sales_leadership_overview.dashboard.lookml,
        __LINE_NUM: 691}]
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
      quota.quarterly_aggregate_quota_measure]
    hidden_points_if_no: [is_before_today]
    listen: {}
    row: 6
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
    sorts: [opportunity.total_closed_won_new_business_amount desc]
    limit: 500
    query_timezone: UTC
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
    listen: {}
    row: 11
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
      opportunity_stage_history.stage: "-NULL"
      opportunity.close_date: 0 quarters ago for 4 quarters
    sorts: [opportunity_stage_history.opps_in_each_stage desc]
    limit: 500
    query_timezone: America/Los_Angeles
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
        __FILE: app-sales/sales_leadership_overview.dashboard.lookml
        __LINE_NUM: 836
      options:
        steps: 5
        __FILE: app-sales/sales_leadership_overview.dashboard.lookml
        __LINE_NUM: 848
    smoothedBars: true
    orientation: automatic
    labelPosition: left
    percentType: total
    percentPosition: inline
    valuePosition: right
    labelColorEnabled: false
    labelColor: "#FFF"
    series_types: {}
    listen: {}
    row: 11
    col: 0
    width: 12
    height: 13
  - title: New Bookings
    name: New Bookings
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields: [opportunity.close_year, opportunity.total_closed_won_new_business_amount]
    pivots: [opportunity.close_year]
    fill_fields: [opportunity.close_year]
    filters:
      opportunity.close_date: 0 quarters ago for 1 quarter, 4 quarters ago for 1 quarter
      opportunity.type: "-Renewal"
    sorts: [opportunity.close_year desc]
    dynamic_fields: [{table_calculation: this_year, label: This Year, expression: 'pivot_index(${opportunity.total_closed_won_new_business_amount},
          1) - pivot_index(${opportunity.total_closed_won_new_business_amount}, 2)',
        value_format: '[>=1000000]$0.00,,"M";[>=1000]$0.00,"K";$0.00', value_format_name: !!null '',
        _kind_hint: supermeasure, _type_hint: number}, {table_calculation: change,
        label: Change, expression: "\n(pivot_index(${opportunity.total_closed_won_new_business_amount},\
          \ 1) - pivot_index(${opportunity.total_closed_won_new_business_amount},\
          \ 2))/pivot_index(${opportunity.total_closed_won_new_business_amount}, 2)",
        value_format: !!null '', value_format_name: percent_0, _kind_hint: supermeasure,
        _type_hint: number}]
    filter_expression: "((extract_years(now())=extract_years(${opportunity.close_year})\n\
      \   AND ${opportunity.close_year} <= now())\n\nOR \n\n(((extract_years(now())-1)=extract_years(${opportunity.close_year})\n\
      \  AND ${opportunity.close_year} <= add_years(-1,now()))\n\nAND\n\n(extract_months(${opportunity.close_date})\
      \ = extract_months(now())\nAND\nextract_days(${opportunity.close_date}) <= extract_days(now()))\n\
      \nOR\n\nextract_months(${opportunity.close_date}) < extract_months(now())))"
    color_application:
      collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7
      palette_id: fb7bb53e-b77b-4ab6-8274-9d420d3d73f3
    custom_color_enabled: true
    custom_color: ''
    show_single_value_title: true
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: false
    show_comparison_label: false
    font_size: medium
    text_color: black
    hidden_fields: [opportunity.total_closed_won_revenue, change]
    listen: {}
    row: 0
    col: 15
    width: 9
    height: 2
