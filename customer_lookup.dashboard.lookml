- dashboard: customer_lookup
  title: Customer Health/Lookup
  layout: newspaper
  elements:
  - title: Account Name
    name: Account Name
    model: sales_analytics
    explore: account
    type: single_value
    fields:
    - account.name
    limit: 500
    show_view_names: 'true'
    series_types: {}
    listen: {}
    row: 0
    col: 0
    width: 24
    height: 4
