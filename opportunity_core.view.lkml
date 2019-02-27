view: opportunity_core {
  extension: required
  extends: [opportunity_adapter]
  # dimensions #

  dimension_group: _fivetran_synced { hidden: yes }

  dimension: amount {
    label: "{{ amount_display._sql }}"
    sql: ${TABLE}.{{amount_config._sql}};;
    hidden: no
  }

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

  dimension: is_probable_win {
    type: yesno
    sql: ${probability} >= 50 ;;
  }

  dimension: id_url {
    sql: ${TABLE}.id ;;
    html: [<a href="https://{{ salesforce_domain_config._sql }}/{{ value }}">Open in SFDC</a>]
      ;;
  }

  dimension: id {
    hidden: no
  }

  dimension_group: created {
    #X# Invalid LookML inside "dimension": {"timeframes":["date","week","month","raw"]}
  }

  dimension_group: close {
    #X# Invalid LookML inside "dimension": {"timeframes":["date","week","month","raw"]}
  }

  dimension: current_time {
    type: date_raw
    hidden: yes
    sql: CURRENT_TIMESTAMP() ;;
  }

  dimension: did_the_close_date_pass {
    type: yesno
    sql: ${current_time} > ${close_raw} ;;
  }

  dimension: day_of_quarter {
    group_label: "Close Date"
    type: number
    sql: DATE_DIFF(CAST(${close_date} as date), CAST(CONCAT(${close_quarter}, '-01') as date), day) + 1;;
  }

  dimension: days_open {
    description: "Number of days from opportunity creation to close. If not yet closed, this uses today's date."
    type: number
    sql: DATE_DIFF(coalesce(${close_date}, current_date), ${created_date}, DAY) ;;
  }

  # Used primarily for the "Opps slated to close in the next X days" tile
  dimension: close_date_custom {
    type: date
    sql: ${TABLE}.close_date ;;
    html: {{value}} || {{name._value}} ;;
    link: {
      label: "Filter on Opp ID"
      url: "/explore/sales_analytics/opportunity?fields=opportunity.name,opportunity.type,opportunity.forecast_category&f[opportunity.name]={{ name._value | url_encoded }}&limit=500&query_timezone=UTC&vis=%7B%22type%22%3A%22table%22%2C%22series_types%22%3A%7B%7D%7D&filter_config=%7B%22opportunity.name%22%3A%5B%7B%22type%22%3A%22%3D%22%2C%22values%22%3A%5B%7B%22constant%22%3A%22{{ name._value | url_encoded }}%22%7D%2C%7B%7D%5D%2C%22id%22%3A1%2C%22error%22%3Afalse%7D%5D%7D&origin=share-expanded"
    }
  }

  dimension: days_to_closed_won {
    description: "Number of days from opportunity creation to Closed-Won status"
    type: number
    sql: CASE WHEN ${is_closed} AND ${is_won} THEN ${days_open}
              ELSE null
              END ;;

  }

  dimension_group: as_customer  {
    type: duration
    datatype: date
    sql_start: ${close_date}  ;;
    sql_end: current_date ;;
  }

  dimension_group: as_opportunity  {
    type: duration
    datatype: date
    sql_start: ${created_date}  ;;
    sql_end: current_date ;;
  }

  dimension: days_as_opportunity_tier {
    type: tier
    sql: ${days_as_opportunity} ;;
    tiers: [0, 5, 10, 15, 20, 25, 30, 35, 40, 60, 75, 90 ]
    style:integer
  }

  dimension: created_to_closed_in_60 {
    hidden: yes
    type: yesno
    sql: ${days_open} <=60 AND ${is_closed} AND ${is_won} ;;
    drill_fields: [opp_drill_set_closed*]
  }

  dimension_group: system_modstamp { hidden: yes }

  # measures #

  measure: total_amount {
    label: "Total {{ amount_display._sql }}"
    type: sum
    sql: ${amount} ;;
    drill_fields: [opp_drill_set_closed*]
    value_format_name: custom_amount_value_format

  }

  measure: average_amount_won {
    label: "Average {{ amount_display._sql }} Won"
    type: average
    sql: ${amount} ;;
    filters: {
      field: is_won
      value: "Yes"
    }
    value_format_name: custom_amount_value_format
  }

  measure: average_amount_lost {
    label: "Average {{ amount_display._sql }} (Closed/Lost)"
    type: average
    sql: ${amount} ;;
    filters: {
      field: is_lost
      value: "Yes"
    }
    drill_fields: [opp_drill_set_closed*]
    value_format_name: custom_amount_value_format
  }

  measure: average_amount {
    label: "Average {{ amount_display._sql }}"
    type: average
    sql: ${amount} ;;

    value_format_name: custom_amount_value_format
  }

  measure: total_pipeline_amount {
    label: "Pipeline {{ amount_display._sql }}"
    type: sum
    sql: ${amount} ;;

    filters: {
      field: is_closed
      value: "No"
    }
    filters: {
      field: is_pipeline
      value: "Yes"
    }
    value_format_name: custom_amount_value_format
    drill_fields: [opp_drill_set_open*]
    description: "Includes Renewals/Upsells"
    }

  measure: total_pipeline_new_business_amount {
    label: "Pipeline {{ amount_display._sql }}"
    type: sum
    sql: ${amount} ;;

    filters: {
      field: is_closed
      value: "No"
    }
    filters: {
      field: is_pipeline
      value: "Yes"
    }
    filters: {
      field: is_new_business
      value: "Yes"
    }
    value_format_name: custom_amount_value_format
    drill_fields: [opp_drill_set_open*]
    description: "Only Includes New Business Opportunities"
  }

    measure: total_pipeline_amount_ytd {
    label: "Pipeline {{ amount_display._sql }} YTD"
    type: sum
    sql: ${amount} ;;

    filters: {
      field: created_date
      value: "this year"
    }
    filters: {
      field: is_closed
      value: "No"
    }
    filters: {
      field: is_pipeline
      value: "Yes"
    }
    value_format_name: custom_amount_value_format
    drill_fields: [opp_drill_set_closed*]
  }

  measure: total_pipeline_amount_qtd {
    label: "Pipeline {{ amount_display._sql }} YTD"
    type: sum
    sql: ${amount} ;;

    filters: {
      field: created_date
      value: "this quarter"
    }
    filters: {
      field: is_closed
      value: "No"
    }
    filters: {
      field: is_pipeline
      value: "Yes"
    }
    value_format_name: custom_amount_value_format
    drill_fields: [opp_drill_set_closed*]
  }

  measure: total_closed_won_amount {
    label: "Closed Won {{ amount_display._sql }}"
    type: sum
    sql: ${amount}   ;;
    filters: {
      field: is_won
      value: "Yes"
    }
    value_format_name: custom_amount_value_format
    drill_fields: [opp_drill_set_closed*]
    description: "Includes Renewals/Upsells"
  }

  measure: total_new_closed_won_amount_qtd {
    label: "Closed Won {{ amount_display._sql }} QTD"
    type: sum
    sql: ${amount}   ;;
    filters: {
      field: is_won
      value: "Yes"
    }
    filters: {
      field: close_date
      value: "this quarter"
    }
    filters: {
      field: is_new_business
      value: "yes"
    }
    value_format_name: custom_amount_value_format
    drill_fields: [opp_drill_set_closed*]
    description: "New Business Won QTD"
  }

  measure: total_closed_won_amount_ytd {
    label: "Closed Won {{ amount_display._sql }} YTD"
    type: sum
    sql: ${amount} ;;
    filters: {
      field: is_won
      value: "Yes"
    }
    filters: {
      field: close_date
      value: "this year"
    }
    value_format_name: custom_amount_value_format
    drill_fields: [opp_drill_set_closed*]
  }

  measure: total_closed_won_new_business_amount {
    label: "Closed Won {{ amount_display._sql }}"
    type: sum
    sql: ${amount};;
    filters: {
      field: is_won
      value: "Yes"
    }
    filters: {
      field: is_new_business
      value: "yes"
    }
    value_format_name: custom_amount_value_format
    drill_fields: [opp_drill_set_closed*]
    description: "Only Includes New Business Opportunities"
  }

  measure: average_new_deal_size {
    type: average
    sql: ${amount} ;;
    filters: {
      field: is_new_business
      value: "yes"
    }
    value_format_name: custom_amount_value_format
    drill_fields: [opp_drill_set_closed*]
  }

  measure: average_renew_upsell_size {
    type: average
    sql: ${amount} ;;
    filters: {
      field: is_renewal_upsell
      value: "yes"
    }
    value_format_name: custom_amount_value_format
    drill_fields: [opp_drill_set_closed*]
  }

  measure: count { label: "Number of Opportunities" }

  measure: count_won {
    label: "Number of Opportunities Won"
    type: count

    filters: {
      field: is_won
      value: "Yes"
    }

    drill_fields: [opp_drill_set_closed*]
  }

  measure: average_days_open {
    type: average
    sql: ${days_open} ;;
    value_format_name: decimal_1
    drill_fields: [opp_drill_set_closed*]
  }

  measure: average_days_to_closed_won {
    type: average
    sql: ${days_to_closed_won} ;;
    value_format_name: decimal_1
    drill_fields: [opp_drill_set_closed*]
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
    drill_fields: [opp_drill_set_closed*]
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
    sql: ${count_won} / NULLIF(${count_closed}, 0) ;;
    value_format_name: percent_2
  }

  measure: open_percentage {
    type: number
    sql: ${count_open} / NULLIF(${count}, 0) ;;
    value_format_name: percent_2
  }

  measure: count_new_business_won {
    label: "Number of New-Business Opportunities Won"
    type: count

    filters: {
      field: is_won
      value: "Yes"
    }

    filters: {
      field: is_new_business
      value: "yes"
    }

    drill_fields: [opp_drill_set_closed*]
  }

  measure: count_new_business_open {
    label: "Number of New-Business Opportunities Open"
    type: count

    filters: {
      field: is_pipeline
      value: "Yes"
    }

    filters: {
      field: is_new_business
      value: "yes"
    }

    drill_fields: [opp_drill_set_closed*]
  }

  measure: count_new_business_won_ytd {
    label: "Number of New-Business Opportunities Won YTD"
    type: count
    filters: {
      field: is_won
      value: "Yes"
    }
    filters: {
      field: is_new_business
      value: "yes"
    }
    filters: {
      field: close_date
      value: "this year"
    }
    drill_fields: [opp_drill_set_closed*]
  }


  measure: count_new_business {
    label: "Number of New-Business Opportunities"
    type: count

    filters: {
      field: is_new_business
      value: "yes"
    }

    drill_fields: [opp_drill_set_closed_closed*]
  }



  measure: count_renewal_upsell_won {
    label: "Number of Renewal/Upsell Opportunities Won"
    type: count
    filters: {
      field: is_won
      value: "Yes"
    }
    filters: {
      field: is_renewal_upsell
      value: "yes"
    }
    drill_fields: [opp_drill_set_closed*]
  }

  measure: count_renewal_upsell_won_ytd {
    label: "Number of Renewal/Upsell Opportunities Won YTD"
    type: count
    filters: {
      field: is_won
      value: "Yes"
    }
    filters: {
      field: is_renewal_upsell
      value: "yes"
    }
    filters: {
      field: close_date
      value: "this year"
    }
    drill_fields: [opp_drill_set_closed*]
  }


  measure: count_renewal_upsell {
    label: "Number of Renewal/Upsell Opportunities"
    type: count
    filters: {
      field: is_renewal_upsell
      value: "yes"
    }
    drill_fields: [opp_drill_set_closed_closed*]
  }

  measure: total_closed_won_renewal_upsell_amount {
    type: sum
    sql: ${amount}   ;;
    filters: {
      field: is_won
      value: "Yes"
    }
    filters: {
      field: is_renewal_upsell
      value: "yes"
    }
    value_format_name: custom_amount_value_format
    drill_fields: [opp_drill_set_closed*]
  }

  measure: probable_wins {
    type: count
    filters: {
      field: is_probable_win
      value: "yes"
    }
    filters: {
      field: is_closed
      value: "no"
    }
    filters: {
      field: is_new_business
      value: "yes"
    }
  }

  measure: count_of_opportunities_that_need_updated_closed_date {
    type: count
    filters: {
      field: is_new_business
      value: "yes"
    }
    filters: {
      field: did_the_close_date_pass
      value: "yes"
    }
    filters: {
      field: is_closed
      value: "no"
    }
    drill_fields: [opp_drill_set_closed*,opportunity.stage_name]
  }

  measure: count_of_opportunities_with_next_steps {
    type: count
    filters: {
      field: is_new_business
      value: "yes"
    }
    filters: {
      field: is_closed
      value: "no"
    }
    filters: {
      field: opportunity.next_step
      value: "-NULL"
    }
    drill_fields: [opp_drill_set_open*, opportunity.stage_name, opportunity.next_step]
  }

  measure: count_of_opportunities_with_no_next_steps {
    type: count
    filters: {
      field: is_new_business
      value: "yes"
    }
    filters: {
      field: is_closed
      value: "no"
    }
    filters: {
      field: opportunity.next_step
      value: "NULL"
    }
    drill_fields: [opp_drill_set_open*, opportunity.stage_name, opportunity.next_step]
  }

  set: opp_drill_set_closed {
    fields: [opportunity.id, account.name, close_date, type, amount]
  }
  set: opp_drill_set_open {
    fields: [opportunity.id, account.name, created_date, type, amount]
  }
}








