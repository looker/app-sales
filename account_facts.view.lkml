# These DTs are used to dimensionalize account facts (i.e. start date, lifetime value). Needed for single value viz's on customer lookup tiles.
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
    hidden:  yes
  }
  dimension: account_name {
    hidden:  yes
  }
  dimension: account_start_date {
    label: "Start Date"
    type: date
    view_label: "Account"
  }
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
    hidden:  yes
  }
  dimension: account_name {
    hidden:  yes
  }
  dimension: customer_lifetime_value {
    type: number
    view_label: "Account"
  }
}




view: account_facts_is_customer_core {
  derived_table: {
    explore_source: account {
      filters: {
        field: account.is_customer
        value: "Yes"
      }
      filters: {
        field: opportunity.is_new_business
        value: "Yes"
      }
      filters: {
        field: opportunity.is_won
        value: "Yes"
      }
      column: account_id { field: account.distinct_id }
      derived_column: is_customer {sql: 'Yes' ;;}
    }
  }
  dimension: account_id {primary_key: yes}
  dimension: is_customer {type: yesno sql: ${TABLE}.is_customer = 'Yes' ;; hidden:yes}
}
