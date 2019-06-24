- dashboard: pipeline_management
  title: Pipeline Management
  extends: sales_analytics_base
  embed_style:
    background_color: "#ffffff"
    title_color: "#3a4245"
    tile_text_color: "#3a4245"
    text_tile_text_color: ''
  elements:
  - title: Pipeline Created QTD
    name: Pipeline Created QTD
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields: [opportunity.total_pipeline_new_business_amount, opportunity.total_closed_won_new_business_amount,
      aggregate_quota.quarterly_aggregate_quota_measure]
    filters:
      opportunity.created_fiscal_quarter: 1 fiscal quarters
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: gap, label: Gap, expression: 'if((${aggregate_quota.quarterly_aggregate_quota_measure}
          - ${opportunity.total_closed_won_new_business_amount}) < 0, "Quota Reached,
          No", to_string(floor(${aggregate_quota.quarterly_aggregate_quota_measure}
          - ${opportunity.total_closed_won_new_business_amount})))

          ', value_format: '[>=1000000]$0.00,,"M";[>=1000]$0.00,"K";$0.00', value_format_name: !!null '',
        _kind_hint: measure, _type_hint: string}]
    custom_color_enabled: true
    custom_color: ''
    show_single_value_title: true
    show_comparison: false
    comparison_type: progress_percentage
    comparison_reverse_colors: false
    show_comparison_label: true
    hidden_fields: [opportunity.total_closed_won_new_business_amount, quota_numbers.quarterly_aggregate_quota_measure,
      aggregate_quota.quarterly_aggregate_quota_measure, gap]
    y_axes: []
    listen:
      Sales Rep: opportunity_owner.name
      Manager: opportunity_owner.manager
      Region: opportunity_owner.ae_region
      Opportunity Type: opportunity.type
    row: 0
    col: 6
    width: 6
    height: 4
  - title: Pipeline Created MTD
    name: Pipeline Created MTD
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields: [opportunity.total_pipeline_new_business_amount, opportunity.total_closed_won_new_business_amount,
      aggregate_quota.monthly_aggregate_quota_measure]
    filters:
      opportunity.created_date: this month
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: gap, label: Gap, expression: 'if((${aggregate_quota.monthly_aggregate_quota_measure}
          - ${opportunity.total_closed_won_new_business_amount}) < 0, "Quota Reached,
          No", to_string(floor(${aggregate_quota.monthly_aggregate_quota_measure}
          - ${opportunity.total_closed_won_new_business_amount})))', value_format: '[>=1000000]$0.00,,"M";[>=1000]$0.00,"K";$0.00',
        value_format_name: !!null '', _kind_hint: measure, _type_hint: string}]
    custom_color_enabled: true
    custom_color: ''
    show_single_value_title: true
    show_comparison: false
    comparison_type: progress_percentage
    comparison_reverse_colors: false
    show_comparison_label: true
    hidden_fields: [opportunity.total_closed_won_new_business_amount, quota_numbers.quarterly_aggregate_quota_measure,
      aggregate_quota.monthly_aggregate_quota_measure, gap]
    y_axes: []
    listen:
      Sales Rep: opportunity_owner.name
      Manager: opportunity_owner.manager
      Region: opportunity_owner.ae_region
      Opportunity Type: opportunity.type
    row: 0
    col: 0
    width: 6
    height: 4
  - title: Avg Size of Deals in Pipeline
    name: Avg Size of Deals in Pipeline
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields: [opportunity.average_amount, opportunity.count_new_business_open]
    filters:
      opportunity.is_pipeline: 'Yes'
      opportunity.is_included_in_quota: 'Yes'
      opportunity.close_fiscal_quarter: this fiscal quarter
    limit: 500
    custom_color_enabled: true
    custom_color: ''
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    comparison_label: Open New-Business Opportunities
    note_state: collapsed
    note_display: hover
    note_text: This Quarter
    listen:
      Sales Rep: opportunity_owner.name
      Manager: opportunity_owner.manager
      Region: opportunity_owner.ae_region
      Opportunity Type: opportunity.type
    row: 0
    col: 12
    width: 6
    height: 4
  - title: Probable Bookings
    name: Probable Bookings
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields: [opportunity.total_pipeline_new_business_amount]
    filters:
      opportunity.is_probable_win: 'Yes'
      opportunity.close_fiscal_quarter: this fiscal quarter
    limit: 500
    series_types: {}
    listen:
      Sales Rep: opportunity_owner.name
      Manager: opportunity_owner.manager
      Region: opportunity_owner.ae_region
      Opportunity Type: opportunity.type
    row: 0
    col: 18
    width: 6
    height: 4
  - title: Opps Slated to Close
    name: Opps Slated to Close
    model: sales_analytics
    explore: opportunity
    type: looker_scatter
    fields: [opportunity.days_open, opportunity.close_date_custom, opportunity.amount,
      opportunity.name]
    filters:
      opportunity.is_pipeline: 'Yes'
      opportunity.days_open: "[0, 180]"
      opportunity.is_included_in_quota: 'Yes'
      opportunity.close_fiscal_quarter: this fiscal quarter, next fiscal quarter
    limit: 500
    column_limit: 50
    stacking: ''
    trellis: ''
    color_application:
      collection_id: 5f313589-67ce-44ba-b084-ec5107a7bb7e
      palette_id: be92eae7-de25-46ae-8e4f-21cb0b69a1f3
      options:
        steps: 5
        __FILE: app-sales/pipeline_management.dashboard.lookml
        __LINE_NUM: 148
    show_value_labels: false
    label_density: 25
    legend_position: center
    hide_legend: false
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    point_style: circle
    series_colors:
      opportunity.days_open: "#EE9093"
    series_types: {}
    limit_displayed_rows: false
    y_axes: [{label: '', orientation: left, series: [{id: opportunity.days_open, name: Opportunity
              Days Open, axisId: opportunity.days_open, __FILE: app-sales/pipeline_management.dashboard.lookml,
            __LINE_NUM: 161}], showLabels: true, showValues: true, unpinAxis: true,
        tickDensity: default, type: linear, __FILE: app-sales/pipeline_management.dashboard.lookml,
        __LINE_NUM: 161}]
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_datetime_label: ''
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    size_by_field: opportunity.amount
    plot_size_by_field: false
    show_null_points: false
    hidden_fields:
    listen:
      Sales Rep: opportunity_owner.name
      Manager: opportunity_owner.manager
      Region: opportunity_owner.ae_region
      Opportunity Type: opportunity.type
    row: 4
    col: 0
    width: 24
    height: 10
  - title: Opps by Stage & Rep
    name: Opps by Stage & Rep
    model: sales_analytics
    explore: opportunity
    type: looker_column
    fields: [opportunity.count_new_business, opportunity.custom_stage_name, opportunity.lead_source]
    pivots: [opportunity.custom_stage_name]
    filters:
      opportunity.is_pipeline: 'Yes'
      opportunity.is_included_in_quota: 'Yes'
      opportunity.close_fiscal_quarter: this fiscal quarter
    sorts: [opportunity.count_new_business desc 7, opportunity.custom_stage_name 0]
    limit: 5000
    column_limit: 10
    row_total: right
    stacking: normal
    trellis: ''
    color_application:
      collection_id: 5f313589-67ce-44ba-b084-ec5107a7bb7e
      palette_id: f582184b-9f56-4e5b-b1ab-e9777faa4df9
      options:
        steps: 5
        __FILE: app-sales/pipeline_management.dashboard.lookml
        __LINE_NUM: 278
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    point_style: none
    series_colors: {}
    series_types: {}
    limit_displayed_rows: true
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '10'
    y_axes: [{label: '', orientation: bottom, series: [{id: Develop - opportunity.count_new_business,
            name: Develop, axisId: Develop - opportunity.count_new_business, __FILE: app-sales/pipeline_management.dashboard.lookml,
            __LINE_NUM: 293}, {id: Develop Positive - opportunity.count_new_business,
            name: Develop Positive, axisId: Develop Positive - opportunity.count_new_business,
            __FILE: app-sales/pipeline_management.dashboard.lookml, __LINE_NUM: 294},
          {id: Negotiate - opportunity.count_new_business, name: Negotiate, axisId: Negotiate
              - opportunity.count_new_business, __FILE: app-sales/pipeline_management.dashboard.lookml,
            __LINE_NUM: 296}, {id: Qualify - opportunity.count_new_business, name: Qualify,
            axisId: Qualify - opportunity.count_new_business, __FILE: app-sales/pipeline_management.dashboard.lookml,
            __LINE_NUM: 298}, {id: Qualify Renewal - opportunity.count_new_business,
            name: Qualify Renewal, axisId: Qualify Renewal - opportunity.count_new_business,
            __FILE: app-sales/pipeline_management.dashboard.lookml, __LINE_NUM: 299},
          {id: Validate - opportunity.count_new_business, name: Validate, axisId: Validate
              - opportunity.count_new_business, __FILE: app-sales/pipeline_management.dashboard.lookml,
            __LINE_NUM: 301}], showLabels: false, showValues: false, unpinAxis: false,
        tickDensity: default, tickDensityCustom: 5, type: linear, __FILE: app-sales/pipeline_management.dashboard.lookml,
        __LINE_NUM: 293}]
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
    totals_color: "#808080"
    listen:
      Sales Rep: opportunity_owner.name
      Manager: opportunity_owner.manager
      Region: opportunity_owner.ae_region
      Opportunity Type: opportunity.type
    row: 14
    col: 18
    width: 6
    height: 6
  - title: Opps by Stage & Close Date
    name: Opps by Stage & Close Date
    model: sales_analytics
    explore: opportunity
    type: looker_column
    fields: [opportunity.count_new_business, opportunity.close_month, opportunity.custom_stage_name]
    pivots: [opportunity.custom_stage_name]
    fill_fields: [opportunity.close_month]
    filters:
      opportunity.is_pipeline: 'Yes'
      opportunity.close_date: 0 months ago for 6 months
      opportunity.is_included_in_quota: 'Yes'
    sorts: [opportunity.count_new_business desc 0, opportunity.custom_stage_name]
    limit: 500
    trellis: ''
    stacking: normal
    color_application:
      collection_id: 5f313589-67ce-44ba-b084-ec5107a7bb7e
      palette_id: f582184b-9f56-4e5b-b1ab-e9777faa4df9
      options:
        steps: 5
        __FILE: app-sales/pipeline_management.dashboard.lookml
        __LINE_NUM: 350
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    point_style: none
    series_colors: {}
    series_types: {}
    limit_displayed_rows: false
    y_axes: [{label: '', orientation: left, series: [{id: Develop - opportunity.count_new_business,
            name: Develop, axisId: Develop - opportunity.count_new_business, __FILE: app-sales/pipeline_management.dashboard.lookml,
            __LINE_NUM: 363}, {id: Develop Positive - opportunity.count_new_business,
            name: Develop Positive, axisId: Develop Positive - opportunity.count_new_business,
            __FILE: app-sales/pipeline_management.dashboard.lookml, __LINE_NUM: 365},
          {id: Negotiate - opportunity.count_new_business, name: Negotiate, axisId: Negotiate
              - opportunity.count_new_business, __FILE: app-sales/pipeline_management.dashboard.lookml,
            __LINE_NUM: 368}, {id: Qualify - opportunity.count_new_business, name: Qualify,
            axisId: Qualify - opportunity.count_new_business, __FILE: app-sales/pipeline_management.dashboard.lookml,
            __LINE_NUM: 370}, {id: Qualify Renewal - opportunity.count_new_business,
            name: Qualify Renewal, axisId: Qualify Renewal - opportunity.count_new_business,
            __FILE: app-sales/pipeline_management.dashboard.lookml, __LINE_NUM: 372},
          {id: Validate - opportunity.count_new_business, name: Validate, axisId: Validate
              - opportunity.count_new_business, __FILE: app-sales/pipeline_management.dashboard.lookml,
            __LINE_NUM: 375}], showLabels: false, showValues: false, unpinAxis: false,
        tickDensity: default, tickDensityCustom: 5, type: linear, __FILE: app-sales/pipeline_management.dashboard.lookml,
        __LINE_NUM: 363}]
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
    totals_color: "#808080"
    listen:
      Sales Rep: opportunity_owner.name
      Manager: opportunity_owner.manager
      Region: opportunity_owner.ae_region
      Opportunity Type: opportunity.type
    row: 14
    col: 0
    width: 12
    height: 6
  - title: List of Opportunities in Pipeline
    name: List of Opportunities in Pipeline
    model: sales_analytics
    explore: opportunity
    type: table
    fields: [opportunity.name, opportunity.type, opportunity.created_date, opportunity.close_date,
      opportunity.days_open, opportunity.custom_stage_name, opportunity.next_step,
      opportunity.amount, opportunity.first_meeting_date, opportunity_history_days_in_current_stage.most_recent_stage_change_date]
    filters:
      opportunity.is_included_in_quota: 'Yes'
      opportunity.is_pipeline: 'Yes'
    sorts: [opportunity.close_date]
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: days_since_1st_meeting, label: Days Since
          1st Meeting, expression: 'diff_days(${opportunity.first_meeting_date},now())',
        value_format: !!null '', value_format_name: !!null '', _kind_hint: dimension,
        _type_hint: number}, {table_calculation: days_in_current_stage, label: Days
          in Current Stage, expression: 'diff_days(${opportunity_history_days_in_current_stage.most_recent_stage_change_date},now())',
        value_format: !!null '', value_format_name: !!null '', _kind_hint: dimension,
        _type_hint: number}]
    show_view_names: 'true'
    show_row_numbers: true
    truncate_column_names: false
    subtotals_at_bottom: false
    hide_totals: false
    hide_row_totals: false
    table_theme: gray
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    hidden_fields: [opportunity.first_meeting_date, opportunity_history_days_in_current_stage.most_recent_stage_change_date_date,
      opportunity_history_days_in_current_stage.most_recent_stage_change_date]
    listen:
      Sales Rep: opportunity_owner.name
      Manager: opportunity_owner.manager
      Region: opportunity_owner.ae_region
      Opportunity Type: opportunity.type
    row: 20
    col: 0
    width: 24
    height: 9
  - title: Opps by Stage & Segment
    name: Opps by Stage & Segment
    model: sales_analytics
    explore: opportunity
    type: looker_column
    fields: [opportunity.count_new_business, account.business_segment, opportunity.custom_stage_name]
    pivots: [opportunity.custom_stage_name]
    filters:
      opportunity.is_pipeline: 'Yes'
      opportunity.is_included_in_quota: 'Yes'
      opportunity.close_fiscal_quarter: this quarter
    sorts: [opportunity.custom_stage_name 0, account.business_segment]
    limit: 500
    trellis: ''
    stacking: normal
    color_application:
      collection_id: 5f313589-67ce-44ba-b084-ec5107a7bb7e
      palette_id: f582184b-9f56-4e5b-b1ab-e9777faa4df9
      options:
        steps: 5
        __FILE: app-sales/pipeline_management.dashboard.lookml
        __LINE_NUM: 209
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    point_style: none
    series_colors: {}
    series_types: {}
    limit_displayed_rows: false
    y_axes: [{label: '', orientation: left, series: [{id: Develop - opportunity.count_new_business,
            name: Develop, axisId: Develop - opportunity.count_new_business, __FILE: app-sales/pipeline_management.dashboard.lookml,
            __LINE_NUM: 220}, {id: Develop Positive - opportunity.count_new_business,
            name: Develop Positive, axisId: Develop Positive - opportunity.count_new_business,
            __FILE: app-sales/pipeline_management.dashboard.lookml, __LINE_NUM: 221},
          {id: Negotiate - opportunity.count_new_business, name: Negotiate, axisId: Negotiate
              - opportunity.count_new_business, __FILE: app-sales/pipeline_management.dashboard.lookml,
            __LINE_NUM: 223}, {id: Qualify - opportunity.count_new_business, name: Qualify,
            axisId: Qualify - opportunity.count_new_business, __FILE: app-sales/pipeline_management.dashboard.lookml,
            __LINE_NUM: 225}, {id: Qualify Renewal - opportunity.count_new_business,
            name: Qualify Renewal, axisId: Qualify Renewal - opportunity.count_new_business,
            __FILE: app-sales/pipeline_management.dashboard.lookml, __LINE_NUM: 226},
          {id: Validate - opportunity.count_new_business, name: Validate, axisId: Validate
              - opportunity.count_new_business, __FILE: app-sales/pipeline_management.dashboard.lookml,
            __LINE_NUM: 228}], showLabels: false, showValues: false, unpinAxis: false,
        tickDensity: default, tickDensityCustom: 5, type: linear, __FILE: app-sales/pipeline_management.dashboard.lookml,
        __LINE_NUM: 220}]
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
    totals_color: "#808080"
    listen:
      Sales Rep: opportunity_owner.name
      Manager: opportunity_owner.manager
      Region: opportunity_owner.ae_region
      Opportunity Type: opportunity.type
    row: 14
    col: 12
    width: 6
    height: 6
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
  - name: Manager
    title: Manager
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: sales_analytics
    explore: opportunity
    listens_to_filters: []
    field: opportunity_owner.manager
  - name: Region
    title: Region
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: sales_analytics
    explore: opportunity
    listens_to_filters: []
    field: opportunity_owner.ae_region
  - name: Opportunity Type
    title: Opportunity Type
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: sales_analytics
    explore: opportunity
    listens_to_filters: []
    field: opportunity.type