############Comparison PDTs############################################################################################################################################################
#
# view: sales_cycle_comparison {
#   derived_table: {
#     explore_source: opportunity {
#       filters: {field: opportunity_owner.is_sales_rep value: "Yes"}
#       filters: {field: is_ramped value: "Yes"}
#       column: owner_id {}
#       column: average_days_to_closed_won {}
#       derived_column: cycle_rank {sql: ROW_NUMBER() OVER( ORDER BY average_days_to_closed_won);;}
#       derived_column: cycle_bottom_third {sql: percentile_cont( coalesce(average_days_to_closed_won,0)*1.00, .3333 ) OVER () ;;}
#       derived_column: cycle_top_third {sql: percentile_cont( coalesce(average_days_to_closed_won,0)*1.00, .6666 ) OVER () ;;}
#     }
#   }
#   dimension: owner_id {type: string}
#   dimension: average_days_to_closed_won {type: number}
#   dimension: cycle_bottom_third {type: number}
#   dimension: cycle_top_third {type: number}
# #   dimension: cycle_rank {type: number}
#   dimension: cycle_cohort {
#       sql: CASE WHEN average_days_to_closed_won > cycle_top_third THEN 'Top Third'
#                 WHEN average_days_to_closed_won < cycle_top_third AND average_days_to_closed_won > cycle_bottom_third THEN 'Middle Third'
#                 WHEN average_days_to_closed_won < cycle_bottom_third THEN 'Bottom Third'
#             END
#       ;;}
# }
#
#
# view: new_deal_size_comparison {
# derived_table: {
#   explore_source: opportunity {
#     filters: {field: opportunity_owner.is_sales_rep value: "Yes"}
#     filters: {field: is_ramped value: "Yes"}
#     column: owner_id {}
#     column: average_new_deal_size {}
# #     derived_column: deal_size_rank {sql: ROW_NUMBER() OVER (ORDER BY average_new_deal_size desc);;}
#     derived_column: deal_size_bottom_third {sql: percentile_cont( coalesce(average_new_deal_size,0)*1.00, .3333 ) OVER () ;;}
#     derived_column: deal_size_top_third {sql: percentile_cont( coalesce(average_new_deal_size,0)*1.00, .6666 ) OVER () ;;}
#   }
# }
#   dimension: owner_id {type: string}
#   dimension: average_new_deal_size {type: number}
# #   dimension: deal_size_rank {type: number}
#   dimension: deal_size_top_third {type: number}
#   dimension: deal_size_bottom_third {type: number}
#   dimension: deal_size_cohort  {
#     sql: CASE WHEN average_new_deal_size > deal_size_top_third THEN 'Top Third'
#               WHEN average_new_deal_size < deal_size_top_third AND average_new_deal_size > deal_size_bottom_third THEN 'Middle Third'
#               WHEN average_new_deal_size < deal_size_bottom_third THEN 'Bottom Third'
#           END ;;
#   }
# }
#
# view: win_percentage_comparison {
#   derived_table: {
#     explore_source: opportunity {
#       filters: {field: opportunity_owner.is_sales_rep value: "Yes"}
#       column: owner_id {}
#       column: win_percentage {}
# #       derived_column: win_percentage_rank {sql: ROW_NUMBER() OVER (ORDER BY win_percentage desc);;}
#       derived_column: win_percentage_bottom_third {sql: percentile_cont( coalesce(win_percentage,0)*1.00, .3333 ) OVER () ;;}
#       derived_column: win_percentage_top_third {sql: percentile_cont( coalesce(win_percentage,0)*1.00, .6666 ) OVER () ;;}
#     }
#   }
#   dimension: owner_id {type: string}
#   dimension: win_percentage {type: number}
# #   dimension: win_percentage_rank {type: number}
#   dimension: win_percentage_bottom_third {type: number}
#   dimension: win_percentage_top_third {type: number}
#   dimension: win_percentage_cohort {
#     sql: CASE WHEN win_percentage > win_percentage_top_third THEN 'Top Third'
#               WHEN win_percentage < win_percentage_top_third AND win_percentage > win_percentage_bottom_third THEN 'Middle Third'
#               WHEN win_percentage < win_percentage_bottom_third THEN 'Bottom Third'
#           END
#       ;;}
# }

