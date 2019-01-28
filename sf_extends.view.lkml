# This file contains "extensions" of all your Salesforce views.
# This is where you can edit and override auto-generated field settings such as
# SQL definitions, front-end labels, hiding, grouping, and more.

include: "_*"

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
