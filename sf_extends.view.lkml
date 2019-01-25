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

view: lead {
  extends: [_lead]
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

  dimension: name {
    html: <a href="https://na9.salesforce.com/{{ lead.id._value }}" target="_new">
      <img src="https://www.google.com/s2/favicons?domain=www.salesforce.com" height=16 width=16></a>
      {{ linked_value }}
      ;;
  }

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
}

view: opportunity {
  extends: [_opportunity]
  # dimensions #

  dimension_group: _fivetran_synced { hidden: yes }

  dimension: is_lost {
    type: yesno
    sql: ${is_closed} AND NOT ${is_won} ;;
  }

  dimension: probability_group {
    case: {
      when: {
        sql: ${probability} = 100 ;;
        label: "Won"
      }

      when: {
        sql: ${probability} > 80 ;;
        label: "Above 80%"
      }

      when: {
        sql: ${probability} > 60 ;;
        label: "60 - 80%"
      }

      when: {
        sql: ${probability} > 40 ;;
        label: "40 - 60%"
      }

      when: {
        sql: ${probability} > 20 ;;
        label: "20 - 40%"
      }

      when: {
        sql: ${probability} > 0 ;;
        label: "Under 20%"
      }

      when: {
        sql: ${probability} = 0 ;;
        label: "Lost"
      }
    }
  }

  dimension: created {
    #X# Invalid LookML inside "dimension": {"timeframes":["date","week","month","raw"]}
  }

  dimension: close {
    #X# Invalid LookML inside "dimension": {"timeframes":["date","week","month","raw"]}
  }

  dimension: created_is_before_close_date {
    hidden: no
    #this is a data quality issue with a specific Demo instance, disable if not needed!
    type: yesno
    sql: ${close_raw} <= ${created_raw} ;;
  }

  dimension: days_open {
    description: "Number of days from opportunity creation to close. If not yet closed, this uses today's date."
    type: number
    sql: DATE_DIFF(coalesce(${close_date}, current_date), ${created_date}, DAY) ;;
  }

  dimension: days_to_closed_won {
    description: "Number of days from opportunity creation to Closed-Won status"
    type: number
    sql: CASE WHEN ${is_closed} AND ${is_won} THEN ${days_open}
              ELSE null
              END ;;
  }

  dimension: created_to_closed_in_60 {
    hidden: yes
    type: yesno
    sql: ${days_open} <=60 AND ${is_closed} AND ${is_won} ;;
  }

  dimension_group: system_modstamp { hidden: yes }

  # measures #

  measure: total_revenue {
    type: sum
    sql: ${amount} ;;
    value_format: "$#,##0"
  }

  measure: average_revenue_won {
    label: "Average Revenue (Closed/Won)"
    type: average
    sql: ${amount} ;;

    filters: {
      field: is_won
      value: "Yes"
    }

    value_format: "$#,##0"
  }

  measure: average_revenue_lost {
    label: "Average Revenue (Closed/Lost)"
    type: average
    sql: ${amount} ;;

    filters: {
      field: is_lost
      value: "Yes"
    }

    value_format: "$#,##0"
  }

  measure: total_pipeline_revenue {
    type: sum
    sql: ${amount} ;;

    filters: {
      field: is_closed
      value: "No"
    }
    value_format: "$#,##0"
    # value_format: "[>=1000000]$0.00,,\"M\";[>=1000]$0.00,\"K\";$0.00"
    ## The above will cause values to display like $1.25M / $100.00K / $9.99
  }

  measure: average_deal_size {
    type: average
    sql: ${amount} ;;
    value_format: "$#,##0"
  }

  measure: count { label: "Number of Opportunities" }

  measure: count_won {
    label: "Number of Opportunities Won"
    type: count

    filters: {
      field: is_won
      value: "Yes"
    }

    drill_fields: [opportunity.id, account.name, type]
  }

  measure: average_days_open {
    type: average
    sql: ${days_open} ;;
    value_format_name: decimal_1
  }

  measure: average_days_to_closed_won {
    type: average
    sql: ${days_to_closed_won} ;;
    value_format_name: decimal_1
  }
  ## BQ documentation on AVERAGE function:
  # If a row contains a missing or null value, it is not factored into the calculation.
  # If the entire column contains no values, the function returns a null value.

  measure: count_closed {
    label: "Number of Closed Opportunities"
    type: count

    filters: {
      field: is_closed
      value: "Yes"
    }
  }

  measure: count_open {
    label: "Number of Open Opportunities"
    type: count

    filters: {
      field: is_closed
      value: "No"
    }
  }

  measure: count_lost {
    label: "Number of Lost Opportunities"
    type: count

    filters: {
      field: is_closed
      value: "Yes"
    }

    filters: {
      field: is_won
      value: "No"
    }

    drill_fields: [opportunity.id, account.name, type]
  }

  measure: win_percentage {
    type: number
    sql: 100.00 * ${count_won} / NULLIF(${count_closed}, 0) ;;
    value_format: "#0.00\%"
  }

  measure: open_percentage {
    type: number
    sql: 100.00 * ${count_open} / NULLIF(${count}, 0) ;;
    value_format: "#0.00\%"
  }

  measure: count_new_business_won {
    label: "Number of New-Business Opportunities Won"
    type: count

    filters: {
      field: is_won
      value: "Yes"
    }

    filters: {
      field: opportunity.type
      value: "\"New Customer\""
    }

    drill_fields: [opportunity.id, account.name, type]
  }


  measure: count_new_business {
    label: "Number of New-Business Opportunities"
    type: count

    filters: {
      field: opportunity.type
      value: "\"New Customer\""
    }

    drill_fields: [opportunity.id, account.name, type]
  }
}

