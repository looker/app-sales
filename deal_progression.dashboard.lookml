- dashboard: deal_progression
  title: Deal Progression
  layout: newspaper
  elements:
  - title: Waterfall
    name: Waterfall
    model: sales_analytics
    explore: opportunity_history_waterfall
    type: waterfall_elliot_test
    fields:
    - opportunity_history_waterfall.starting_pipeline
    - opportunity_history_waterfall.new_opportunities
    - opportunity_history_waterfall.date_changed_in
    - opportunity_history_waterfall.date_changed_out
    - opportunity_history_waterfall.value_changed_increased
    - opportunity_history_waterfall.value_change_decreased
    - opportunity_history_waterfall.closed_lost
    - opportunity_history_waterfall.closed_won
    - opportunity_history_waterfall.end_pipeline
    filters:
      opportunity_history_waterfall.pipeline_dates: this quarter
    limit: 500
    series_types: {}
    listen: {}
    row: 4
    col: 0
    width: 24
    height: 8
  - title: Pulled In
    name: Pulled In
    model: sales_analytics
    explore: opportunity_history_waterfall
    type: single_value
    fields:
    - opportunity_history_waterfall.date_changed_in_count
    filters:
      opportunity_history_waterfall.pipeline_dates: this quarter
    limit: 500
    series_types: {}
    listen: {}
    row: 0
    col: 7
    width: 3
    height: 4
  - title: Pushed Out
    name: Pushed Out
    model: sales_analytics
    explore: opportunity_history_waterfall
    type: single_value
    fields:
    - opportunity_history_waterfall.count_date_changed_out
    filters:
      opportunity_history_waterfall.pipeline_dates: this quarter
    limit: 500
    series_types: {}
    listen: {}
    row: 0
    col: 10
    width: 3
    height: 4
  - title: New Deals
    name: New Deals
    model: sales_analytics
    explore: opportunity_history_waterfall
    type: single_value
    fields:
    - opportunity_history_waterfall.new_opp_count
    filters:
      opportunity_history_waterfall.pipeline_dates: this quarter
    limit: 500
    series_types: {}
    row: 0
    col: 4
    width: 3
    height: 4
  - title: Initial Opps
    name: Initial Opps
    model: sales_analytics
    explore: opportunity_history_waterfall
    type: single_value
    fields:
    - opportunity_history_waterfall.starting_pipeline_opp_count
    filters:
      opportunity_history_waterfall.pipeline_dates: this quarter
    limit: 500
    series_types: {}
    row: 0
    col: 0
    width: 4
    height: 4
  - title: Won
    name: Won
    model: sales_analytics
    explore: opportunity_history_waterfall
    type: single_value
    fields:
    - opportunity_history_waterfall.closed_won_count
    filters:
      opportunity_history_waterfall.pipeline_dates: this quarter
    limit: 500
    series_types: {}
    row: 0
    col: 16
    width: 4
    height: 4
  - title: Lost
    name: Lost
    model: sales_analytics
    explore: opportunity_history_waterfall
    type: single_value
    fields:
    - opportunity_history_waterfall.closed_lost_count
    filters:
      opportunity_history_waterfall.pipeline_dates: this quarter
    limit: 500
    series_types: {}
    row: 0
    col: 13
    width: 3
    height: 4
  - title: Remain Open
    name: Remain Open
    model: sales_analytics
    explore: opportunity_history_waterfall
    type: single_value
    fields:
    - opportunity_history_waterfall.end_opp_count
    filters:
      opportunity_history_waterfall.pipeline_dates: this quarter
    limit: 500
    series_types: {}
    row: 0
    col: 20
    width: 4
    height: 4
  - title: Opportunities By Rep
    name: Opportunities By Rep
    model: sales_analytics
    explore: opportunity_history_waterfall
    type: looker_column
    fields:
    - opportunity_owner.name
    - opportunity_history_waterfall.starting_pipeline_opp_count
    - opportunity_history_waterfall.new_opp_count
    - opportunity_history_waterfall.date_changed_in_count
    - opportunity_history_waterfall.date_changed_out_count
    - opportunity_history_waterfall.closed_won_count
    - opportunity_history_waterfall.closed_lost_count
    - opportunity_history_waterfall.end_opp_count
    filters:
      opportunity_history_waterfall.pipeline_dates: this quarter
    sorts:
    - opportunity_history_waterfall.starting_pipeline_opp_count desc
    limit: 10
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
    y_axis_gridlines: true
    show_view_names: false
    point_style: none
    series_colors: {}
    series_types: {}
    limit_displayed_rows: false
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
    listen: {}
    row: 12
    col: 0
    width: 12
    height: 9
  - title: Opportunities By Segment
    name: Opportunities By Segment
    model: sales_analytics
    explore: opportunity_history_waterfall
    type: looker_column
    fields:
    - opportunity_history_waterfall.starting_pipeline_opp_count
    - opportunity_history_waterfall.new_opp_count
    - opportunity_history_waterfall.date_changed_in_count
    - opportunity_history_waterfall.date_changed_out_count
    - opportunity_history_waterfall.closed_won_count
    - opportunity_history_waterfall.closed_lost_count
    - opportunity_history_waterfall.end_opp_count
    - account.business_segment
    fill_fields:
    - account.business_segment
    filters:
      opportunity_history_waterfall.pipeline_dates: this quarter
    sorts:
    - opportunity_history_waterfall.starting_pipeline_opp_count desc
    limit: 10
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
    y_axis_gridlines: true
    show_view_names: false
    point_style: none
    series_colors: {}
    series_types: {}
    limit_displayed_rows: false
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
    listen: {}
    row: 12
    col: 12
    width: 12
    height: 9
  - title: Opportunity Summary
    name: Opportunity Summary
    model: sales_analytics
    explore: opportunity
    type: table
    fields:
    - opportunity.name
    - opportunity.type
    - opportunity.stage_name
    - opportunity_owner.name
    - opportunity.total_amount
    filters:
      opportunity.last_modified_date: this quarter
    sorts:
    - opportunity.total_amount desc
    limit: 500
    query_timezone: America/Los_Angeles
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    subtotals_at_bottom: false
    hide_totals: false
    hide_row_totals: false
    series_labels:
      opportunity.name: Opportunity Name
      opportunity_owner.name: Opportunity Owner
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    listen: {}
    row: 21
    col: 0
    width: 24
    height: 7
