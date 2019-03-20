view: lead_core {
  extension: required
  extends: [lead_adapter]
  # dimensions #

  dimension_group: _fivetran_synced { hidden: yes }

  dimension: convert_to_contact {
    label: "Days to Contact Conversion"
    description: "Number of days it took to convert the lead into a contact"
    type: number
    sql: DATE_DIFF(${converted_date}, ${created_date}, DAY) ;;
  }

  # Typically, an opportunity is automatically created when a lead is converted to a contact.
  dimension: convert_to_opportunity {
    label: "Days to Opp. Conversion"
    description: "Number of days it took to convert the lead into an opportunity"
    type: number
    sql: DATE_DIFF(${opportunity.created_date}, ${created_date}, DAY) ;;
  }

  dimension: id_url {
    sql: ${TABLE}.id ;;
    html: [<a href="https://{{ salesforce_domain_config._sql }}/{{ value }}">Open in SFDC</a>]
      ;;
  }

  dimension: created {
    #X# Invalid LookML inside "dimension": {"timeframes":["time","date","week","month","raw"]}
  }

  dimension: city { group_label: "Address" }
  dimension: country { group_label: "Address" }
  dimension: latitude { group_label: "Address" }
  dimension: longitude { group_label: "Address" }
  dimension: postal_code { group_label: "Address" }
  dimension: state { group_label: "Address" }
  dimension: street { group_label: "Address" }

  dimension: number_of_employees_tier {
    type: tier
    tiers: [
      0,
      1,
      11,
      51,
      201,
      501,
      1001,
      5001,
      10000
    ]
    sql: ${number_of_employees} ;;
    style: integer
    description: "Number of Employees as reported on the Salesforce lead"
  }

  dimension_group: system_modstamp { hidden: yes }

  # measures #

  measure: count { label: "Number of Leads" }

  measure: avg_convert_to_contact {
    label: "Average Days to Contact Conversion"
    description: "Average number of days it took to convert the lead into a contact"
    type: average
    sql: ${convert_to_contact} ;;
    value_format_name: decimal_1
  }

  measure: avg_convert_to_opportunity {
    label: "Average Days to Opp. Conversion"
    description: "Average number of days it took to convert the lead into an opportunity"
    type: average
    sql: ${convert_to_opportunity} ;;
    value_format_name: decimal_1
  }

  measure: converted_to_contact_count {
    label: "Number of Leads Converted to Contacts"
    type: count
    drill_fields: [detail*]

    filters: {
      field: converted_contact_id
      value: "-null"
    }
  }

  measure: converted_to_account_count {
    label: "Number of Leads Converted to Accounts"
    type: count
    drill_fields: [detail*]

    filters: {
      field: converted_account_id
      value: "-null"
    }
  }

  measure: converted_to_opportunity_count {
    label: "Number of Leads Converted to Opportunities"
    type: count
    drill_fields: [detail*]

    filters: {
      field: converted_opportunity_id
      value: "-null"
    }
  }

  measure: conversion_to_contact_percent {
    label: "% Leads Converted to Contacts"
    sql: 100.00 * ${converted_to_contact_count} / NULLIF(${count},0) ;;
    type: number
    value_format: "0.00\%"
  }

  measure: conversion_to_account_percent {
    label: "% Leads Converted to Accounts"
    sql: 100.00 * ${converted_to_account_count} / NULLIF(${count},0) ;;
    type: number
    value_format: "0.00\%"
  }

  measure: conversion_to_opportunity_percent {
    label: "% Leads Converted to Opportunities"
    sql: 100.00 * ${converted_to_opportunity_count} / NULLIF(${count},0) ;;
    type: number
    value_format: "0.00\%"
  }

  measure: count_active_leads {
    label: "Number of Active Leads"
    type: count
    value_format_name: decimal_0
    drill_fields: [active_lead_detail*]
    filters: {
      field: is_converted
      value: "No"
    }
    filters: {
      field: is_deleted
      value: "No"
    }
  }

  # field sets for drilling #

  set: detail {
    fields: [
      id,
      company,
      name,
      title,
      phone,
      email,
      status
    ]
  }

  set: active_lead_detail {
    fields: [
      created_date,
      name,
      phone,
      email,
      last_activity_date,
      task.calls,
      task.emails,
      task.meetings
    ]
  }


}
