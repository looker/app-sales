- dashboard: sales_rep_accounts
  extends: sales_analytics_base
  elements:
  - title: Active Customers
    name: Active Customers
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields: [account.count_customers, opportunity.total_closed_won_amount, opportunity.average_new_deal_size_won,
      opportunity.win_percentage]
    limit: 500
    hidden_fields: [opportunity.win_percentage, opportunity.total_closed_won_amount,
      opportunity.average_new_deal_size_won]
    series_types: {}
    listen:
      Sales Rep: account.name
    row: 0
    col: 0
    width: 6
    height: 4
  - title: Total Customer Bookings
    name: Total Customer Bookings
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields: [account.count_customers, opportunity.total_closed_won_amount, opportunity.average_new_deal_size_won,
      opportunity.win_percentage]
    limit: 500
    hidden_fields: [opportunity.win_percentage, opportunity.average_new_deal_size_won,
      account.count_customers]
    series_types: {}
    listen:
      Sales Rep: account.name
    row: 0
    col: 6
    width: 6
    height: 4
  - title: Conversion Rate
    name: Conversion Rate
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields: [account.count_customers, opportunity.total_closed_won_amount, opportunity.average_new_deal_size_won,
      opportunity.win_percentage]
    limit: 500
    hidden_fields: [account.count_customers, opportunity.total_closed_won_amount,
      opportunity.average_new_deal_size_won]
    series_types: {}
    listen:
      Sales Rep: account.name
    row: 0
    col: 18
    width: 6
    height: 4
  - title: Avg Deal Size
    name: Avg Deal Size
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields: [account.count_customers, opportunity.total_closed_won_amount, opportunity.average_new_deal_size_won,
      opportunity.win_percentage]
    limit: 500
    hidden_fields: [opportunity.win_percentage, account.count_customers, opportunity.total_closed_won_amount]
    series_types: {}
    listen:
      Sales Rep: account.name
    row: 0
    col: 12
    width: 6
    height: 4
  - title: List of All Active Customers
    name: List of All Active Customers
    model: sales_analytics
    explore: account
    type: table
    fields: [account.name, account.logo, account.website, account.type, account.account_source,
      account.annual_revenue, account.business_segment, account.days_as_customer]
    filters:
      account.is_customer: 'Yes'
      opportunity_owner.name: ''
    sorts: [account.name]
    limit: 50
    series_types: {}
    listen:
      Sales Rep: account.name
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
    explore: account
    listens_to_filters: []
    field: account.name