view: campaign {
  extends: [_campaign]

  dimension_group: _fivetran_synced { hidden: yes }
  dimension_group: system_modstamp { hidden: yes }

  measure: count { label: "Number of Campaigns" }
}

view: opportunity_stage {
  extends: [_opportunity_stage]

  dimension_group: _fivetran_synced { hidden: yes }
  dimension: id { hidden: yes }
  dimension: api_name { hidden: yes }
  dimension: created_by_id { hidden: yes }
  dimension_group: created { hidden: yes }
  dimension: default_probability { hidden: yes }
  dimension: description { hidden: yes }
  dimension: forecast_category { hidden: yes }
  dimension: forecast_category_name { hidden: yes }
  dimension: is_active { hidden: yes }
  dimension: is_closed { hidden: yes }
  dimension: is_won { hidden: yes }
  dimension: last_modified_by_id { hidden: yes }
  dimension_group: last_modified { hidden: yes }
  dimension: master_label { hidden: yes }
  dimension: sort_order { hidden: yes }
  dimension_group: system_modstamp { hidden: yes }

}

view: opportunity_history {
  extends: [_opportunity_history]

  dimension_group: _fivetran_synced { hidden: yes }
  dimension: created_by_id { hidden: yes }
  dimension_group: created { label: "Snapshot" }
  dimension: is_deleted { hidden: yes }
  dimension_group: system_modstamp { hidden: yes }
}

