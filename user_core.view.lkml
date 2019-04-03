view: user_core {
  extends: [user_adapter]
  extension: required
  # dimensions #

  # Unhiding for dev purposes (for now)
  filter: name_select {
    suggest_dimension: opportunity_owner.name
    hidden: no
  }

  # Unhiding for dev purposes (for now)
  filter: department_select {
    suggest_dimension: account.business_segment
    hidden: no
  }

  # Unhiding for dev purposes (for now). Deprecated since the name_select filter only field serves the same purpose. Having
  # rep_filter is redundant
  # filter: rep_filter {
  #   suggest_explore: opportunity
  #   suggest_dimension: opportunity_owner.name
  #   hidden: no
  # }

  # Unhiding for dev purposes (for now)
  measure: rep_highlight_acv {
    type: number
    hidden: no
    sql: CASE WHEN ${name} = {% parameter name_select %} THEN ${opportunity.total_closed_won_new_business_amount}
              ELSE NULL
              END
       ;;
    value_format_name: custom_amount_value_format
  }

  measure: rep_highlight_win_percentage {
    type: number
    sql: CASE WHEN ${name} = {% parameter name_select %} THEN ${opportunity.win_percentage}
    ELSE NULL
    END
      ;;
    value_format_name: percent_1
  }

  measure: rep_highlight_average_new_deal_size_won {
    type: number
    sql: CASE WHEN ${name} = {% parameter name_select %} THEN ${opportunity.average_new_deal_size_won}
          ELSE NULL
          END
            ;;
    value_format_name: custom_amount_value_format
  }

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
    hidden: yes
  }


  dimension: manager {
    type: string
    sql: ${manager.name} ;;
  }

  dimension: id_url {
    sql: ${TABLE}.id ;;
    html: [<a href="https://{{ salesforce_domain_config._sql }}/{{ value }}">Open in SFDC</a>]
      ;;
  }

  dimension: city { group_label: "Address" }
  dimension: country { group_label: "Address" }
  dimension: latitude { group_label: "Address" }
  dimension: longitude { group_label: "Address" }
  dimension: postal_code { group_label: "Address" }
  dimension: state { group_label: "Address" }
  dimension: street { group_label: "Address" }

  # measures #

  measure: average_amount_pipeline {
    type: number
    sql: ${opportunity.total_pipeline_amount}/ NULLIF(${count},0) ;;
    value_format_name: custom_amount_value_format
    drill_fields: [account.name, opportunity.type, opportunity.closed_date, opportunity.total_acv]
  }

  measure: count {
    label: "Number of
    {% if _view._name == 'opportunity_owner' %}
    Opportunity Owners
    {% elsif _view._name == 'account_owner' %}
    Account Owners
    {% elsif _view._name == 'lead_owner' %}
    Lead Owners
    {% else %}
    Users
    {% endif %}"
  }

  # field sets for drilling #

  set: user_exclusion_set {
    fields: [manager,average_amount_pipeline,id_url,rep_comparitor]
  }
}



#### Unused ########################################################################################################################################


