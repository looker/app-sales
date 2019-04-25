- dashboard: sales_rep_leads
  extends: sales_analytics_base
  elements:
  - title: Calls
    name: Calls
    model: sales_analytics
    explore: lead
    type: single_value
    fields: [lead.count, task.calls, task.emails, task.meetings]
    filters:
      lead.is_converted: 'No'
    limit: 50
    column_limit: 50
    show_view_names: false
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
    hidden_fields: [task.emails, task.meetings, lead.count]
    listen:
      Sales Rep: lead_owner.name
    row: 0
    col: 6
    width: 6
    height: 4
  - title: Emails
    name: Emails
    model: sales_analytics
    explore: lead
    type: single_value
    fields: [lead.count, task.calls, task.emails, task.meetings]
    filters:
      lead.is_converted: 'No'
    limit: 50
    column_limit: 50
    show_view_names: false
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
    hidden_fields: [task.meetings, lead.count, task.calls]
    listen:
      Sales Rep: lead_owner.name
    row: 0
    col: 12
    width: 6
    height: 4
  - title: Open Leads
    name: Open Leads
    model: sales_analytics
    explore: lead
    type: single_value
    fields: [lead.count, task.calls, task.emails, task.meetings]
    filters:
      lead.is_converted: 'No'
    limit: 50
    column_limit: 50
    show_view_names: false
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
    hidden_fields: [task.emails, task.meetings, task.calls]
    listen:
      Sales Rep: lead_owner.name
    row: 0
    col: 0
    width: 6
    height: 4
  - title: Meetings
    name: Meetings
    model: sales_analytics
    explore: lead
    type: single_value
    fields: [lead.count, task.calls, task.emails, task.meetings]
    filters:
      lead.is_converted: 'No'
    limit: 50
    column_limit: 50
    show_view_names: false
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
    hidden_fields: [lead.count, task.calls, task.emails]
    listen:
      Sales Rep: lead_owner.name
    row: 0
    col: 18
    width: 6
    height: 4
  - title: List of All Active Leads
    name: List of All Active Leads
    model: sales_analytics
    explore: lead
    type: table
    fields: [lead.name, lead.company, lead.days_as_lead, lead.status, lead.last_activity_date,
      task.calls, task.emails, task.meetings]
    filters:
      lead.is_converted: 'No'
    sorts: [lead.status desc]
    limit: 50
    column_limit: 50
    show_view_names: false
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
    listen:
      Sales Rep: lead_owner.name
    row: 4
    col: 0
    width: 24
    height: 13
  filters:
  - name: Sales Rep
    title: Sales Rep
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: sales_analytics
    explore: lead
    listens_to_filters: []
    field: lead_owner.name
