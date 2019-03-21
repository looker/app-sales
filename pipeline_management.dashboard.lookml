- dashboard: pipeline_management
  title: Pipeline Management
  extends: sales_analytics_base
  elements:
  - title: Probable Revenue
    name: Probable Revenue
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields: [opportunity.total_pipeline_new_business_amount]
    filters:
      opportunity.close_date: this quarter
      opportunity.is_probable_win: 'Yes'
    limit: 500
    series_types: {}
    listen:
      Rep Segment: quota.ae_segment
      Sales Manager: opportunity_owner.manager
      Business Segment: account.business_segment
    row: 0
    col: 18
    width: 6
    height: 4
  - title: Avg Deal Size
    name: Avg Deal Size
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields: [opportunity.average_amount, opportunity.count_new_business_open]
    filters:
      opportunity.is_pipeline: 'Yes'
      opportunity.close_date: this quarter
    limit: 500
    custom_color_enabled: true
    custom_color: ''
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    comparison_label: Open New-Business Opportunities
    listen:
      Rep Segment: quota.ae_segment
      Sales Manager: opportunity_owner.manager
      Business Segment: account.business_segment
    row: 0
    col: 12
    width: 6
    height: 4
  - title: Opps by Stage & Rep
    name: Opps by Stage & Rep
    model: sales_analytics
    explore: opportunity
    type: looker_bar
    fields: [opportunity.count_new_business, opportunity_owner.name, opportunity.custom_stage_name]
    pivots: [opportunity.custom_stage_name]
    fill_fields: [opportunity.custom_stage_name]
    filters:
      opportunity.is_pipeline: 'Yes'
      opportunity.close_date: this quarter
    sorts: [opportunity.count_new_business desc 7, opportunity.custom_stage_name 0]
    limit: 5000
    row_total: right
    stacking: normal
    trellis: ''
    color_application:
      collection_id: 5f313589-67ce-44ba-b084-ec5107a7bb7e
      palette_id: f582184b-9f56-4e5b-b1ab-e9777faa4df9
      options:
        steps: 5
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
            name: Develop, axisId: Develop - opportunity.count_new_business}, {id: Develop
              Positive - opportunity.count_new_business, name: Develop Positive, axisId: Develop
              Positive - opportunity.count_new_business}, {id: Negotiate - opportunity.count_new_business,
            name: Negotiate, axisId: Negotiate - opportunity.count_new_business},
          {id: Qualify - opportunity.count_new_business, name: Qualify, axisId: Qualify
              - opportunity.count_new_business}, {id: Qualify Renewal - opportunity.count_new_business,
            name: Qualify Renewal, axisId: Qualify Renewal - opportunity.count_new_business},
          {id: Validate - opportunity.count_new_business, name: Validate, axisId: Validate
              - opportunity.count_new_business}], showLabels: false, showValues: false,
        unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear}]
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
      Rep Segment: quota.ae_segment
      Sales Manager: opportunity_owner.manager
      Business Segment: account.business_segment
    row: 20
    col: 0
    width: 12
    height: 6
  - title: Opps by Stage & Segment
    name: Opps by Stage & Segment
    model: sales_analytics
    explore: opportunity
    type: looker_bar
    fields: [opportunity.count_new_business, account.business_segment, opportunity.custom_stage_name]
    pivots: [opportunity.custom_stage_name]
    fill_fields: [account.business_segment, opportunity.custom_stage_name]
    filters:
      opportunity.is_pipeline: 'Yes'
      opportunity.close_date: this quarter
    sorts: [opportunity.custom_stage_name 0, account.business_segment]
    limit: 500
    trellis: ''
    stacking: normal
    color_application:
      collection_id: 5f313589-67ce-44ba-b084-ec5107a7bb7e
      palette_id: f582184b-9f56-4e5b-b1ab-e9777faa4df9
      options:
        steps: 5
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
            name: Develop, axisId: Develop - opportunity.count_new_business}, {id: Develop
              Positive - opportunity.count_new_business, name: Develop Positive, axisId: Develop
              Positive - opportunity.count_new_business}, {id: Negotiate - opportunity.count_new_business,
            name: Negotiate, axisId: Negotiate - opportunity.count_new_business},
          {id: Qualify - opportunity.count_new_business, name: Qualify, axisId: Qualify
              - opportunity.count_new_business}, {id: Qualify Renewal - opportunity.count_new_business,
            name: Qualify Renewal, axisId: Qualify Renewal - opportunity.count_new_business},
          {id: Validate - opportunity.count_new_business, name: Validate, axisId: Validate
              - opportunity.count_new_business}], showLabels: false, showValues: false,
        unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear}]
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
      Rep Segment: quota.ae_segment
      Sales Manager: opportunity_owner.manager
      Business Segment: account.business_segment
    row: 20
    col: 12
    width: 12
    height: 6
  - title: Opps Slated to Close
    name: Opps Slated to Close
    model: sales_analytics
    explore: opportunity
    type: looker_scatter
    fields: [opportunity.days_open, opportunity.close_date_custom, opportunity.amount,
      opportunity.name]
    filters:
      opportunity.close_date: this quarter, next quarter
      opportunity.is_pipeline: 'Yes'
      opportunity.days_open: "[0, 180]"
    limit: 500
    column_limit: 50
    stacking: ''
    trellis: ''
    color_application:
      collection_id: 5f313589-67ce-44ba-b084-ec5107a7bb7e
      palette_id: be92eae7-de25-46ae-8e4f-21cb0b69a1f3
      options:
        steps: 5
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
              Days Open, axisId: opportunity.days_open}], showLabels: true, showValues: true,
        unpinAxis: true, tickDensity: default, type: linear}]
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
      Rep Segment: quota.ae_segment
      Sales Manager: opportunity_owner.manager
      Business Segment: account.business_segment
    row: 4
    col: 0
    width: 24
    height: 10
  - title: Opps by Stage & Deal Size Tier
    name: Opps by Stage & Deal Size Tier
    model: sales_analytics
    explore: opportunity
    type: looker_bar
    fields: [opportunity.count_new_business, opportunity.deal_size_tier, opportunity.probability_group]
    pivots: [opportunity.probability_group]
    filters:
      opportunity.is_pipeline: 'Yes'
      opportunity.close_date: this quarter
      opportunity.count_new_business: NOT NULL
    sorts: [opportunity.deal_size_tier, opportunity.probability_group desc]
    limit: 20
    trellis: ''
    stacking: normal
    color_application:
      collection_id: 5f313589-67ce-44ba-b084-ec5107a7bb7e
      palette_id: f582184b-9f56-4e5b-b1ab-e9777faa4df9
      options:
        steps: 5
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
    y_axes: [{label: '', orientation: bottom, series: [{id: Develop - opportunity.count_new_business,
            name: Develop, axisId: Develop - opportunity.count_new_business}, {id: Develop
              Positive - opportunity.count_new_business, name: Develop Positive, axisId: Develop
              Positive - opportunity.count_new_business}, {id: Negotiate - opportunity.count_new_business,
            name: Negotiate, axisId: Negotiate - opportunity.count_new_business},
          {id: Qualify - opportunity.count_new_business, name: Qualify, axisId: Qualify
              - opportunity.count_new_business}, {id: Qualify Renewal - opportunity.count_new_business,
            name: Qualify Renewal, axisId: Qualify Renewal - opportunity.count_new_business},
          {id: Validate - opportunity.count_new_business, name: Validate, axisId: Validate
              - opportunity.count_new_business}], showLabels: false, showValues: false,
        unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear}]
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
      Rep Segment: quota.ae_segment
      Sales Manager: opportunity_owner.manager
      Business Segment: account.business_segment
    row: 14
    col: 12
    width: 12
    height: 6
  - title: Opps by Stage & Close Date
    name: Opps by Stage & Close Date
    model: sales_analytics
    explore: opportunity
    type: looker_column
    fields: [opportunity.count_new_business, opportunity.close_month, opportunity.custom_stage_name]
    pivots: [opportunity.custom_stage_name]
    fill_fields: [opportunity.close_month, opportunity.custom_stage_name]
    filters:
      opportunity.is_pipeline: 'Yes'
      opportunity.close_date: 0 months ago for 6 months
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
        __LINE_NUM: 208
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
            __LINE_NUM: 223}, {id: Develop Positive - opportunity.count_new_business,
            name: Develop Positive, axisId: Develop Positive - opportunity.count_new_business,
            __FILE: app-sales/pipeline_management.dashboard.lookml, __LINE_NUM: 226},
          {id: Negotiate - opportunity.count_new_business, name: Negotiate, axisId: Negotiate
              - opportunity.count_new_business, __FILE: app-sales/pipeline_management.dashboard.lookml,
            __LINE_NUM: 229}, {id: Qualify - opportunity.count_new_business, name: Qualify,
            axisId: Qualify - opportunity.count_new_business, __FILE: app-sales/pipeline_management.dashboard.lookml,
            __LINE_NUM: 232}, {id: Qualify Renewal - opportunity.count_new_business,
            name: Qualify Renewal, axisId: Qualify Renewal - opportunity.count_new_business,
            __FILE: app-sales/pipeline_management.dashboard.lookml, __LINE_NUM: 235},
          {id: Validate - opportunity.count_new_business, name: Validate, axisId: Validate
              - opportunity.count_new_business, __FILE: app-sales/pipeline_management.dashboard.lookml,
            __LINE_NUM: 238}], showLabels: false, showValues: false, unpinAxis: false,
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
      Rep Segment: quota.ae_segment
      Sales Manager: opportunity_owner.manager
      Business Segment: account.business_segment
    row: 14
    col: 0
    width: 12
    height: 6
  - title: Pipeline ACV MTD
    name: Pipeline ACV MTD
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields: [opportunity.total_pipeline_new_business_amount, opportunity.total_closed_won_new_business_amount,
      quota.monthly_aggregate_quota_measure]
    filters:
      opportunity.close_date: this month
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: gap, label: Gap, expression: "${quota.monthly_aggregate_quota_measure}\
          \ - ${opportunity.total_closed_won_new_business_amount}", value_format: '[>=1000000]$0.00,,"M";[>=1000]$0.00,"K";$0.00',
        value_format_name: !!null '', _kind_hint: measure, _type_hint: number}]
    custom_color_enabled: true
    custom_color: ''
    show_single_value_title: true
    show_comparison: true
    comparison_type: progress_percentage
    comparison_reverse_colors: false
    show_comparison_label: true
    hidden_fields: [opportunity.total_closed_won_new_business_amount, quota_numbers.quarterly_aggregate_quota_measure,
      quota.monthly_aggregate_quota_measure]
    listen:
      Rep Segment: quota.ae_segment
      Sales Manager: opportunity_owner.manager
      Business Segment: account.business_segment
    row: 0
    col: 0
    width: 6
    height: 4
  - title: Rep Performance
    name: Rep Performance
    model: sales_analytics
    explore: opportunity
    type: table
    fields: [opportunity_owner.name, opportunity_owner.tenure, opportunity_owner.title,
      account_owner.manager, quota.quarterly_quota, opportunity.total_new_closed_won_amount_qtd,
      opportunity.total_pipeline_amount]
    filters:
      opportunity_owner.is_sales_rep: 'Yes'
      opportunity.close_date: this quarter
    sorts: [to_quota desc]
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: closed_won, label: Closed Won, expression: "${opportunity.total_new_closed_won_amount_qtd}",
        value_format: '[>=1000000]$0.00,,"M";[>=1000]$0,"K";$0.00', value_format_name: !!null '',
        _kind_hint: measure, _type_hint: number}, {table_calculation: to_quota, label: "%\
          \ to Quota", expression: "${opportunity.total_new_closed_won_amount_qtd}/${quota.quarterly_quota}",
        value_format: !!null '', value_format_name: percent_0, _kind_hint: measure,
        _type_hint: number}, {table_calculation: gap, label: Gap, expression: 'if((${quota.quarterly_quota}-${opportunity.total_new_closed_won_amount_qtd})>0,${quota.quarterly_quota}-${opportunity.total_new_closed_won_amount_qtd},0)',
        value_format: '[>=1000000]$0.00,,"M";[>=1000]$0,"K";$0.00', value_format_name: !!null '',
        _kind_hint: measure, _type_hint: number}, {table_calculation: pipeline, label: Pipeline,
        expression: "${opportunity.total_pipeline_amount}", value_format: '[>=1000000]$0.00,,"M";[>=1000]$0,"K";$0.00',
        value_format_name: !!null '', _kind_hint: measure, _type_hint: number}, {
        table_calculation: coverage, label: Coverage, expression: 'if(${gap}=0, null,
          ${opportunity.total_pipeline_amount}/${gap})', value_format: !!null '',
        value_format_name: percent_0, _kind_hint: measure, _type_hint: number}]
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
    series_labels:
      opportunity.total_new_closed_won_amount_qtd: Closed Won
      opportunity.total_pipeline_amount: Pipeline
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: true
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: !!null '',
        font_color: !!null '', color_application: {collection_id: legacy, palette_id: legacy_diverging1,
          options: {steps: 5}}, bold: false, italic: false, strikethrough: false,
        fields: [to_quota]}, {type: along a scale..., value: !!null '', background_color: !!null '',
        font_color: !!null '', color_application: {collection_id: legacy, palette_id: legacy_diverging1,
          options: {steps: 5, constraints: {max: {type: number, value: 1}, min: {
                type: number, value: 0}, mid: {type: number, value: 0.5}}}}, bold: false,
        italic: false, strikethrough: false, fields: [coverage]}]
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    hidden_fields: [opportunity.total_new_closed_won_amount_qtd, opportunity.total_pipeline_amount]
    listen:
      Rep Segment: quota.ae_segment
      Sales Manager: opportunity_owner.manager
      Business Segment: account.business_segment
    row: 26
    col: 0
    width: 24
    height: 12
  - title: Pipeline Revenue QTD
    name: Pipeline Revenue QTD
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields: [opportunity.total_pipeline_new_business_amount, opportunity.total_closed_won_new_business_amount,
      quota.quarterly_aggregate_quota_measure]
    filters:
      opportunity.close_date: this quarter
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: gap, label: Gap, expression: 'if((${quota.quarterly_aggregate_quota_measure}
          - ${opportunity.total_closed_won_new_business_amount}) < 0, "Quota Reached,
          No", to_string(${quota.quarterly_aggregate_quota_measure} - ${opportunity.total_closed_won_new_business_amount}))

          ', value_format: '[>=1000000]$0.00,,"M";[>=1000]$0.00,"K";$0.00', value_format_name: !!null '',
        _kind_hint: measure, _type_hint: string}]
    custom_color_enabled: true
    custom_color: ''
    show_single_value_title: true
    show_comparison: true
    comparison_type: progress_percentage
    comparison_reverse_colors: false
    show_comparison_label: true
    hidden_fields: [opportunity.total_closed_won_new_business_amount, quota_numbers.quarterly_aggregate_quota_measure,
      quota.quarterly_aggregate_quota_measure]
    listen:
      Rep Segment: quota.ae_segment
      Sales Manager: opportunity_owner.manager
      Business Segment: account.business_segment
    row: 0
    col: 6
    width: 6
    height: 4
  filters:
  - name: Rep Segment
    title: Rep Segment
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: sales_analytics
    explore: opportunity
    listens_to_filters: []
    field: quota.ae_segment
  - name: Sales Manager
    title: Sales Manager
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: sales_analytics
    explore: opportunity
    listens_to_filters: []
    field: opportunity_owner.manager
  - name: Business Segment
    title: Business Segment
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: sales_analytics
    explore: opportunity
    listens_to_filters: []
    field: account.business_segment
