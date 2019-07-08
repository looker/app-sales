- dashboard: leaderboard__bookings_all_time
  title: Leaderboard - Bookings All Time
  extends: sales_analytics_base
  embed_style:
    background_color: "#ffffff"
    title_color: "#3a4245"
    tile_text_color: "#3a4245"
    text_tile_text_color: ''
  elements:
  - title: Bookings All Time
    name: Bookings All Time
    model: sales_analytics
    explore: opportunity
    type: looker_bar
    fields: [opportunity_owner.name, opportunity.total_closed_won_new_business_amount,
      opportunity.total_closed_won_new_business_amount_leaderboard, opportunity.rep_highlight_acv]
    filters:
      opportunity_owner.name: "-NULL"
      opportunity_owner.is_sales_rep: 'Yes'
    sorts: [opportunity.total_closed_won_new_business_amount desc]
    limit: 15
    column_limit: 50
    color_application:
      collection_id: 5f313589-67ce-44ba-b084-ec5107a7bb7e
      palette_id: be92eae7-de25-46ae-8e4f-21cb0b69a1f3
      options:
        steps: 5
        __FILE: app-sales/sales_rep_leaderboard_bookings.dashboard.lookml
        __LINE_NUM: 30
    x_axis_gridlines: false
    y_axis_gridlines: false
    show_view_names: false
    y_axes: [{label: '', orientation: left, series: [{id: opportunity.total_closed_won_new_business_amount,
            name: 'Closed Won ACV ', axisId: opportunity.total_closed_won_new_business_amount,
            __FILE: app-sales/sales_rep_leaderboard_bookings.dashboard.lookml, __LINE_NUM: 46}],
        showLabels: false, showValues: false, unpinAxis: false, tickDensity: default,
        type: linear, __FILE: app-sales/sales_rep_leaderboard_bookings.dashboard.lookml,
        __LINE_NUM: 46}]
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
    hide_legend: true
    legend_position: center
    series_types: {}
    point_style: none
    series_colors:
      opportunity.average_amount_won: "#EE9093"
      all_others: "#ede8ff"
      opportunity.rep_highlight_acv: "#462C9D"
      opportunity.total_closed_won_new_business_amount_leaderboard: "#ede8ff"
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
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
      Segment: opportunity_owner.ae_segment
    row: 3
    col: 0
    width: 24
    height: 11
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
  - name: Segment
    title: Segment
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: sales_analytics
    explore: opportunity
    listens_to_filters: []
    field: opportunity_owner.ae_segment