#
# view: pipeline_comparison {
#   derived_table: {
#     explore_source: opportunity_snapshots {
#       filters: {field: opportunity_owner.is_sales_rep value: "Yes"}
#       column: owner_id {}
#       column: total_pipeline {}
# #       derived_column: pipeline_rank {sql: ROW_NUMBER() OVER() ;;}
#       derived_column: pipeline_bottom_third {sql: percentile_cont( win_percentage*1.00, .3333 ) OVER () ;;}
#       derived_column: pipeline_top_third {sql: percentile_cont( win_percentage*1.00, .6666 ) OVER () ;;}
#     }
#   }
#   dimension: owner_id {type: string}
#   dimension: win_percentage {type: number}
# #   dimension: pipeline_rank {type: number}
#   dimension: pipeline_bottom_third {type: number}
#   dimension: pipeline_top_third {type: number}
#   dimension: pipeline_cohort {
#     sql: CASE WHEN average_pipeline > pipeline_top_third THEN 'Top Third'
#               WHEN average_pipeline < pipeline_top_third AND average_pipeline > pipeline_bottom_third THEN 'Middle Third'
#               WHEN average_pipeline < pipeline_bottom_third THEN 'Bottom Third'
#           END
#     ;;}
# }

# explore: comparison {
#   from: sales_cycle_comparison
# #   fields: []
#   join: new_deal_size_comparison {
#     sql_on: ${new_deal_size_comparison.owner_id} = ${comparison.owner_id} ;;
#     relationship: one_to_one
#   }
#   join: win_percentage_comparison {
#     sql_on: ${win_percentage_comparison.owner_id} = ${comparison.owner_id} ;;
#     relationship: one_to_one
#   }
# #   join: pipeline_comparison {
# #     sql_on: ${pipeline_comparison.owner_id} = ${comparison.owner_id} ;;
# #     relationship: one_to_one
# #   }
#   join: user_opp_test {
#     sql_on: ${comparison.owner_id} = ${user_opp_test.id} ;;
#     relationship: one_to_one
#   }
# }
# view: user_opp_test {
#   sql_table_name: salesforce.user ;;
#
#   dimension: name {}
#   dimension: id {primary_key:yes}
#   dimension: tenure_months {}
#   dimension: is_ramped {type: yesno sql: ${tenure_months}>3;;}
#
#   dimension_group: age  {
#     type: duration
#     datatype: date
#     sql_start: ${created_date};;
#     sql_end: current_date ;;
#   }
#
# }
#





  ### no ###

