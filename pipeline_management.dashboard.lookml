- dashboard: pipeline_management
  title: Pipeline Management
  layout: newspaper
  elements:
  - title: Pipeline Changes Over Time (All-Time)
    name: Pipeline Changes Over Time (All-Time)
    model: sales_analytics
    explore: opportunity_history_waterfall
    type: waterfall
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
      opportunity_history_waterfall.pipeline_dates: last quarter
    limit: 500
    series_types: {}
    listen: {}
    row: 4
    col: 0
    width: 24
    height: 11
  - title: Customers in Pipeline
    name: Customers in Pipeline
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields:
    - opportunity.count_open
    limit: 500
    column_limit: 50
    listen: {}
    row: 0
    col: 0
    width: 6
    height: 4
  - title: Pipeline Revenue QTD
    name: Pipeline Revenue QTD
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields:
    - opportunity.total_pipeline_revenue
    filters:
      opportunity.close_date: this quarter
    limit: 500
    column_limit: 50
    dynamic_fields:
    - table_calculation: goal
      label: Goal
      expression: '125000000'
      value_format:
      value_format_name: usd_0
      _kind_hint: dimension
      _type_hint: number
    custom_color_enabled: true
    custom_color: ''
    show_single_value_title: true
    show_comparison: true
    comparison_type: progress_percentage
    comparison_reverse_colors: false
    show_comparison_label: true
    listen: {}
    row: 0
    col: 6
    width: 6
    height: 4
  - title: Pipeline Revenue This Month
    name: Pipeline Revenue This Month
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields:
    - opportunity.total_pipeline_revenue
    filters:
      opportunity.close_date: this month
    limit: 500
    column_limit: 50
    dynamic_fields:
    - table_calculation: goal
      label: Goal
      expression: 125000000/3
      value_format:
      value_format_name: usd_0
      _kind_hint: dimension
      _type_hint: number
    custom_color_enabled: true
    custom_color: ''
    show_single_value_title: true
    show_comparison: true
    comparison_type: progress_percentage
    comparison_reverse_colors: false
    show_comparison_label: true
    listen: {}
    row: 0
    col: 12
    width: 6
    height: 4
  - title: Rep Performance
    name: Rep Performance
    model: sales_analytics
    explore: opportunity
    type: table
    fields:
    - opportunity_owner.name
    - opportunity_owner.days_age
    - opportunity_owner.title
    - opportunity.total_closed_won_revenue_ytd
    - opportunity.total_pipeline_revenue_ytd
    - account_owner.manager
    filters:
      opportunity_owner.department: Sales
      opportunity_owner.title: Outside AE,AE,Inside AE,Account Executive,MM AE,Commercial
        AE
      opportunity.close_date: this year
    sorts:
    - opportunity.total_closed_won_revenue_ytd desc
    limit: 500
    dynamic_fields:
    - table_calculation: quota
      label: Quota
      expression: 'if(${opportunity_owner.title}="Outside AE",500000,if(${opportunity_owner.title}="Inside
        AE",200000,if(${opportunity_owner.title}="MM AE",250000,275000))) '
      value_format:
      value_format_name:
      _kind_hint: dimension
      _type_hint: number
    - table_calculation: ytd
      label: YTD %
      expression: "${opportunity.total_closed_won_revenue_ytd}/${quota}"
      value_format:
      value_format_name: percent_0
      _kind_hint: measure
      _type_hint: number
    - table_calculation: gap
      label: Gap
      expression: "${opportunity.total_closed_won_revenue_ytd}-${quota}"
      value_format:
      value_format_name: usd_0
      _kind_hint: measure
      _type_hint: number
    - table_calculation: gap_coverage
      label: Gap Coverage
      expression: "${opportunity.total_pipeline_revenue_ytd}/${gap}"
      value_format:
      value_format_name: percent_0
      _kind_hint: measure
      _type_hint: number
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
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: true
    conditional_formatting:
    - type: along a scale...
      value:
      background_color:
      font_color:
      color_application:
        collection_id: legacy
        palette_id: legacy_diverging1
      bold: false
      italic: false
      strikethrough: false
      fields:
      - ytd
    - type: along a scale...
      value:
      background_color:
      font_color:
      color_application:
        collection_id: legacy
        palette_id: legacy_diverging1
        options:
          steps: 5
          constraints:
            max:
              type: maximum
      bold: false
      italic: false
      strikethrough: false
      fields:
      - gap_coverage
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    listen: {}
    row: 15
    col: 0
    width: 24
    height: 10
  - title: Probable Revenue
    name: Probable Revenue
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields:
    - opportunity.total_pipeline_revenue
    filters:
      opportunity.is_probable_win: 'Yes'
    limit: 500
    series_types: {}
    listen: {}
    row: 0
    col: 18
    width: 6
    height: 4
  - title: Pipeline By State
    name: Pipeline By State
    model: sales_analytics
    explore: opportunity
    type: looker_map
    fields:
    - opportunity.total_pipeline_revenue
    - account.billing_state
    filters:
      opportunity.created_date: this quarter
      opportunity.total_pipeline_revenue: ">0"
      opportunity.stage_name: "-Closed Won"
      account.billing_location_bin_level: '7'
      account.billing_location: inside box from 66.51326044311188, -315.00000000000006
        to 0, 180
    sorts:
    - opportunity.total_pipeline_revenue desc
    limit: 5000
    column_limit: 50
    map_plot_mode: automagic_heatmap
    heatmap_gridlines: false
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: light
    map_position: custom
    map_latitude: 38.38580412735972
    map_longitude: -65.79368591308595
    map_zoom: 4
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: meters
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_view_names: true
    show_legend: true
    quantize_map_value_colors: false
    reverse_map_value_colors: true
    trellis: ''
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    point_style: circle
    series_types: {}
    limit_displayed_rows: false
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
    show_row_numbers: true
    truncate_column_names: false
    subtotals_at_bottom: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: true
    conditional_formatting:
    - type: along a scale...
      value:
      background_color:
      font_color:
      color_application:
        collection_id: legacy
        palette_id: legacy_diverging1
      bold: false
      italic: false
      strikethrough: false
      fields:
      - opportunity.total_pipeline_revenue
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    row: 33
    col: 10
    width: 14
    height: 10
  - title: Pipeline by Opportunity Age
    name: Pipeline by Opportunity Age
    model: sales_analytics
    explore: opportunity
    type: table
    fields:
    - opportunity.total_pipeline_revenue
    - account.business_segment
    - opportunity.days_as_opportunity_tier
    pivots:
    - account.business_segment
    filters:
      opportunity.created_date: this quarter
      opportunity.total_pipeline_revenue: ">0"
      opportunity.stage_name: "-Closed Won"
    sorts:
    - account.business_segment 0
    - opportunity.days_as_opportunity_tier
    limit: 500
    column_limit: 50
    show_view_names: true
    show_row_numbers: true
    truncate_column_names: false
    subtotals_at_bottom: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: true
    conditional_formatting:
    - type: along a scale...
      value:
      background_color:
      font_color:
      color_application:
        collection_id: legacy
        palette_id: legacy_diverging1
      bold: false
      italic: false
      strikethrough: false
      fields:
      - opportunity.total_pipeline_revenue
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    listen: {}
    row: 33
    col: 0
    width: 10
    height: 10
  - title: Monthly Pipeline Report
    name: Monthly Pipeline Report
    model: sales_analytics
    explore: opportunity_history_by_day
    type: looker_area
    fields:
    - opportunity_history_by_day.total_amount_open_opportunities
    - opportunity_history_by_day.probability_tier
    - calendar.generated_month
    pivots:
    - opportunity_history_by_day.probability_tier
    fill_fields:
    - opportunity_history_by_day.probability_tier
    - calendar.generated_month
    filters:
      opportunity_history_by_day.opportunity_id: "-0064400000jdE6NAAU"
      calendar.generated_month: 6 months
    sorts:
    - opportunity_history_by_day.probability_tier
    - calendar.generated_month desc
    limit: 500
    query_timezone: UTC
    trellis: ''
    stacking: normal
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    point_style: none
    series_types: {}
    limit_displayed_rows: false
    hidden_series:
    - Lost - 6 - opportunity_history_by_day.total_amount_open_opportunities
    - 1 - 19% - 5 - opportunity_history_by_day.total_amount_open_opportunities
    - Won - 0 - opportunity_history_by_day.total_amount_open_opportunities
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
    row: 25
    col: 0
    width: 24
    height: 8
