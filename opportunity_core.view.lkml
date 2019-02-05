view: opportunity_core {
  extension: required
  extends: [opportunity_adapter]
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

  dimension: is_probable_win {
    type: yesno
    sql: ${probability} >= 75 ;;
  }

  dimension_group: created {
    #X# Invalid LookML inside "dimension": {"timeframes":["date","week","month","raw"]}
  }

  dimension_group: close {
    #X# Invalid LookML inside "dimension": {"timeframes":["date","week","month","raw"]}
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
    drill_fields: [opp_drill_set_closed*]
  }

  dimension_group: system_modstamp { hidden: yes }

  # measures #

  measure: total_revenue {
    type: sum
    sql: ${amount} ;;
    drill_fields: [opp_drill_set_closed*]
    value_format: "[>=1000000]$0.0,,\"M\";[>=1000]$0.0,\"K\";$0"

  }

  measure: average_revenue_won {
    label: "Average Revenue (Closed/Won)"
    type: average
    sql: ${amount} ;;
    filters: {
      field: is_won
      value: "Yes"
    }
    value_format: "[>=1000000]$0.0,,\"M\";[>=1000]$0.0,\"K\";$0"
  }

  measure: average_revenue_lost {
    label: "Average Revenue (Closed/Lost)"
    type: average
    sql: ${amount} ;;
    filters: {
      field: is_lost
      value: "Yes"
    }
    drill_fields: [opp_drill_set_closed*]
    value_format: "[>=1000000]$0.0,,\"M\";[>=1000]$0.0,\"K\";$0"
  }

  measure: total_pipeline_revenue {
    type: sum
    sql: ${amount} ;;

    filters: {
      field: is_closed
      value: "No"
    }
    value_format: "$#,##0"
    drill_fields: [opp_drill_set_closed*]
  }

  measure: total_pipeline_revenue_ytd {
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
    value_format: "[>=1000000]$0.00,,\"M\";[>=1000]$0.00,\"K\";$0.00"
    drill_fields: [opp_drill_set_closed*]
  }

  measure: total_closed_won_revenue {
    type: sum
    sql: ${amount}   ;;
    filters: {
      field: is_won
      value: "Yes"
    }
    value_format: "[>=1000000]$0.00,,\"M\";[>=1000]$0.00,\"K\";$0.00"
    drill_fields: [opp_drill_set_closed*]
    description: "Includes Renewals/Upsells"
  }

  measure: total_closed_won_revenue_ytd {
    type: sum
    sql: ${amount}   ;;
    filters: {
      field: is_won
      value: "Yes"
    }
    filters: {
      field: close_date
      value: "this year"
    }
    value_format: "[>=1000000]$0.00,,\"M\";[>=1000]$0.00,\"K\";$0.00"
    drill_fields: [opp_drill_set_closed*]
  }

  measure: total_closed_won_new_business_revenue {
    type: sum
    sql: ${amount}   ;;
    filters: {
      field: is_won
      value: "Yes"
    }
    filters: {
      field: opportunity.type
      value: "\"New Customer\", \"New Business\""
    }
    value_format: "[>=1000000]$0.00,,\"M\";[>=1000]$0.00,\"K\";$0.00"
    drill_fields: [opp_drill_set_closed*]
  }

  measure: average_deal_size {
    type: average
    sql: ${amount} ;;
    value_format: "[>=1000000]$0.00,,\"M\";[>=1000]$0.00,\"K\";$0.00"
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
      value: "\"New Customer\", \"New Business\""
    }

    drill_fields: [opp_drill_set_closed*]
  }

  measure: count_new_business_won_ytd {
    label: "Number of New-Business Opportunities Won"
    type: count

    filters: {
      field: is_won
      value: "Yes"
    }
    filters: {
      field: opportunity.type
      value: "\"New Customer\", \"New Business\""
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
      field: opportunity.type
      value: "\"New Customer\", \"New Business\""
    }

    drill_fields: [opp_drill_set_closed_closed*]
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
      field: opportunity.type
      value: "\"New Customer\", \"New Business\""
    }
  }

  set: opp_drill_set_closed {
    fields: [opportunity.id, account.name, close_date, type, amount]
  }
  set: opp_drill_set_open {
    fields: [opportunity.id, account.name, created_date, type, amount]
  }
}