# view: rep_cohorts {
#   derived_table: {
#     explore_source: comparison {
#     column: owner_id {}
#     column: average_new_deal_size {field:new_deal_size_comparison.average_new_deal_size}
#     column: deal_size_top_third {field:new_deal_size_comparison.deal_size_top_third}
#     column: deal_size_bottom_third {field:new_deal_size_comparison.deal_size_top_third}
#     column: average_days_to_closed_won {field:comparison.average_days_to_closed_won}
#     column: cycle_top_third {field:comparison.cycle_top_third}
#     column: cycle_bottom_third {field:comparison.cycle_bottom_third}
#     column: win_percentage {field:win_percentage_comparison.win_percentage}
#     column: win_percentage_top_third {field:win_percentage_comparison.win_percentage_top_third}
#     column: win_percentage_bottom_third {field:win_percentage_comparison.win_percentage_bottom_third}
#     column: average_pipeline {}
#     column: pipeline_top_third {}
#     column: pipeline_bottom_third {}
#     derived_column: deal_size_cohort {
#       sql: CASE WHEN average_new_deal_size > deal_size_top_third THEN 'Top Third'
#                 WHEN average_new_deal_size < deal_size_top_third AND average_new_deal_size > deal_size_bottom_third THEN 'Middle Third'
#                 WHEN average_new_deal_size < deal_size_bottom_third THEN 'Bottom Third'
#             END
#       ;;}
#     derived_column: cycle_cohort {
#       sql: CASE WHEN average_days_to_closed_won > cycle_top_third THEN 'Top Third'
#                 WHEN average_days_to_closed_won < cycle_top_third AND average_days_to_closed_won > cycle_bottom_third THEN 'Middle Third'
#                 WHEN average_days_to_closed_won < cycle_bottom_third THEN 'Bottom Third'
#             END
#       ;;}
#     derived_column: win_percentage_cohort {
#       sql: CASE WHEN win_percentage > win_percentage_top_third THEN 'Top Third'
#                 WHEN win_percentage < win_percentage_top_third AND win_percentage > win_percentage_bottom_third THEN 'Middle Third'
#                 WHEN win_percentage < win_percentage_bottom_third THEN 'Bottom Third'
#             END
#       ;;}
#     derived_column: pipeline_cohort {
#       sql: CASE WHEN average_pipeline > pipeline_top_third THEN 'Top Third'
#                 WHEN average_pipeline < pipeline_top_third AND average_pipeline > pipeline_bottom_third THEN 'Middle Third'
#                 WHEN average_pipeline < pipeline_bottom_third THEN 'Bottom Third'
#             END
#       ;;}
#   }
# }
#   dimension: owner_id  {}
#   dimension: deals_size_cohort  {}
#   dimension: cycle_cohort  {}
#   dimension: win_percentage_cohort  {}
#   dimension: pipeline_cohort  {}

### testing
#   dimension: average_new_deal_size  {}
#   dimension: deal_size_top_third  {}
#   dimension: deal_size_bottom_third  {}
#   dimension: average_days_to_closed_won  {}
#
#
#
#
# }
#
# explore: rep_cohorts {}
