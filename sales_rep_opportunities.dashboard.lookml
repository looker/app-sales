- dashboard: sales_rep_opportunities
  title: Sales Rep Opportunities
  extends: sales_analytics_base
  elements:
  - title: Total Pipeline Bookings by Close Date
    name: Total Pipeline Bookings by Close Date
    model: sales_analytics
    explore: opportunity
    type: looker_column
    fields: [opportunity.close_month, opportunity.custom_stage_name, opportunity.total_pipeline_new_business_amount]
    pivots: [opportunity.custom_stage_name]
    fill_fields: [opportunity.close_month]
    filters:
      opportunity.is_pipeline: 'Yes'
      opportunity.close_date: 0 months ago for 6 months
      quota.ae_segment: ''
      opportunity_owner.manager: ''
      account.business_segment: ''
    sorts: [opportunity.custom_stage_name, opportunity.close_month desc]
    limit: 500
    column_limit: 50
    trellis: ''
    stacking: normal
    color_application:
      collection_id: 5f313589-67ce-44ba-b084-ec5107a7bb7e
      palette_id: f582184b-9f56-4e5b-b1ab-e9777faa4df9
      options:
        steps: 5
        __FILE: app-sales/sales_rep_opportunities.dashboard.lookml
        __LINE_NUM: 28
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
            name: Develop, axisId: Develop - opportunity.count_new_business, __FILE: app-sales/sales_rep_opportunities.dashboard.lookml,
            __LINE_NUM: 41}, {id: Develop Positive - opportunity.count_new_business,
            name: Develop Positive, axisId: Develop Positive - opportunity.count_new_business,
            __FILE: app-sales/sales_rep_opportunities.dashboard.lookml, __LINE_NUM: 43},
          {id: Negotiate - opportunity.count_new_business, name: Negotiate, axisId: Negotiate
              - opportunity.count_new_business, __FILE: app-sales/sales_rep_opportunities.dashboard.lookml,
            __LINE_NUM: 46}, {id: Qualify - opportunity.count_new_business, name: Qualify,
            axisId: Qualify - opportunity.count_new_business, __FILE: app-sales/sales_rep_opportunities.dashboard.lookml,
            __LINE_NUM: 48}, {id: Qualify Renewal - opportunity.count_new_business,
            name: Qualify Renewal, axisId: Qualify Renewal - opportunity.count_new_business,
            __FILE: app-sales/sales_rep_opportunities.dashboard.lookml, __LINE_NUM: 50},
          {id: Validate - opportunity.count_new_business, name: Validate, axisId: Validate
              - opportunity.count_new_business, __FILE: app-sales/sales_rep_opportunities.dashboard.lookml,
            __LINE_NUM: 53}], showLabels: false, showValues: false, unpinAxis: false,
        tickDensity: default, tickDensityCustom: 5, type: linear, __FILE: app-sales/sales_rep_opportunities.dashboard.lookml,
        __LINE_NUM: 41}]
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
    hidden_series: []
    listen:
      Sales Rep: opportunity_owner.name
    row: 4
    col: 0
    width: 24
    height: 10
  - title: Revenue (QTD)
    name: Revenue (QTD)
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields: [opportunity.total_closed_won_new_business_amount, quota.quota_amount]
    filters:
      opportunity.close_date: this fiscal quarter
    sorts: [opportunity.total_closed_won_new_business_amount desc]
    limit: 500
    column_limit: 50
    custom_color_enabled: true
    custom_color: ''
    show_single_value_title: true
    show_comparison: true
    comparison_type: progress_percentage
    comparison_reverse_colors: false
    show_comparison_label: true
    comparison_label: Quota
    font_size: small
    series_types: {}
    hidden_fields: []
    listen:
      Sales Rep: opportunity_owner.name
    row: 0
    col: 0
    width: 6
    height: 4
  - title: Pipeline (QTD)
    name: Pipeline (QTD)
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields: [opportunity.total_pipeline_new_business_amount, opportunity.total_closed_won_new_business_amount,
      quota.quota_amount, opportunity_owner.name]
    filters:
      opportunity.close_date: this fiscal quarter
    sorts: [opportunity.total_pipeline_new_business_amount desc]
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: gap, label: Gap, expression: 'if((${quota.quota_amount}
          - ${opportunity.total_closed_won_new_business_amount}) < 0,"Quota Reached,
          No",to_string(${quota.quota_amount} - ${opportunity.total_closed_won_new_business_amount}))',
        value_format: '[>=1000000]$0.00,,"M";[>=1000]$0,"K";$0.00', value_format_name: !!null '',
        _kind_hint: measure, _type_hint: string}]
    custom_color_enabled: true
    custom_color: ''
    show_single_value_title: true
    show_comparison: true
    comparison_type: progress_percentage
    comparison_reverse_colors: false
    show_comparison_label: true
    comparison_label: Gap
    show_view_names: 'true'
    hidden_fields: [opportunity.total_closed_won_new_business_amount]
    listen:
      Sales Rep: opportunity_owner.name
    row: 0
    col: 6
    width: 6
    height: 4
  - title: Open Opps
    name: Open Opps
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields: [opportunity.count_open]
    limit: 500
    column_limit: 50
    custom_color_enabled: true
    custom_color: ''
    show_single_value_title: true
    show_comparison: false
    comparison_type: progress_percentage
    comparison_reverse_colors: false
    show_comparison_label: true
    comparison_label: Quota
    font_size: small
    series_types: {}
    hidden_fields: []
    listen:
      Sales Rep: opportunity_owner.name
    row: 0
    col: 12
    width: 6
    height: 4
  - title: Total Pipeline Bookings
    name: Total Pipeline Bookings
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields: [opportunity.total_pipeline_new_business_amount]
    limit: 500
    column_limit: 50
    custom_color_enabled: true
    custom_color: ''
    show_single_value_title: true
    show_comparison: false
    comparison_type: progress_percentage
    comparison_reverse_colors: false
    show_comparison_label: true
    comparison_label: Quota
    font_size: small
    series_types: {}
    hidden_fields: []
    listen:
      Sales Rep: opportunity_owner.name
    row: 0
    col: 18
    width: 6
    height: 4
  - title: List of All Opportunities
    name: List of All Opportunities
    model: sales_analytics
    explore: opportunity
    type: table
    fields: [opportunity.name, opportunity.type, opportunity.created_date, opportunity.close_date,
      opportunity.days_open, opportunity.custom_stage_name, opportunity.next_step,
      opportunity.amount, opportunity.first_meeting_date, opportunity_history_days_in_current_stage.most_recent_stage_change_date]
    filters:
      opportunity.is_closed: 'No'
      opportunity.is_included_in_quota: 'Yes'
      opportunity.custom_stage_name: "-Unknown"
    sorts: [opportunity.close_date]
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: days_since_1st_meeting, label: Days Since
          1st Meeting, expression: 'diff_days(${opportunity.first_meeting_date},now())',
        value_format: !!null '', value_format_name: !!null '', _kind_hint: dimension,
        _type_hint: number}, {table_calculation: days_in_current_stage, label: Days
          in Current Stage, expression: 'diff_days(${opportunity_history_days_in_current_stage.most_recent_stage_change_date},now())',
        value_format: !!null '', value_format_name: !!null '', _kind_hint: dimension,
        _type_hint: number}, {table_calculation: days_open, label: Days Open, expression: 'if(${opportunity.days_open}
          >= 0, to_string(${opportunity.days_open}), "Update Close Date")', value_format: !!null '',
        value_format_name: !!null '', _kind_hint: dimension, _type_hint: string}]
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
      opportunity_history_days_in_current_stage.most_recent_stage_change_date, opportunity.days_open]
    listen:
      Sales Rep: opportunity_owner.name
    row: 14
    col: 0
    width: 24
    height: 7
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
