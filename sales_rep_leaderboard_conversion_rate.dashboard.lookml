- dashboard: sales_rep_leaderboard_conversion_rate
  title: Leaderboard - Conversion Rate
  extends: sales_analytics_base
  elements:
  - title: Conversion Rate (Last 18 months)
    name: Conversion Rate (Last 18 months)
    model: sales_analytics
    explore: opportunity
    type: looker_bar
    fields: [opportunity_owner.name, opportunity.win_percentage, opportunity_owner.rep_highlight_win_percentage]
    filters:
      opportunity_owner.name: "-NULL"
      opportunity_owner.is_sales_rep: 'Yes'
      opportunity.close_date: 18 months
    sorts: [opportunity.win_percentage desc]
    limit: 15
    column_limit: 50
    dynamic_fields: [{table_calculation: rep_highlight, label: Rep Highlight, expression: 'if(is_null(${opportunity_owner.rep_highlight_win_percentage}),
          null,${opportunity.win_percentage})', value_format: !!null '', value_format_name: percent_0,
        _kind_hint: measure, _type_hint: number}, {table_calculation: all_others,
        label: All Others, expression: 'if(is_null(${opportunity_owner.rep_highlight_win_percentage}),${opportunity.win_percentage},null)',
        value_format: !!null '', value_format_name: percent_0, _kind_hint: measure,
        _type_hint: number}]
    stacking: normal
    trellis: ''
    color_application:
      collection_id: 5f313589-67ce-44ba-b084-ec5107a7bb7e
      palette_id: be92eae7-de25-46ae-8e4f-21cb0b69a1f3
      options:
        steps: 5
        __FILE: app-sales/sales_rep_leaderboard_conversion_rate.dashboard.lookml
        __LINE_NUM: 30
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
            __FILE: app-sales/sales_rep_leaderboard_conversion_rate.dashboard.lookml,
            __LINE_NUM: 46}], showLabels: false, showValues: false, unpinAxis: false,
        tickDensity: default, type: linear, __FILE: app-sales/sales_rep_leaderboard_conversion_rate.dashboard.lookml,
        __LINE_NUM: 46}]
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
    hidden_fields: [opportunity.win_percentage, opportunity_owner.rep_highlight_win_percentage]
    listen:
      Sales Rep: opportunity_owner.name_select
    row: 3
    col: 0
    width: 24
    height: 11
  filters:
  - name: Sales Rep
    title: Sales Rep
    type: field_filter
    default_value:
    allow_multiple_values: true
    required: false
    model: sales_analytics
    explore: opportunity
    listens_to_filters: []
    field: opportunity_owner.name_select