# dimension_group: _fivetran_synced { hidden: yes }
# dimension: email_encoding_key { group_label: "Email Preferences" }
# dimension: email_preferences_auto_bcc { group_label: "Email Preferences" }
# dimension: email_preferences_auto_bcc_stay_in_touch { group_label: "Email Preferences" }
# dimension: email_preferences_stay_in_touch_reminder { group_label: "Email Preferences" }
#
# dimension: user_permissions_call_center_auto_login { group_label: "User Permissions" }
# dimension: user_permissions_interaction_user { group_label: "User Permissions" }
# dimension: user_permissions_jigsaw_prospecting_user { group_label: "User Permissions" } # NOTE: not found in existing table
# dimension: user_permissions_knowledge_user { group_label: "User Permissions" }
# dimension: user_permissions_marketing_user { group_label: "User Permissions" }
# dimension: user_permissions_mobile_user { group_label: "User Permissions" }
# dimension: user_permissions_offline_user { group_label: "User Permissions" }
# dimension: user_permissions_sfcontent_user { group_label: "User Permissions" }
# dimension: user_permissions_siteforce_contributor_user { group_label: "User Permissions" }  # NOTE: not found in existing table
# dimension: user_permissions_siteforce_publisher_user { group_label: "User Permissions" }  # NOTE: not found in existing table
# dimension: user_permissions_support_user { group_label: "User Permissions" }
# dimension: user_permissions_work_dot_com_user_feature { group_label: "User Permissions" }  # NOTE: not found in existing table
#
# dimension: user_preferences_activity_reminders_popup { group_label: "User Preferences" }
# dimension: user_preferences_apex_pages_developer_mode { group_label: "User Preferences" }
# dimension: user_preferences_cache_diagnostics { group_label: "User Preferences" }
# dimension: user_preferences_content_email_as_and_when { group_label: "User Preferences" } #NOTE: not found in existing table
# dimension: user_preferences_content_no_email { group_label: "User Preferences" } #NOTE: not found in existing table
# dimension: user_preferences_dis_comment_after_like_email { group_label: "User Preferences" }
# dimension: user_preferences_dis_mentions_comment_email { group_label: "User Preferences" }
# dimension: user_preferences_dis_prof_post_comment_email { group_label: "User Preferences" }
# dimension: user_preferences_disable_all_feeds_email { group_label: "User Preferences" }
# dimension: user_preferences_disable_bookmark_email { group_label: "User Preferences" }
# dimension: user_preferences_disable_change_comment_email { group_label: "User Preferences" }
# dimension: user_preferences_disable_endorsement_email { group_label: "User Preferences" }
# dimension: user_preferences_disable_feedback_email { group_label: "User Preferences" } #NOTE: not found in existing table
# dimension: user_preferences_disable_file_share_notifications_for_api { group_label: "User Preferences" }
# dimension: user_preferences_disable_followers_email { group_label: "User Preferences" }
# dimension: user_preferences_disable_later_comment_email { group_label: "User Preferences" }
# dimension: user_preferences_disable_like_email { group_label: "User Preferences" }
# dimension: user_preferences_disable_mentions_post_email { group_label: "User Preferences" }
# dimension: user_preferences_disable_message_email { group_label: "User Preferences" }
# dimension: user_preferences_disable_profile_post_email { group_label: "User Preferences" }
# dimension: user_preferences_disable_share_post_email { group_label: "User Preferences" }
# dimension: user_preferences_disable_work_email { group_label: "User Preferences" } #NOTE: not found in existing table
# dimension: user_preferences_enable_auto_sub_for_feeds { group_label: "User Preferences" }
# dimension: user_preferences_event_reminders_checkbox_default { group_label: "User Preferences" }
# dimension: user_preferences_hide_chatter_onboarding_splash { group_label: "User Preferences" }
# dimension: user_preferences_hide_csndesktop_task { group_label: "User Preferences" }
# dimension: user_preferences_hide_csnget_chatter_mobile_task { group_label: "User Preferences" }
# dimension: user_preferences_hide_s_1_browser_ui { group_label: "User Preferences" }
# dimension: user_preferences_hide_second_chatter_onboarding_splash { group_label: "User Preferences" }
# dimension: user_preferences_jigsaw_list_user { group_label: "User Preferences" } #NOTE: not found in existing table
# dimension: user_preferences_lightning_experience_preferred { group_label: "User Preferences" }
# dimension: user_preferences_path_assistant_collapsed { group_label: "User Preferences" }
# dimension: user_preferences_reminder_sound_off { group_label: "User Preferences" }
# dimension: user_preferences_show_city_to_external_users { group_label: "User Preferences" }
# dimension: user_preferences_show_city_to_guest_users { group_label: "User Preferences" }
# dimension: user_preferences_show_country_to_external_users { group_label: "User Preferences" }
# dimension: user_preferences_show_country_to_guest_users { group_label: "User Preferences" }
# dimension: user_preferences_show_email_to_external_users { group_label: "User Preferences" }
# dimension: user_preferences_show_email_to_guest_users { group_label: "User Preferences" }
# dimension: user_preferences_show_fax_to_external_users { group_label: "User Preferences" }
# dimension: user_preferences_show_fax_to_guest_users { group_label: "User Preferences" }
# dimension: user_preferences_show_manager_to_external_users { group_label: "User Preferences" }
# dimension: user_preferences_show_manager_to_guest_users { group_label: "User Preferences" }
# dimension: user_preferences_show_mobile_phone_to_external_users { group_label: "User Preferences" }
# dimension: user_preferences_show_mobile_phone_to_guest_users { group_label: "User Preferences" }
# dimension: user_preferences_show_postal_code_to_external_users { group_label: "User Preferences" }
# dimension: user_preferences_show_postal_code_to_guest_users { group_label: "User Preferences" }
# dimension: user_preferences_show_profile_pic_to_guest_users { group_label: "User Preferences" }
# dimension: user_preferences_show_state_to_external_users { group_label: "User Preferences" }
# dimension: user_preferences_show_state_to_guest_users { group_label: "User Preferences" }
# dimension: user_preferences_show_street_address_to_external_users { group_label: "User Preferences" }
# dimension: user_preferences_show_street_address_to_guest_users { group_label: "User Preferences" }
# dimension: user_preferences_show_title_to_external_users { group_label: "User Preferences" }
# dimension: user_preferences_show_title_to_guest_users { group_label: "User Preferences" }
# dimension: user_preferences_show_work_phone_to_external_users { group_label: "User Preferences" }
# dimension: user_preferences_show_work_phone_to_guest_users { group_label: "User Preferences" }
# dimension: user_preferences_sort_feed_by_comment { group_label: "User Preferences" }
# dimension: user_preferences_task_reminders_checkbox_default { group_label: "User Preferences" }
#
# dimension_group: system_modstamp { hidden: yes }
