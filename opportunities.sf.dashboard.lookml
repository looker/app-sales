- dashboard: opportunities
  title: Opportunities
  layout: newspaper
  elements:
  - title: Average Sales Cycle (Days)
    name: Average Sales Cycle (Days)
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields:
    - opportunity.average_days_to_closed_won
    limit: 500
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
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
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    listen:
      Opportunity Creation Date: opportunity.created_date
    row: 0
    col: 0
    width: 6
    height: 3
  - title: Opportunity Win Rate
    name: Opportunity Win Rate
    model: sales_analytics
    explore: lead
    type: single_value
    fields:
    - opportunity.win_percentage
    limit: 500
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
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
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    listen:
      Opportunity Creation Date: opportunity.created_date
    row: 0
    col: 18
    width: 6
    height: 3
  - title: Total Opportunities to Date
    name: Total Opportunities to Date
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields:
    - opportunity.count
    limit: 500
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
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
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    listen:
      Opportunity Creation Date: opportunity.created_date
    row: 0
    col: 12
    width: 6
    height: 3
  - title: Total Pipeline amount
    name: Total Pipeline amount
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields:
    - opportunity.total_pipeline_amount
    limit: 500
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
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
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    listen:
      Opportunity Creation Date: opportunity.created_date
    row: 0
    col: 6
    width: 6
    height: 3
  - title: Metrics by Stage Name
    name: Metrics by Stage Name
    model: sales_analytics
    explore: opportunity
    type: looker_bar
    fields:
    - opportunity.stage_name
    - opportunity.count
    - opportunity.average_days_open
    - opportunity.total_pipeline_amount
    sorts:
    - opportunity.stage_name
    limit: 500
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: right
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
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
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    y_axes:
    - label:
      maxValue:
      minValue:
      orientation: top
      showLabels: true
      showValues: true
      tickDensity: default
      tickDensityCustom: 5
      type: linear
      unpinAxis: false
      valueFormat: ''
      series:
      - id: opportunity.average_days_open
        name: Average Days Open
        axisId: opportunity.average_days_open
      - id: opportunity.count
        name: Number of Opportunities
        axisId: opportunity.count
    - label: ''
      maxValue:
      minValue:
      orientation: bottom
      showLabels: true
      showValues: true
      tickDensity: default
      tickDensityCustom: 5
      type: linear
      unpinAxis: false
      valueFormat: '[<0]-$0.0,,"M";[>0]$0.0,"K";$0'
      series:
      - id: opportunity.total_pipeline_amount
        name: Total Pipeline amount
        axisId: opportunity.total_pipeline_amount
    colors:
    - "#7285d8"
    - "#CADF79"
    - "#1FD110"
    - "#92818d"
    - "#c5c6a6"
    - "#82c2ca"
    - "#cee0a0"
    - "#928fb4"
    - "#9fc190"
    series_colors: {}
    label_value_format: ''
    hidden_series: []
    listen:
      Opportunity Creation Date: opportunity.created_date
    row: 3
    col: 0
    width: 24
    height: 9
  - title: Avg Conversion by Slowest 5 Industries
    name: Avg Conversion by Slowest 5 Industries
    model: sales_analytics
    explore: lead
    type: looker_bar
    fields:
    - lead.industry
    - lead.avg_convert_to_contact
    filters:
      lead.created_month: 12 months
    sorts:
    - lead.avg_convert_to_contact desc
    limit: 5
    column_limit: 50
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
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
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    colors:
    - "#EE7772"
    - "#EB9474"
    - "#E7AF75"
    - "#CADF79"
    - "#85D67C"
    - "#7FCDAE"
    series_colors: {}
    listen:
      Opportunity Creation Date: opportunity.created_date
    row: 12
    col: 8
    width: 8
    height: 8
  - title: Avg Conversion by Quickest 5 Industries
    name: Avg Conversion by Quickest 5 Industries
    model: sales_analytics
    explore: lead
    type: looker_bar
    fields:
    - lead.industry
    - lead.avg_convert_to_contact
    filters:
      lead.created_month: 12 months
    sorts:
    - lead.avg_convert_to_contact
    limit: 5
    column_limit: 50
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
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
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    colors:
    - "#7FCDAE"
    - "#85D67C"
    - "#CADF79"
    - "#E7AF75"
    - "#EB9474"
    - "#EE7772"
    series_colors: {}
    listen:
      Opportunity Creation Date: opportunity.created_date
    row: 12
    col: 0
    width: 8
    height: 8
  - title: Lead to Contact Conversion
    name: Lead to Contact Conversion
    model: sales_analytics
    explore: lead
    type: looker_timeline
    fields:
    - lead.name
    - lead.created_date
    - lead.converted_date
    filters:
      lead.converted_month: 12 months
    limit: 500
    query_timezone: America/Los_Angeles
    barColors:
    - red
    - blue
    groupBars: true
    labelSize: 10pt
    showLegend: true
    show_view_names: true
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    valueFormat: m/dd
    listen:
      Opportunity Creation Date: opportunity.created_date
    row: 12
    col: 16
    width: 8
    height: 8
  filters:
  - name: Opportunity Creation Date
    title: Opportunity Creation Date
    type: field_filter
    default_value: 12 months
    allow_multiple_values: true
    required: false
    model: sales_analytics
    explore: opportunity
    listens_to_filters: []
    field: account.created_date
