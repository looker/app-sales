- dashboard: sales_rep_operations
  title: Sales Rep Operations
  layout: newspaper
  elements:
  - title: Sales Rep Name
    name: Sales Rep Name
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields:
    - opportunity_owner.name
    filters: {}
    sorts:
    - opportunity_owner.name
    limit: 1
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
    height: 2
  - title: New Tile
    name: New Tile
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields:
    - opportunity.count_of_opportunities_that_need_updated_closed_date
    limit: 500
    query_timezone: UTC
    custom_color_enabled: true
    custom_color: ''
    show_single_value_title: true
    single_value_title: Update Closed Date
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    listen:
      Sales Rep: opportunity_owner.name
    row: 2
    col: 10
    width: 4
    height: 4
  - title: Opportunities with next steps
    name: Opportunities with next steps
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields:
    - opportunity.count_of_opportunities_with_next_steps
    limit: 500
    column_limit: 50
    listen:
      Sales Rep: opportunity_owner.name
    row: 2
    col: 14
    width: 5
    height: 4
  - title: Opportunities with no next steps
    name: Opportunities with no next steps
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields:
    - opportunity.count_of_opportunities_with_no_next_steps
    limit: 500
    column_limit: 50
    listen:
      Sales Rep: opportunity_owner.name
    row: 2
    col: 19
    width: 5
    height: 4
  - title: Closed New Business This Year
    name: Closed New Business This Year
    model: sales_analytics
    explore: opportunity
    type: looker_bar
    fields:
    - opportunity.name
    - opportunity.total_closed_won_new_business_amount
    sorts:
    - opportunity.total_closed_won_new_business_amount desc
    limit: 30
    query_timezone: America/Los_Angeles
    trellis: ''
    stacking: ''
    color_application:
      collection_id: 5f313589-67ce-44ba-b084-ec5107a7bb7e
      palette_id: be92eae7-de25-46ae-8e4f-21cb0b69a1f3
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
      opportunity.total_closed_won_amount_ytd: "#C762AD"
      opportunity.total_closed_won_new_business_amount: "#8643B1"
    series_types: {}
    limit_displayed_rows: false
    y_axes:
    - label: ''
      orientation: left
      series:
      - id: opportunity.total_closed_won_new_business_amount
        name: 'Closed Won ACV '
        axisId: opportunity.total_closed_won_new_business_amount
      showLabels: false
      showValues: false
      unpinAxis: false
      tickDensity: default
      type: linear
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
    listen:
      Sales Rep: opportunity_owner.name
    row: 17
    col: 15
    width: 9
    height: 13
  - title: Close Rate
    name: Close Rate
    model: sales_analytics
    explore: opportunity
    type: looker_column
    fields:
    - opportunity.win_percentage
    - opportunity.close_month
    fill_fields:
    - opportunity.close_month
    filters:
      opportunity.close_date: 4 quarters
    limit: 50
    query_timezone: America/Los_Angeles
    trellis: ''
    stacking: ''
    color_application:
      collection_id: 5f313589-67ce-44ba-b084-ec5107a7bb7e
      palette_id: be92eae7-de25-46ae-8e4f-21cb0b69a1f3
      options:
        steps: 5
    show_value_labels: true
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    point_style: none
    series_colors: {}
    series_types: {}
    limit_displayed_rows: false
    y_axes:
    - label: ''
      orientation: left
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
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    listen:
      Sales Rep: opportunity_owner.name
    row: 11
    col: 0
    width: 10
    height: 6
  - title: Rep Avg Deal
    name: Rep Avg Deal
    model: sales_analytics
    explore: opportunity
    type: looker_column
    fields:
    - opportunity.average_amount_won
    - opportunity.close_month
    fill_fields:
    - opportunity.close_month
    filters:
      opportunity.close_date: 4 quarters
    sorts:
    - opportunity.close_month desc
    limit: 50
    query_timezone: America/Los_Angeles
    trellis: ''
    stacking: ''
    color_application:
      collection_id: 5f313589-67ce-44ba-b084-ec5107a7bb7e
      palette_id: be92eae7-de25-46ae-8e4f-21cb0b69a1f3
      options:
        steps: 5
    show_value_labels: true
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    point_style: none
    series_colors:
      opportunity.average_amount_won: "#EE9093"
    series_types: {}
    limit_displayed_rows: false
    y_axes:
    - label: ''
      orientation: left
      series:
      - id: opportunity.average_amount_won
        name: Average ACV  Won
        axisId: opportunity.average_amount_won
      showLabels: false
      showValues: false
      unpinAxis: false
      tickDensity: default
      type: linear
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
    listen:
      Sales Rep: opportunity_owner.name
    row: 11
    col: 10
    width: 7
    height: 6
  - title: Segment Avg Deal
    name: Segment Avg Deal
    model: sales_analytics
    explore: opportunity
    type: looker_column
    fields:
    - opportunity.average_amount_won
    - opportunity.close_month
    fill_fields:
    - opportunity.close_month
    filters:
      opportunity.close_date: 4 quarters
    sorts:
    - opportunity.close_month desc
    limit: 50
    query_timezone: America/Los_Angeles
    trellis: ''
    stacking: ''
    color_application:
      collection_id: 5f313589-67ce-44ba-b084-ec5107a7bb7e
      palette_id: be92eae7-de25-46ae-8e4f-21cb0b69a1f3
      options:
        steps: 5
    show_value_labels: true
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    point_style: none
    series_colors:
      opportunity.average_amount_won: "#EE9093"
    series_types: {}
    limit_displayed_rows: false
    y_axes:
    - label: ''
      orientation: left
      series:
      - id: opportunity.average_amount_won
        name: Average ACV  Won
        axisId: opportunity.average_amount_won
      showLabels: false
      showValues: false
      unpinAxis: false
      tickDensity: default
      type: linear
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
    row: 11
    col: 17
    width: 7
    height: 6
  - title: Opportunities By Stage
    name: Opportunities By Stage
    model: sales_analytics
    explore: opportunity
    type: looker_bar
    fields:
    - opportunity.custom_stage_name
    - opportunity.count_new_business
    pivots:
    - opportunity.custom_stage_name
    fill_fields:
    - opportunity.custom_stage_name
    filters:
      opportunity.is_pipeline: 'Yes'
    sorts:
    - opportunity.custom_stage_name
    limit: 50
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
    legend_position: center
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
      - id: opportunity.count
        name: Number of Opportunities
        axisId: opportunity.count
      showLabels: false
      showValues: false
      unpinAxis: false
      tickDensity: default
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
    show_silhouette: false
    totals_color: "#808080"
    show_null_points: true
    interpolation: linear
    listen:
      Sales Rep: opportunity_owner.name
    row: 6
    col: 0
    width: 24
    height: 5
  - title: Upcoming Opportunities
    name: Upcoming Opportunities
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields:
    - opportunity.count_new_business
    filters:
      opportunity.is_in_stage_1: 'Yes'
      opportunity.has_an_upcoming_first_meeting: 'Yes'
    limit: 500
    listen:
      Sales Rep: opportunity_owner.name
    row: 2
    col: 0
    width: 5
    height: 4
  - title: Take Action on these Opportunities
    name: Take Action on these Opportunities
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields:
    - opportunity.count_new_business
    filters:
      opportunity.is_in_stage_1: 'Yes'
      opportunity.requires_action: 'Yes'
    limit: 500
    listen:
      Sales Rep: opportunity_owner.name
    row: 2
    col: 5
    width: 5
    height: 4
  - title: Open Opportunities and Next Steps
    name: Open Opportunities and Next Steps
    model: sales_analytics
    explore: opportunity
    type: table
    fields:
    - opportunity.name
    - opportunity.id_url
    - opportunity.type
    - opportunity.days_open
    - opportunity.created_date
    - opportunity.stage_name
    - opportunity.next_step
    - opportunity.amount
    - opportunity.first_meeting_date
    - opportunity_history_days_in_current_stage.most_recent_stage_change_date
    filters:
      opportunity.is_new_business: 'Yes'
      opportunity.is_pipeline: 'Yes'
    sorts:
    - opportunity.created_date desc
    limit: 500
    dynamic_fields:
    - table_calculation: days_since_1st_meeting
      label: Days Since 1st Meeting
      expression: diff_days(${opportunity.first_meeting_date},now())
      value_format:
      value_format_name:
      _kind_hint: dimension
      _type_hint: number
    - table_calculation: days_in_current_stage
      label: Days in Current Stage
      expression: diff_days(${opportunity_history_days_in_current_stage.most_recent_stage_change_date},now())
      value_format:
      value_format_name:
      _kind_hint: dimension
      _type_hint: number
    show_view_names: 'true'
    show_row_numbers: true
    truncate_column_names: false
    subtotals_at_bottom: false
    hide_totals: false
    hide_row_totals: false
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    hidden_fields:
    - opportunity.first_meeting_date
    - opportunity_history_days_in_current_stage.most_recent_stage_change_date_date
    - opportunity_history_days_in_current_stage.most_recent_stage_change_date
    listen: {}
    row: 17
    col: 0
    width: 15
    height: 13
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