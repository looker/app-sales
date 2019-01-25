- dashboard: historical_pipeline
  title: Historical Pipeline
  layout: newspaper
  elements:
  - title: Historical Pipeline Snapshot
    name: Historical Pipeline Snapshot
    model: salesforce_fivetran
    explore: historical_snapshot
    type: looker_area
    fields:
    - historical_snapshot.snapshot_date
    - historical_snapshot.stage_name_funnel
    - historical_snapshot.total_amount
    pivots:
    - historical_snapshot.stage_name_funnel
    filters:
      historical_snapshot.snapshot_date: 12 months
      historical_snapshot.stage_name_funnel: "-Closed Won,-Closed Lost,-Unknown"
    sorts:
    - historical_snapshot.snapshot_date desc
    - historical_snapshot.stage_name_funnel desc
    - historical_snapshot.stage_name_funnel__sort_
    limit: 500
    column_limit: 50
    query_timezone: America/Los_Angeles
    stacking: normal
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    colors:
    - "#7FCDAE"
    - "#85D67C"
    - "#CADF79"
    - "#E7AF75"
    - "#EB9474"
    - "#EE7772"
    show_null_points: true
    point_style: none
    interpolation: step
    row: 0
    col: 0
    width: 12
    height: 12
  - title: Quarterly Pipeline Development Report - Q4
    name: Quarterly Pipeline Development Report - Q4
    model: salesforce_fivetran
    explore: historical_snapshot
    type: looker_area
    fields:
    - historical_snapshot.snapshot_date
    - historical_snapshot.probability_tier
    - historical_snapshot.total_amount
    pivots:
    - historical_snapshot.probability_tier
    filters:
      historical_snapshot.close_date: after 2 quarters ago
      historical_snapshot.snapshot_date: before 0 minutes ago
      historical_snapshot.stage_name_funnel: Closed Won,Negotiation/Review,Perception
        Analysis,Proposal/Price Quote
    sorts:
    - historical_snapshot.snapshot_date
    - historical_snapshot.snapshot_month desc
    - historical_snapshot.close_month
    - historical_snapshot.stage_name_funnel__sort_
    - historical_snapshot.probability_tier
    - historical_snapshot.probability_tier__sort_
    limit: 500
    column_limit: 50
    query_timezone: America/Los_Angeles
    stacking: normal
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    point_style: none
    interpolation: linear
    ordering: none
    show_null_labels: false
    reference_lines:
    - reference_type: line
      range_start: max
      range_end: min
      margin_top: deviation
      margin_value: mean
      margin_bottom: deviation
      line_value: '7200000'
      label: Goal ($1.2M)
      color: purple
      __FILE: salesforce_block/historical_pipeline.sf.dashboard.lookml
      __LINE_NUM: 100
    colors:
    - black
    - "#1FD110"
    - "#95d925"
    - "#d0ca0e"
    - "#c77706"
    - "#bf2006"
    - lightgrey
    - black
    show_null_points: true
    hidden_series:
    - 20 - 39%
    - 1 - 19%
    row: 0
    col: 12
    width: 12
    height: 12
