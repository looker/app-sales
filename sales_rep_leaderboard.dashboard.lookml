- dashboard: sales_rep_leaderboard
  title: Sales Rep Leaderboard
  extends: sales_analytics_base
  elements:
  - title: Revenue YTD
    name: Revenue YTD
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields: [opportunity_owner.name, opportunity.total_closed_won_new_business_amount,
      opportunity_owner.rep_highlight_acv]
    filters:
      opportunity_owner.name: "-NULL"
      opportunity.close_date: this year
      opportunity_owner.is_sales_rep: 'Yes'
    sorts: [opportunity.total_closed_won_new_business_amount desc]
    limit: 500
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
        __FILE: app-sales/sales_rep_performance.dashboard.lookml
        __LINE_NUM: 708
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
            name: 'Closed Won ACV ', axisId: opportunity.total_closed_won_new_business_amount,
            __FILE: app-sales/sales_rep_performance.dashboard.lookml, __LINE_NUM: 721}],
        showLabels: false, showValues: false, unpinAxis: false, tickDensity: default,
        type: linear, __FILE: app-sales/sales_rep_performance.dashboard.lookml, __LINE_NUM: 721}]
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
      Sales Rep: opportunity_owner.name_select
    row: 0
    col: 5
    width: 5
    height: 3
  - title: Revenue QTD
    name: Revenue QTD
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields: [opportunity_owner.name, opportunity.total_closed_won_new_business_amount,
      opportunity_owner.rep_highlight_acv]
    filters:
      opportunity_owner.name: "-NULL"
      opportunity.close_date: this quarter
      opportunity_owner.is_sales_rep: 'Yes'
    sorts: [opportunity.total_closed_won_new_business_amount desc]
    limit: 500
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
        __FILE: app-sales/sales_rep_performance.dashboard.lookml
        __LINE_NUM: 708
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
            name: 'Closed Won ACV ', axisId: opportunity.total_closed_won_new_business_amount,
            __FILE: app-sales/sales_rep_performance.dashboard.lookml, __LINE_NUM: 721}],
        showLabels: false, showValues: false, unpinAxis: false, tickDensity: default,
        type: linear, __FILE: app-sales/sales_rep_performance.dashboard.lookml, __LINE_NUM: 721}]
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
      Sales Rep: opportunity_owner.name_select
    row: 0
    col: 0
    width: 5
    height: 3
  - title: All Time Leaderboard
    name: All Time Leaderboard
    model: sales_analytics
    explore: opportunity
    type: looker_bar
    fields: [opportunity_owner.name, opportunity.total_closed_won_new_business_amount,
      opportunity_owner.rep_highlight_acv]
    filters:
      opportunity_owner.name: "-NULL"
      opportunity_owner.is_sales_rep: 'Yes'
    sorts: [opportunity.total_closed_won_new_business_amount desc]
    limit: 15
    column_limit: 50
    dynamic_fields: [{table_calculation: rep_highlight, label: Rep Highlight, expression: 'if(is_null(${opportunity_owner.rep_highlight_acv}),
          null,${opportunity.total_closed_won_new_business_amount})', value_format: '[>=1000000]$0.00,,"M";[>=1000]$0,"K";$0.00',
        value_format_name: !!null '', _kind_hint: measure, _type_hint: number}, {
        table_calculation: all_others, label: All Others, expression: 'if(is_null(${opportunity_owner.rep_highlight_acv}),${opportunity.total_closed_won_new_business_amount},null)',
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
        __FILE: app-sales/sales_rep_performance.dashboard.lookml
        __LINE_NUM: 634
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
            name: 'Closed Won ACV ', axisId: opportunity.total_closed_won_new_business_amount,
            __FILE: app-sales/sales_rep_performance.dashboard.lookml, __LINE_NUM: 648}],
        showLabels: false, showValues: false, unpinAxis: false, tickDensity: default,
        type: linear, __FILE: app-sales/sales_rep_performance.dashboard.lookml, __LINE_NUM: 648}]
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
    hidden_fields: [opportunity.total_closed_won_new_business_amount, opportunity_owner.rep_highlight_acv]
    listen:
      Sales Rep: opportunity_owner.name_select
    row: 3
    col: 0
    width: 24
    height: 11
  - title: Revenue All Time
    name: Revenue All Time
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields: [opportunity_owner.name, opportunity.total_closed_won_new_business_amount,
      opportunity_owner.rep_highlight_acv]
    filters:
      opportunity_owner.name: "-NULL"
      opportunity_owner.is_sales_rep: 'Yes'
    sorts: [opportunity.total_closed_won_new_business_amount desc]
    limit: 500
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
        __FILE: app-sales/sales_rep_performance.dashboard.lookml
        __LINE_NUM: 781
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
            name: 'Closed Won ACV ', axisId: opportunity.total_closed_won_new_business_amount,
            __FILE: app-sales/sales_rep_performance.dashboard.lookml, __LINE_NUM: 794}],
        showLabels: false, showValues: false, unpinAxis: false, tickDensity: default,
        type: linear, __FILE: app-sales/sales_rep_performance.dashboard.lookml, __LINE_NUM: 794}]
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
      Sales Rep: opportunity_owner.name_select
    row: 0
    col: 10
    width: 4
    height: 3
  - title: Avg Deal Size
    name: Avg Deal Size
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields: [opportunity_owner.name, opportunity_owner.rep_highlight_average_new_deal_size_won,
      opportunity.average_new_deal_size_won]
    filters:
      opportunity_owner.name: "-NULL"
      opportunity_owner.is_sales_rep: 'Yes'
    sorts: [opportunity_owner.rep_highlight_average_new_deal_size_won desc]
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: rank, label: Rank, expression: 'if(NOT is_null(${opportunity_owner.rep_highlight_average_new_deal_size_won}),row(),
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
        __FILE: app-sales/sales_rep_performance.dashboard.lookml
        __LINE_NUM: 781
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
            name: 'Closed Won ACV ', axisId: opportunity.total_closed_won_new_business_amount,
            __FILE: app-sales/sales_rep_performance.dashboard.lookml, __LINE_NUM: 794}],
        showLabels: false, showValues: false, unpinAxis: false, tickDensity: default,
        type: linear, __FILE: app-sales/sales_rep_performance.dashboard.lookml, __LINE_NUM: 794}]
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
    hidden_fields: [rank, opportunity_owner.rep_highlight_average_new_deal_size_won,
      opportunity.average_new_deal_size_won]
    listen:
      Sales Rep: opportunity_owner.name_select
    row: 0
    col: 14
    width: 5
    height: 3
  - title: Conversion Rate
    name: Conversion Rate
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields: [opportunity_owner.name, opportunity.win_percentage, opportunity_owner.rep_highlight_win_percentage]
    filters:
      opportunity_owner.name: "-NULL"
      opportunity_owner.is_sales_rep: 'Yes'
    sorts: [opportunity.win_percentage desc]
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: rank, label: Rank, expression: 'if(NOT is_null(${opportunity_owner.rep_highlight_win_percentage}),row(),
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
        __FILE: app-sales/sales_rep_performance.dashboard.lookml
        __LINE_NUM: 781
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
            name: 'Closed Won ACV ', axisId: opportunity.total_closed_won_new_business_amount,
            __FILE: app-sales/sales_rep_performance.dashboard.lookml, __LINE_NUM: 794}],
        showLabels: false, showValues: false, unpinAxis: false, tickDensity: default,
        type: linear, __FILE: app-sales/sales_rep_performance.dashboard.lookml, __LINE_NUM: 794}]
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
    hidden_fields: [rank, opportunity.win_percentage, opportunity_owner.rep_highlight_win_percentage]
    listen:
      Sales Rep: opportunity_owner.name_select
    row: 0
    col: 19
    width: 5
    height: 3
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