view: user {
  extends: [_user]
  # dimensions #

  filter: name_select {
    suggest_dimension: name
  }

  filter: department_select {
    suggest_dimension: department
  }

  dimension_group: _fivetran_synced { hidden: yes }

  # rep_comparitor currently depends on "account.business_segment" instead of the intended
  # "department" field. If a custom user table attribute "department" exists,
  # replace business_segment with it.
  dimension: rep_comparitor {
    sql: CASE
        WHEN {% condition name_select %} ${name} {% endcondition %}
          THEN CONCAT('1 - ', ${name})
        WHEN {% condition department_select %} ${account.business_segment} {% endcondition %}
          THEN CONCAT('2 - Rest of ', ${account.business_segment})
      ELSE '3 - Rest of Sales Team'
      END
       ;;
  }

  dimension: created {
    #X# Invalid LookML inside "dimension": {"timeframes":["date","week","month","raw"]}
  }

  dimension: age_in_months {
    type: number
    sql: DATE_DIFF(current_date, ${created_date}, MONTH) ;;
  }

  dimension: city { group_label: "Address" }
  dimension: country { group_label: "Address" }
  dimension: latitude { group_label: "Address" }
  dimension: longitude { group_label: "Address" }
  dimension: postal_code { group_label: "Address" }
  dimension: state { group_label: "Address" }
  dimension: street { group_label: "Address" }

  dimension: email_encoding_key { group_label: "Email Preferences" }
  dimension: email_preferences_auto_bcc { group_label: "Email Preferences" }
  dimension: email_preferences_auto_bcc_stay_in_touch { group_label: "Email Preferences" }
  dimension: email_preferences_stay_in_touch_reminder { group_label: "Email Preferences" }

  dimension: user_permissions_call_center_auto_login { group_label: "User Permissions" }
  dimension: user_permissions_interaction_user { group_label: "User Permissions" }
  dimension: user_permissions_jigsaw_prospecting_user { group_label: "User Permissions" } # NOTE: not found in existing table
  dimension: user_permissions_knowledge_user { group_label: "User Permissions" }
  dimension: user_permissions_marketing_user { group_label: "User Permissions" }
  dimension: user_permissions_mobile_user { group_label: "User Permissions" }
  dimension: user_permissions_offline_user { group_label: "User Permissions" }
  dimension: user_permissions_sfcontent_user { group_label: "User Permissions" }
  dimension: user_permissions_siteforce_contributor_user { group_label: "User Permissions" }  # NOTE: not found in existing table
  dimension: user_permissions_siteforce_publisher_user { group_label: "User Permissions" }  # NOTE: not found in existing table
  dimension: user_permissions_support_user { group_label: "User Permissions" }
  dimension: user_permissions_work_dot_com_user_feature { group_label: "User Permissions" }  # NOTE: not found in existing table

  dimension: user_preferences_activity_reminders_popup { group_label: "User Preferences" }
  dimension: user_preferences_apex_pages_developer_mode { group_label: "User Preferences" }
  dimension: user_preferences_cache_diagnostics { group_label: "User Preferences" }
  dimension: user_preferences_content_email_as_and_when { group_label: "User Preferences" } #NOTE: not found in existing table
  dimension: user_preferences_content_no_email { group_label: "User Preferences" } #NOTE: not found in existing table
  dimension: user_preferences_dis_comment_after_like_email { group_label: "User Preferences" }
  dimension: user_preferences_dis_mentions_comment_email { group_label: "User Preferences" }
  dimension: user_preferences_dis_prof_post_comment_email { group_label: "User Preferences" }
  dimension: user_preferences_disable_all_feeds_email { group_label: "User Preferences" }
  dimension: user_preferences_disable_bookmark_email { group_label: "User Preferences" }
  dimension: user_preferences_disable_change_comment_email { group_label: "User Preferences" }
  dimension: user_preferences_disable_endorsement_email { group_label: "User Preferences" }
  dimension: user_preferences_disable_feedback_email { group_label: "User Preferences" } #NOTE: not found in existing table
  dimension: user_preferences_disable_file_share_notifications_for_api { group_label: "User Preferences" }
  dimension: user_preferences_disable_followers_email { group_label: "User Preferences" }
  dimension: user_preferences_disable_later_comment_email { group_label: "User Preferences" }
  dimension: user_preferences_disable_like_email { group_label: "User Preferences" }
  dimension: user_preferences_disable_mentions_post_email { group_label: "User Preferences" }
  dimension: user_preferences_disable_message_email { group_label: "User Preferences" }
  dimension: user_preferences_disable_profile_post_email { group_label: "User Preferences" }
  dimension: user_preferences_disable_share_post_email { group_label: "User Preferences" }
  dimension: user_preferences_disable_work_email { group_label: "User Preferences" } #NOTE: not found in existing table
  dimension: user_preferences_enable_auto_sub_for_feeds { group_label: "User Preferences" }
  dimension: user_preferences_event_reminders_checkbox_default { group_label: "User Preferences" }
  dimension: user_preferences_hide_chatter_onboarding_splash { group_label: "User Preferences" }
  dimension: user_preferences_hide_csndesktop_task { group_label: "User Preferences" }
  dimension: user_preferences_hide_csnget_chatter_mobile_task { group_label: "User Preferences" }
  dimension: user_preferences_hide_s_1_browser_ui { group_label: "User Preferences" }
  dimension: user_preferences_hide_second_chatter_onboarding_splash { group_label: "User Preferences" }
  dimension: user_preferences_jigsaw_list_user { group_label: "User Preferences" } #NOTE: not found in existing table
  dimension: user_preferences_lightning_experience_preferred { group_label: "User Preferences" }
  dimension: user_preferences_path_assistant_collapsed { group_label: "User Preferences" }
  dimension: user_preferences_reminder_sound_off { group_label: "User Preferences" }
  dimension: user_preferences_show_city_to_external_users { group_label: "User Preferences" }
  dimension: user_preferences_show_city_to_guest_users { group_label: "User Preferences" }
  dimension: user_preferences_show_country_to_external_users { group_label: "User Preferences" }
  dimension: user_preferences_show_country_to_guest_users { group_label: "User Preferences" }
  dimension: user_preferences_show_email_to_external_users { group_label: "User Preferences" }
  dimension: user_preferences_show_email_to_guest_users { group_label: "User Preferences" }
  dimension: user_preferences_show_fax_to_external_users { group_label: "User Preferences" }
  dimension: user_preferences_show_fax_to_guest_users { group_label: "User Preferences" }
  dimension: user_preferences_show_manager_to_external_users { group_label: "User Preferences" }
  dimension: user_preferences_show_manager_to_guest_users { group_label: "User Preferences" }
  dimension: user_preferences_show_mobile_phone_to_external_users { group_label: "User Preferences" }
  dimension: user_preferences_show_mobile_phone_to_guest_users { group_label: "User Preferences" }
  dimension: user_preferences_show_postal_code_to_external_users { group_label: "User Preferences" }
  dimension: user_preferences_show_postal_code_to_guest_users { group_label: "User Preferences" }
  dimension: user_preferences_show_profile_pic_to_guest_users { group_label: "User Preferences" }
  dimension: user_preferences_show_state_to_external_users { group_label: "User Preferences" }
  dimension: user_preferences_show_state_to_guest_users { group_label: "User Preferences" }
  dimension: user_preferences_show_street_address_to_external_users { group_label: "User Preferences" }
  dimension: user_preferences_show_street_address_to_guest_users { group_label: "User Preferences" }
  dimension: user_preferences_show_title_to_external_users { group_label: "User Preferences" }
  dimension: user_preferences_show_title_to_guest_users { group_label: "User Preferences" }
  dimension: user_preferences_show_work_phone_to_external_users { group_label: "User Preferences" }
  dimension: user_preferences_show_work_phone_to_guest_users { group_label: "User Preferences" }
  dimension: user_preferences_sort_feed_by_comment { group_label: "User Preferences" }
  dimension: user_preferences_task_reminders_checkbox_default { group_label: "User Preferences" }

  dimension_group: system_modstamp { hidden: yes }

  # measures #

  measure: average_revenue_pipeline {
    type: number
    sql: ${opportunity.total_pipeline_revenue}/ NULLIF(${count},0) ;;
    value_format: "[>=1000000]$0.00,,\"M\";[>=1000]$0.00,\"K\";$0.00"
    drill_fields: [account.name, opportunity.type, opportunity.closed_date, opportunity.total_acv]
  }

  measure: count { label: "Number of Users" }

  # field sets for drilling #

  set: opportunity_set {
    fields: [average_revenue_pipeline]
  }
}

