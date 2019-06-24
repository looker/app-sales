view: account_core {
  extends: [account_adapter]
#   extension: required

  # filters #
  filter: account_select {
    type: string
    suggest_dimension: name
    #hidden: yes
  }

  # dimensions #

  dimension: account_comparitor {
    type: string
    case: {
      when: {
        label: "Selected Account"
        sql: {% condition account_select %} ${name} {% endcondition %};;
      }
      else: "All Other Accounts"
    }
    hidden: yes
  }

  dimension_group: _fivetran_synced { hidden: yes }

#   dimension: is_active_c {
#     label: "Is Active"
#     type: yesno
#     group_label: "Status"
#     sql: ${TABLE}.active_c = 'Yes' ;;
#   }

  dimension: is_customer_core {
    type: yesno
    label: "Is Customer"
    hidden: no
    group_label: "Status"
    sql: ${account_facts_is_customer.is_customer};;
  }

  dimension: is_customer {
    hidden: yes
  }

  dimension: distinct_id {
    type: string
    sql: distinct coalesce(${TABLE}.parent_id,${TABLE}.id) ;;
    hidden: no
  }

  dimension: id_url {
    sql: ${TABLE}.id ;;
    html: [<a href="https://{{ salesforce_domain_config._sql }}/{{ value }}">Open in SFDC</a>];;
    hidden: yes
  }

  dimension: billing_city { group_label: "Billing Details" }
  dimension: billing_country { group_label: "Billing Details" }
  dimension: billing_geocode_accuracy { group_label: "Billing Details" }
  dimension: billing_latitude { group_label: "Billing Details" }
  dimension: billing_longitude { group_label: "Billing Details" }
  dimension: billing_postal_code { group_label: "Billing Details" }
  dimension: billing_state {
    group_label: "Billing Details"
    map_layer_name: us_states
  }
  dimension: billing_street { group_label: "Billing Details" }

  dimension: billing_location {
    group_label: "Billing Details"
    type:  location
    sql_latitude:${billing_latitude} ;;
    sql_longitude:${billing_longitude} ;;
  }

  # Edited since our current number_of_employees field is a string value
  dimension: business_segment {
    type: string
    sql: 'Configure Business Segments' ;;
  }

  dimension: shipping_city { group_label: "Shipping Details" }
  dimension: shipping_country { group_label: "Shipping Details" }
  dimension: shipping_geocode_accuracy { group_label: "Shipping Details" }
  dimension: shipping_latitude { group_label: "Shipping Details" }
  dimension: shipping_longitude { group_label: "Shipping Details" }
  dimension: shipping_postal_code { group_label: "Shipping Details" }
  dimension: shipping_state { group_label: "Shipping Details" }
  dimension: shipping_street { group_label: "Shipping Details" }

  dimension_group: system_modstamp { hidden: yes }

  # Uses the "account_facts_start_date" NDT to calculate the start date of a given account
  dimension: days_as_customer {
    description: "Days as customer for individual account"
    type: number
    hidden: no
    sql: DATE_DIFF(CURRENT_DATE, ${account_facts_start_date.account_start_date}, day) ;;
  }

  # Uses the "account_facts_cltv" NDT to calculate the lifetime value of a given customer
  dimension: customer_lifetime_value {
    type: number
    sql: ${account_facts_customer_lifetime_value.customer_lifetime_value} ;;
    hidden: yes
  }

  # measures #

  measure: percent_of_accounts {
    description: "Percent of accounts out of the total number of accounts"
    type: percent_of_total
    sql: ${count} ;;
  }

  measure: average_annual_revenue {
    type: average
    sql: ${annual_revenue} ;;
    value_format_name: custom_amount_value_format
  }

  measure: total_number_of_employees {
    type: sum
    sql: ${number_of_employees} ;;
  }

  measure: average_number_of_employees {
    type: average
    sql: ${number_of_employees} ;;
    value_format_name: decimal_1
  }

  measure: count { label: "Number of Accounts" }

  measure: count_customers {
    label: "Number of Customers"
    description: "Number of accounts that are defined as customers"
    type: count_distinct
    sql: ${id} ;;

    filters: {
      field: is_customer_core
      value: "yes"
    }

    drill_fields: [account_drill_set*]
  }

  measure: average_days_as_customer {
    type: average
    sql: ${days_as_customer} ;;
    value_format_name: decimal_0
  }

measure: average_customer_lifetime_value {
  type: average
  sql: ${customer_lifetime_value} ;;
  value_format_name: custom_amount_value_format
}

  set: account_exclusion_set  {
    fields: [days_as_customer, customer_lifetime_value, is_customer_core, count_customers]
  }

  # Used when you want quick facts on the accounts that make up a measure
  set: account_drill_set {
    fields: [name, id_url, business_segment, days_as_customer, customer_lifetime_value]
  }
}
