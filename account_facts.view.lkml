view: account_facts_start_date {
  derived_table: {
    explore_source: opportunity {
      filters: {
        field: opportunity.is_won
        value: "Yes"
      }
      column: account_id {field: account.id}
      column: account_name {field: account.name}
      column: account_start_date {field: opportunity.earliest_close_date}
    }
  }

  dimension: account_id {
    primary_key: yes
  }
  dimension: account_name {}
  dimension: account_start_date {}
}

view: account_facts_customer_lifetime_value {
  derived_table: {
    explore_source: opportunity {
      filters: {
        field: opportunity.is_won
        value: "Yes"
      }
      column: account_id { field: account.id }
      column: account_name { field: account.name }
      column: customer_lifetime_value { field: opportunity.total_closed_won_amount }
    }
  }
  dimension: account_id {
    primary_key: yes
  }
  dimension: account_name {}
  dimension: customer_lifetime_value {}
}
