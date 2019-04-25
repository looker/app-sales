- dashboard: sales_rep_overview
  extends: sales_analytics_base
  query_timezone: query_saved
  elements:
  - title: of Quota
    name: of Quota
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields: [opportunity.close_quarter, opportunity.percent_of_quarter_reached, opportunity.total_closed_won_new_business_amount,
      quota.total_quota]
    filters:
      opportunity.close_year: this quarter
    sorts: [opportunity.close_quarter]
    limit: 1000
    column_limit: 50
    dynamic_fields: [{table_calculation: percent_of_quota_met, label: Percent of Quota
          Met, expression: "${opportunity.total_closed_won_new_business_amount}/${quota.total_quota}",
        value_format: !!null '', value_format_name: percent_0, _kind_hint: measure,
        _type_hint: number}]
    custom_color_enabled: true
    custom_color: ''
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    comparison_label: Quarter Complete
    font_size: medium
    text_color: black
    hidden_fields: [opportunity.total_closed_won_revenue, opportunity.close_quarter,
      quota_numbers.quarterly_aggregate_quota_measure, quota.total_quota, opportunity.total_closed_won_new_business_amount]
    listen:
      Manager: opportunity_owner.manager
    row: 0
    col: 0
    width: 6
    height: 4
  - title: New Customers
    name: New Customers
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields: [opportunity.count_new_business_won, opportunity.close_year]
    pivots: [opportunity.close_year]
    fill_fields: [opportunity.close_year]
    filters:
      opportunity.close_date: 0 quarters ago for 1 quarter, 4 quarters ago for 1 quarter
    sorts: [opportunity.close_year desc]
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: change, label: Change, expression: 'pivot_index(${opportunity.count_new_business_won},
          1) - pivot_index(${opportunity.count_new_business_won}, 2)', value_format: !!null '',
        value_format_name: decimal_0, _kind_hint: supermeasure, _type_hint: number}]
    filter_expression: "((extract_years(now())=extract_years(${opportunity.close_year})\n\
      \   AND ${opportunity.close_year} <= now())\n\nOR \n\n(((extract_years(now())-1)=extract_years(${opportunity.close_year})\n\
      \  AND ${opportunity.close_year} <= add_years(-1,now()))\n\nAND\n\n(extract_months(${opportunity.close_date})\
      \ = extract_months(now())\nAND\nextract_days(${opportunity.close_date}) <= extract_days(now()))\n\
      \nOR\n\nextract_months(${opportunity.close_date}) < extract_months(now())))"
    custom_color_enabled: true
    custom_color: ''
    show_single_value_title: true
    single_value_title: ''
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: false
    show_comparison_label: true
    comparison_label: vs. Last Quarter
    font_size: small
    hidden_fields:
    listen:
      Manager: opportunity_owner.manager
    row: 0
    col: 18
    width: 6
    height: 4
  - title: Revenue (QTD)
    name: Revenue (QTD)
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields: [opportunity.total_closed_won_new_business_amount, quota.quarterly_quota]
    filters:
      opportunity.close_date: this quarter
    sorts: [opportunity.total_closed_won_new_business_amount desc]
    limit: 500
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
      Manager: opportunity_owner.manager
    row: 0
    col: 6
    width: 6
    height: 4
  - title: Pipeline (QTD)
    name: Pipeline (QTD)
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields: [opportunity.total_pipeline_new_business_amount, opportunity.total_closed_won_new_business_amount,
      quota.quarterly_quota, opportunity_owner.name]
    filters:
      opportunity.close_date: this quarter
    sorts: [opportunity.total_pipeline_new_business_amount desc]
    limit: 500
    dynamic_fields: [{table_calculation: gap, label: Gap, expression: 'if((${quota.quarterly_quota}
          - ${opportunity.total_closed_won_new_business_amount}) < 0,"Quota Reached,
          No",to_string(${quota.quarterly_quota} - ${opportunity.total_closed_won_new_business_amount}))',
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
      Manager: opportunity_owner.manager
    row: 0
    col: 12
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
    sorts: [to_quota desc]
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: closed_won, label: Closed Won, expression: "${opportunity.total_new_closed_won_amount_qtd}",
        value_format: '[>=1000000]$0.0,,"M";[>=1000]$0,"K";$0.00', value_format_name: !!null '',
        _kind_hint: measure, _type_hint: number}, {table_calculation: to_quota, label: "%\
          \ to Quota", expression: "${opportunity.total_new_closed_won_amount_qtd}/${quota.quarterly_quota}",
        value_format: !!null '', value_format_name: percent_0, _kind_hint: measure,
        _type_hint: number}, {table_calculation: gap, label: Gap, expression: 'if((${quota.quarterly_quota}-${opportunity.total_new_closed_won_amount_qtd})>0,${quota.quarterly_quota}-${opportunity.total_new_closed_won_amount_qtd},0)',
        value_format: '[>=1000000]$0.0,,"M";[>=1000]$0,"K";$0.00', value_format_name: !!null '',
        _kind_hint: measure, _type_hint: number}, {table_calculation: pipeline_acv,
        label: Pipeline ACV, expression: "${opportunity.total_pipeline_amount}", value_format: '[>=1000000]$0.0,,"M";[>=1000]$0,"K";$0.00',
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
          options: {steps: 5, __FILE: app-sales/sales_leadership_overview.dashboard.lookml,
            __LINE_NUM: 620}, __FILE: app-sales/sales_leadership_overview.dashboard.lookml,
          __LINE_NUM: 619}, bold: false, italic: false, strikethrough: false, fields: [
          to_quota], __FILE: app-sales/sales_leadership_overview.dashboard.lookml,
        __LINE_NUM: 618}, {type: along a scale..., value: 1, background_color: !!null '',
        font_color: !!null '', color_application: {collection_id: legacy, palette_id: legacy_diverging1,
          options: {steps: 5, constraints: {max: {type: number, value: 0.1, __FILE: app-sales/sales_leadership_overview.dashboard.lookml,
                __LINE_NUM: 623}, min: {type: number, value: 0, __FILE: app-sales/sales_leadership_overview.dashboard.lookml,
                __LINE_NUM: 624}, mid: {type: number, value: 0.5, __FILE: app-sales/sales_leadership_overview.dashboard.lookml,
                __LINE_NUM: 624}, __FILE: app-sales/sales_leadership_overview.dashboard.lookml,
              __LINE_NUM: 623}, __FILE: app-sales/sales_leadership_overview.dashboard.lookml,
            __LINE_NUM: 623}, __FILE: app-sales/sales_leadership_overview.dashboard.lookml,
          __LINE_NUM: 622}, bold: false, italic: false, strikethrough: false, fields: [
          coverage], __FILE: app-sales/sales_leadership_overview.dashboard.lookml,
        __LINE_NUM: 621}]
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    hidden_fields: [opportunity.total_new_closed_won_amount_qtd, opportunity.total_pipeline_amount]
    listen:
      Manager: opportunity_owner.manager
    row: 4
    col: 0
    width: 24
    height: 12
  filters:
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
