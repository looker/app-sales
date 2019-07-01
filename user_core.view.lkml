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

  dimension: ae_region {
    sql: "Configure AE Region" ;;
  }

  # Unhiding for dev purposes (for now). Deprecated since the name_select filter only field serves the same purpose. Having
  # rep_filter is redundant
  # filter: rep_filter {
  #   suggest_explore: opportunity
  #   suggest_dimension: opportunity_owner.name
  #   hidden: no
  # }

  # Unhiding for dev purposes (for now)
#   measure: rep_highlight_acv {
#     type: number
#     hidden: no
#     sql: CASE WHEN ${name} = {% parameter name_select %} THEN ${opportunity.total_closed_won_new_business_amount}
#               ELSE NULL
#               END
#        ;;
#     value_format_name: custom_amount_value_format
#   }

  # rep_comparitor currently depends on "account.business_segment" instead of the intended
  # "department" field. If a custom user table attribute "department" exists,
  # replace business_segment with it.
#   dimension: rep_comparitor {
#     sql: CASE
#         WHEN {% condition name_select %} ${name} {% endcondition %}
#           THEN CONCAT('1 - ', ${name})
#         WHEN {% condition department_select %} ${account.business_segment} {% endcondition %}
#           THEN CONCAT('2 - Rest of ', ${account.business_segment})
#       ELSE '3 - Rest of Sales Team'
#       END
#        ;;
#     hidden: yes
#   }


  dimension: manager {
    type: string
    sql: ${manager.name} ;;
  }

  dimension: id_url {
    sql: ${TABLE}.id ;;
    html: [<a href="https://{{ salesforce_domain_config._sql }}/{{ value }}">Open in SFDC</a>]
      ;;
  }

  dimension: ae_segment {
    type:  string
    sql: ${quota.ae_segment} ;;
  }

  dimension: is_sales_rep {
    type: yesno
    sql: ${quota.name} = ${name};;
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

  measure: rep_highlight_win_percentage {
    type: number
    sql: CASE WHEN ${name} = {% parameter name_select %} THEN ${opportunity.win_percentage}
          ELSE NULL
          END
            ;;
    value_format_name: percent_1
  }

  # field sets for drilling #

  set: user_exclusion_set {
    fields: [manager,average_amount_pipeline,id_url,rep_comparitor]
  }
}
