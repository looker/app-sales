- dashboard: sales_rep_ramping
  title: Sales Rep Ramping
  layout: newspaper
  elements:
  - title: Name
    name: Name
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields: [opportunity_owner.name]
    sorts: [opportunity_owner.name]
    limit: 500
    custom_color_enabled: true
    custom_color: ''
    show_single_value_title: false
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    series_types: {}
    listen:
      Sales Rep: opportunity_owner.name
    row: 0
    col: 0
    width: 24
    height: 3
  - title: Win % Rank (vs Segment)
    name: Win % Rank (vs Segment)
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
    row: 15
    col: 8
    width: 8
    height: 4
  - title: Average Days to Close (vs Segment)
    name: Average Days to Close (vs Segment)
    model: sales_analytics
    explore: opportunity
    type: looker_line
    fields: [user_age.age_at_close, sales_cycle_comparison.sales_cycle_cohort_comparitor,
      opportunity.average_days_to_closed_won]
    pivots: [sales_cycle_comparison.sales_cycle_cohort_comparitor]
    filters:
      user_age.age_at_close: "<18,NOT NULL"
      sales_cycle_comparison.sales_cycle_cohort_comparitor: "-NULL"
    sorts: [user_age.age_at_close, sales_cycle_comparison.sales_cycle_cohort_comparitor]
    limit: 500
    column_limit: 4
    dynamic_fields: [{table_calculation: sales_cycle, label: Sales Cycle, expression: 'if(pivot_column()=1,mean(offset_list(${opportunity.average_days_to_closed_won},-3,6)),mean(${opportunity.average_days_to_closed_won}))',
        value_format: !!null '', value_format_name: decimal_2, _kind_hint: measure,
        _type_hint: number}]
    query_timezone: America/Los_Angeles
    stacking: ''
    trellis: ''
    color_application:
      collection_id: legacy
      custom:
        id: 6aa3481a-122d-a4b7-feb8-930c20b38f98
        label: Custom
        type: continuous
        stops:
        - color: "#912fde"
          offset: 0
        - color: "#F36254"
          offset: 33.333333333333336
        - color: "#FCF758"
          offset: 66.66666666666667
        - color: "#4FBC89"
          offset: 100
      options:
        steps: 5
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    point_style: none
    series_colors:
      "   Top Third - sales_cycle": "#4fbc89"
      " Bottom Third - sales_cycle": "#f36254"
    series_types:
      " Akira Igarashi - sales_cycle": area
      " Akshay Padhye - sales_cycle": area
      " Alec Short - sales_cycle": area
      Bottom Third - sales_cycle: area
      Middle Third - sales_cycle: area
      Top Third - sales_cycle: area
      "   Top Third - sales_cycle": area
      "  Middle Third - sales_cycle": area
      " Bottom Third - sales_cycle": area
    limit_displayed_rows: false
    hidden_series: []
    y_axes: [{label: '', orientation: left, series: [{id: " Aditya Arya - sales_cycle",
            name: " Aditya Arya", axisId: sales_cycle}, {id: " Akira Igarashi - sales_cycle",
            name: " Akira Igarashi", axisId: sales_cycle}, {id: " Akshay Padhye -\
              \ sales_cycle", name: " Akshay Padhye", axisId: sales_cycle}, {id: " Alec\
              \ Short - sales_cycle", name: " Alec Short", axisId: sales_cycle}],
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
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    hidden_fields: [opportunity.average_days_to_closed_won]
    listen:
      Sales Rep: opportunity_owner.name_select
    row: 31
    col: 0
    width: 24
    height: 9
  - title: Sales Cycle Rank (vs Segment)
    name: Sales Cycle Rank (vs Segment)
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
    row: 27
    col: 8
    width: 8
    height: 4
  - title: Deal Size Rank (vs Segment)
    name: Deal Size Rank (vs Segment)
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
    row: 3
    col: 8
    width: 8
    height: 4
  - title: Win % Rank (vs Rest of Company)
    name: Win % Rank (vs Rest of Company)
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields: [win_percentage_comparison.win_percentage_rank, win_percentage_comparison.win_percentage_cohort]
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
    row: 15
    col: 16
    width: 8
    height: 4
  - title: Deal Size Rank (vs Rest of Company)
    name: Deal Size Rank (vs Rest of Company)
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields: [new_deal_size_comparison.deal_size_rank, new_deal_size_comparison.deal_size_cohort]
    filters: {}
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
      Sales Rep: opportunity_owner.name
    row: 3
    col: 16
    width: 8
    height: 4
  - title: New Deal Size (First 18 months vs Cohort)
    name: New Deal Size (First 18 months vs Cohort)
    model: sales_analytics
    explore: opportunity
    type: looker_line
    fields: [user_age.age_at_close, new_deal_size_comparison.deal_size_cohort_comparitor,
      opportunity.average_new_deal_size]
    pivots: [new_deal_size_comparison.deal_size_cohort_comparitor]
    filters:
      user_age.age_at_close: "<18,NOT NULL"
      new_deal_size_comparison.deal_size_cohort_comparitor: "-NULL"
    sorts: [user_age.age_at_close, new_deal_size_comparison.deal_size_cohort_comparitor]
    limit: 500
    column_limit: 4
    dynamic_fields: [{table_calculation: average_new_deal_size, label: Average New
          Deal Size, expression: 'if(pivot_column()=1,mean(offset_list(${opportunity.average_new_deal_size},-3,6)),mean(${opportunity.average_new_deal_size}))',
        value_format: '[>=1000000]$0.00,,"M";[>=1000]$0,"K";$0.00', value_format_name: !!null '',
        _kind_hint: measure, _type_hint: number}]
    query_timezone: America/Los_Angeles
    stacking: ''
    trellis: ''
    color_application:
      collection_id: legacy
      custom:
        id: b17df0dc-6939-d271-07cb-53bf1e8a84e0
        label: Custom
        type: continuous
        stops:
        - color: "#912fde"
          offset: 0
        - color: "#F36254"
          offset: 33.333333333333336
        - color: "#FCF758"
          offset: 66.66666666666667
        - color: "#4FBC89"
          offset: 100
      options:
        steps: 5
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    point_style: none
    series_colors: {}
    series_types:
      Bottom Third - average_new_deal_size: area
      Middle Third - average_new_deal_size: area
      Top Third - average_new_deal_size: area
    limit_displayed_rows: false
    hidden_series: []
    y_axes: [{label: '', orientation: left, series: [{id: " Aditya Arya - average_new_deal_size",
            name: " Aditya Arya", axisId: average_new_deal_size}, {id: " Akira Igarashi\
              \ - average_new_deal_size", name: " Akira Igarashi", axisId: average_new_deal_size},
          {id: " Akshay Padhye - average_new_deal_size", name: " Akshay Padhye", axisId: average_new_deal_size},
          {id: " Alec Short - average_new_deal_size", name: " Alec Short", axisId: average_new_deal_size}],
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
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    hidden_fields: [opportunity.average_new_deal_size]
    listen:
      Sales Rep: opportunity_owner.name_select
    row: 7
    col: 0
    width: 24
    height: 8
  - title: Win % (First 18 months vs Segment)
    name: Win % (First 18 months vs Segment)
    model: sales_analytics
    explore: opportunity
    type: looker_line
    fields: [user_age.age_at_close, win_percentage_comparison.win_percentage_cohort_comparitor,
      opportunity.win_percentage]
    pivots: [win_percentage_comparison.win_percentage_cohort_comparitor]
    filters:
      user_age.age_at_close: "<18,NOT NULL"
      win_percentage_comparison.win_percentage_cohort_comparitor: "-NULL"
    sorts: [user_age.age_at_close, win_percentage_comparison.win_percentage_cohort_comparitor]
    limit: 500
    column_limit: 4
    dynamic_fields: [{table_calculation: average_win, label: Average Win %, expression: 'if(pivot_column()=1,mean(offset_list(${opportunity.win_percentage},-3,6)),mean(${opportunity.win_percentage}))',
        value_format: !!null '', value_format_name: percent_1, _kind_hint: measure,
        _type_hint: number}]
    query_timezone: America/Los_Angeles
    stacking: ''
    trellis: ''
    color_application:
      collection_id: legacy
      custom:
        id: 579befe1-275d-e34d-bb24-2997f8b9bac9
        label: Custom
        type: continuous
        stops:
        - color: "#912fde"
          offset: 0
        - color: "#F36254"
          offset: 33.333333333333336
        - color: "#FCF758"
          offset: 66.66666666666667
        - color: "#4FBC89"
          offset: 100
      options:
        steps: 5
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    point_style: none
    series_colors: {}
    series_types:
      Bottom Third - average_win: area
      Middle Third - average_win: area
      Top Third - average_win: area
    limit_displayed_rows: false
    hidden_series: []
    y_axes: [{label: '', orientation: left, series: [{id: " Olivia Winter - average_win",
            name: " Olivia Winter", axisId: average_win}, {id: Bottom Third - average_win,
            name: Bottom Third, axisId: average_win}, {id: Middle Third - average_win,
            name: Middle Third, axisId: average_win}, {id: Top Third - average_win,
            name: Top Third, axisId: average_win}], showLabels: false, showValues: true,
        unpinAxis: false, tickDensity: default, type: linear}]
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
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    hidden_fields: [opportunity.win_percentage]
    listen:
      Sales Rep: opportunity_owner.name_select
    row: 19
    col: 0
    width: 24
    height: 8
  - title: Sales Cycle Rank (vs Rest of Company)
    name: Sales Cycle Rank (vs Rest of Company)
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields: [sales_cycle_comparison.cycle_rank, sales_cycle_comparison.cycle_cohort]
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
    row: 27
    col: 16
    width: 8
    height: 4
  - title: Win % (Past 18 months)
    name: Win % (Past 18 months)
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields: [win_percentage_comparison_current.win_percentage_cohort_current, win_percentage_comparison_current.win_percentage_rank_current]
    filters:
      opportunity.matches_name_select: 'Yes'
    sorts: [win_percentage_comparison_current.win_percentage_cohort_current]
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: rank, label: rank, expression: "${win_percentage_comparison_current.win_percentage_rank_current}",
        value_format: !!null '', value_format_name: !!null '', _kind_hint: dimension,
        _type_hint: number}, {table_calculation: calculation_3, label: Calculation
          3, expression: "concat(\n    to_string(${rank}), \n  \n\n  if(\n      mod(${rank},100)\
          \ > 10 AND mod(${rank},100) <= 20, \n          \"th\", \n          if(mod(${rank},10)\
          \ = 1, \"st\", if(mod(${rank},10) = 2, \n              \"nd\", \n      \
          \        if(mod(${rank},10) = 3, \"rd\", \"th\")\n              )\n    \
          \      )\n      )\n)", value_format: !!null '', value_format_name: !!null '',
        _kind_hint: dimension, _type_hint: string}, {table_calculation: calculation_2,
        label: Calculation 2, expression: "${win_percentage_comparison_current.win_percentage_cohort_current}",
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
    hidden_fields: [rank, win_percentage_comparison_current.win_percentage_cohort_current,
      win_percentage_comparison_current.win_percentage_rank_current]
    listen:
      Sales Rep: opportunity_owner.name_select
    row: 15
    col: 0
    width: 8
    height: 4
  - title: Deal Size Rank (Past 18 months)
    name: Deal Size Rank (Past 18 months)
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields: [new_deal_size_comparison_current.deal_size_rank_current, new_deal_size_comparison_current.deal_size_cohort_current]
    filters:
      opportunity_owner.name: ''
      opportunity.matches_name_select: 'Yes'
    sorts: [new_deal_size_comparison_current.deal_size_rank_current]
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: rank, label: rank, expression: "${new_deal_size_comparison_current.deal_size_rank_current}",
        value_format: !!null '', value_format_name: !!null '', _kind_hint: dimension,
        _type_hint: number}, {table_calculation: calculation_3, label: Calculation
          3, expression: "concat(\n    to_string(${rank}), \n  \n\n  if(\n      mod(${rank},100)\
          \ > 10 AND mod(${rank},100) <= 20, \n          \"th\", \n          if(mod(${rank},10)\
          \ = 1, \"st\", if(mod(${rank},10) = 2, \n              \"nd\", \n      \
          \        if(mod(${rank},10) = 3, \"rd\", \"th\")\n              )\n    \
          \      )\n      )\n)", value_format: !!null '', value_format_name: !!null '',
        _kind_hint: dimension, _type_hint: string}, {table_calculation: calculation_2,
        label: Calculation 2, expression: "${new_deal_size_comparison_current.deal_size_cohort_current}",
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
    hidden_fields: [rank, new_deal_size_comparison_current.deal_size_rank_current,
      new_deal_size_comparison_current.deal_size_cohort_current]
    listen:
      Sales Rep: opportunity_owner.name_select
    row: 3
    col: 0
    width: 8
    height: 4
  - title: Sales Cycle Rank (Past 18 Months)
    name: Sales Cycle Rank (Past 18 Months)
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields: [sales_cycle_comparison_current.cycle_cohort_current, sales_cycle_comparison_current.cycle_rank_current]
    filters:
      opportunity.matches_name_select: 'Yes'
    sorts: [sales_cycle_comparison_current.cycle_cohort_current]
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: rank, label: rank, expression: "${sales_cycle_comparison_current.cycle_rank_current}",
        value_format: !!null '', value_format_name: !!null '', _kind_hint: dimension,
        _type_hint: number}, {table_calculation: calculation_3, label: Calculation
          3, expression: "concat(\n    to_string(${rank}), \n  \n\n  if(\n      mod(${rank},100)\
          \ > 10 AND mod(${rank},100) <= 20, \n          \"th\", \n          if(mod(${rank},10)\
          \ = 1, \"st\", if(mod(${rank},10) = 2, \n              \"nd\", \n      \
          \        if(mod(${rank},10) = 3, \"rd\", \"th\")\n              )\n    \
          \      )\n      )\n)", value_format: !!null '', value_format_name: !!null '',
        _kind_hint: dimension, _type_hint: string}, {table_calculation: calculation_2,
        label: Calculation 2, expression: "${sales_cycle_comparison_current.cycle_cohort_current}",
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
    hidden_fields: [rank, sales_cycle_comparison_current.cycle_cohort_current, sales_cycle_comparison_current.cycle_rank_current]
    listen:
      Sales Rep: opportunity_owner.name_select
    row: 27
    col: 0
    width: 8
    height: 4
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
