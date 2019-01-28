# This file contains "extensions" of all your Salesforce views.
# This is where you can edit and override auto-generated field settings such as
# SQL definitions, front-end labels, hiding, grouping, and more.

include: "_*"

view: account {
  extends: [_account]
  # dimensions #

  dimension_group: _fivetran_synced { hidden: yes }

  dimension: is_active_c {
    label: "Is Active"
    type: yesno
    sql: ${TABLE}.active_c = 'Yes' ;;
  }

  dimension: is_customer {
    type: yesno
    sql: ${type} LIKE 'Customer%' ;;
  }

  dimension: billing_city { group_label: "Billing Details" }
  dimension: billing_country { group_label: "Billing Details" }
  dimension: billing_geocode_accuracy { group_label: "Billing Details" }
  dimension: billing_latitude { group_label: "Billing Details" }
  dimension: billing_longitude { group_label: "Billing Details" }
  dimension: billing_postal_code { group_label: "Billing Details" }
  dimension: billing_state { group_label: "Billing Details" }
  dimension: billing_street { group_label: "Billing Details" }

  # Edited since our current number_of_employees field is a string value
  dimension: business_segment {
    type: string

    case: {
      when: {
        sql: ${number_of_employees} IN ('Under 50', '51 - 200', '201 - 500') ;;
        label: "Small Business"
      }

      when: {
        sql: ${number_of_employees} IN ('501 - 1000') ;;
        label: "Mid-Market"
      }

      when: {
        sql: ${number_of_employees} IN ('1001 - 3000', '3001 - 5000', '5001 - 10000', '10001+') ;;
        label: "Enterprise"
      }

      else: "Unknown"
    }
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

  # measures #

  measure: percent_of_accounts {
    description: "Percent of accounts out of the total number of accounts"
    type: percent_of_total
    sql: ${count} ;;
  }

  measure: average_annual_revenue {
    type: average
    sql: ${annual_revenue} ;;
    value_format: "$#,##0"
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
    type: count

    filters: {
      field: is_customer
      value: "yes"
    }
  }
}

view: campaign {
  extends: [_campaign]

  dimension_group: _fivetran_synced { hidden: yes }
  dimension_group: system_modstamp { hidden: yes }

  measure: count { label: "Number of Campaigns" }
}


view: opportunity_history {
  extends: [_opportunity_history]

  dimension_group: _fivetran_synced { hidden: yes }
  dimension: created_by_id { hidden: yes }
  dimension_group: created { label: "Snapshot" }
  dimension: is_deleted { hidden: yes }
  dimension_group: system_modstamp { hidden: yes }
}