view: contact {
  extends: [_contact]
  # dimensions #

  dimension_group: _fivetran_synced { hidden: yes }

  dimension: mailing_city { group_label: "Mailing Details" }
  dimension: mailing_country { group_label: "Mailing Details" }
  dimension: mailing_geocode_accuracy { group_label: "Mailing Details" }
  dimension: mailing_latitude { group_label: "Mailing Details" }
  dimension: mailing_longitude { group_label: "Mailing Details" }
  dimension: mailing_postal_code { group_label: "Mailing Details" }
  dimension: mailing_state { group_label: "Mailing Details" }
  dimension: mailing_street { group_label: "Mailing Details" }

  dimension: other_city { group_label: "Other Contact Details" }
  dimension: other_country { group_label: "Other Contact Details" }
  dimension: other_geocode_accuracy { group_label: "Other Contact Details" }
  dimension: other_latitude { group_label: "Other Contact Details" }
  dimension: other_longitude { group_label: "Other Contact Details" }
  dimension: other_phone { group_label: "Other Contact Details" }
  dimension: other_postal_code { group_label: "Other Contact Details" }
  dimension: other_state { group_label: "Other Contact Details" }
  dimension: other_street { group_label: "Other Contact Details" }

  dimension: name {
    html: <a href="mailto:{{ contact.email._value }}" target="_blank">
        <img src="https://upload.wikimedia.org/wikipedia/commons/4/4e/Gmail_Icon.png" width="16" height="16" />
      </a>
      {{ linked_value }}
      ;;
  }

  dimension_group: system_modstamp { hidden: yes }

  # measures #

  measure: count { label: "Number of Contacts" }
}
