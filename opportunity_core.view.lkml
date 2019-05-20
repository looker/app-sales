view: opportunity_core {
  extension: required
  extends: [opportunity_adapter]

  # filters #
  filter: opportunity_select {
    type: string
    suggest_dimension: name
    #hidden: yes
  }

  # dimensions #

  dimension: opportunity_comparitor {
    type: string
    case: {
      when: {
        label: "Selected Opportunity"
        sql: {% condition opportunity_select %} ${name} {% endcondition %};;
      }
      else: "All Other Opportunities"
    }
    hidden: no
  }
  # dimensions #

  dimension_group: _fivetran_synced { hidden: yes }

  dimension: amount {
    label: "{{ amount_display._sql }}"
    sql: ${TABLE}.{{amount_config._sql}};;
    hidden: no
    value_format_name: custom_amount_value_format
  }

  dimension: matches_name_select {
    hidden: yes
    type:  yesno
    sql: {% condition opportunity_owner.name_select %} ${opportunity_owner.name} {% endcondition %}  ;;
  }

  dimension: is_lost {
    type: yesno
    sql: ${is_closed} AND NOT ${is_won} ;;
    group_label: "Status"
  }

  dimension: has_an_upcoming_first_meeting {
    type: yesno
    sql: ${first_meeting_raw} > CURRENT_TIMESTAMP();;
    hidden: yes
  }

  dimension_group: first_meeting  {
    type: time
    sql: ${first_meeting.first_meeting}  ;;
  }

  dimension: source  {
    type: string
    sql: ${TABLE}.lead_source ;;
  }

  dimension: probability_group {
    group_label: "Probability"
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

    dimension: deal_size_tier {
    type: string
    case: {
      when: {
        label: "$0 - $10K"
        sql: ${amount} < 10000 ;;
      }
      when: {
        label: "$10K - $50K"
        sql: ${amount} < 50000;;
      }
      when: {
        label: "$50K - $100K"
        sql: ${amount} < 100000 ;;
      }
      when: {
        label: "$100K - $500K"
        sql: ${amount} < 500000 ;;
      }
      when: {
        label: "$500K - $1M"
        sql: ${amount} < 1000000 ;;
      }
      when: {
        label: "Over $1M"
        sql: ${amount} > 1000000 ;;
      }
      else: "Amount Unspecified"
    }
  }

  dimension: custom_stage_name {
    label: "Stage Name"
    description: "Current stage of the opportunity"
    case: {
      when: {
        sql: ${stage_name} = '{{ stage_1._sql }}' ;;
        label: "{{ stage_1._sql }}"
      }
      when: {
        sql: ${stage_name} = '{{ stage_2._sql }}' ;;
        label: "{{ stage_2._sql }}"
      }
      when: {
        sql: ${stage_name} = '{{ stage_3._sql }}' ;;
        label: "{{ stage_3._sql }}"
      }
      when: {
        sql: ${stage_name} = '{{ stage_4._sql }}' ;;
        label: "{{ stage_4._sql }}"
      }
      when: {
        sql: ${stage_name} = '{{ stage_5._sql }}' ;;
        label: "{{ stage_5._sql }}"
      }
      when: {
        sql: ${stage_name} = '{{ stage_6._sql }}' ;;
        label: "{{ stage_6._sql }}"
      }
      when: {
        sql: ${stage_name} = '{{ stage_7._sql }}' ;;
        label: "{{ stage_7._sql }}"
      }
      when: {
        sql: ${stage_name} = 'Closed Lost' ;;
        label: "Closed Lost"
      }
      else: "Unknown"
    }
  }

  dimension: is_probable_win {
    type: yesno
    sql: ${probability} >= 50 ;;
    group_label: "Probability"
  }

  dimension: id_url {
    sql: ${TABLE}.id ;;
    html: [<a href="https://{{ salesforce_domain_config._sql }}/{{ value }}">Open in SFDC</a>] ;;
    hidden: yes
  }

  dimension: logo64 {
    sql: ${account.domain} ;;
    html: <a href="https://na9.salesforce.com/{{ id._value }}" target="_new">
      <img src="https://logo.clearbit.com/{{ value }}" height=64 width=64></a>
      ;;
  }

  dimension: logo {
    sql: ${account.domain} ;;
    html: <a href="https://{{ value }}" target="_new">
      <img src="https://logo.clearbit.com/{{ value }}" height=128 width=128></a>
      ;;
  }

  dimension: logo32 {
    hidden: yes
    sql: ${account.domain} ;;
    html: <a href="https://na9.salesforce.com/{{ id._value }}" target="_new">
      <img src="https://logo.clearbit.com/{{ value }}" height=32 width=32></a>
      ;;
  }

  dimension: id {
    hidden: no
  }

  # BQ Specific
# Needed to create a dimension for current time so that current timestamp would convert timezones consistently with other Looker date fields

  dimension_group: current {
    type: time
    datatype: timestamp
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year,
      fiscal_month_num,
      fiscal_quarter,
      fiscal_quarter_of_year,
      fiscal_year
    ]
    hidden: no
    sql: CURRENT_TIMESTAMP() ;;
  }

  dimension: previous_fiscal_quarter {
    type: date_fiscal_quarter
    datatype: date
    sql:  DATE_ADD(${current_date}, INTERVAL -1 QUARTER) ;;
    hidden: yes
  }

  dimension: this_fiscal_quarter_last_year {
    type: date_fiscal_quarter
    datatype: date
    sql:  DATE_ADD(${current_date}, INTERVAL -1 YEAR) ;;
    hidden: yes
  }


  dimension: did_the_close_date_pass {
    type: yesno
    sql: ${current_raw} > ${close_raw} ;;
    group_label: "Status"
  }

# BQ Specific
# This dimension is used as the pivoted dimension on the Sales Leadership Quarter Overview's "Quota Attainment" tile
  dimension: close_quarter_pivot {
    type: string

    case: {
      when: {
        sql: ${close_fiscal_quarter} = ${current_fiscal_quarter} ;;
        label: "This Quarter"
      }
      when: {
        sql: ${close_fiscal_quarter} = ${previous_fiscal_quarter} ;;
        label: "Last Quarter"
      }
      when: {
        sql: ${close_fiscal_quarter} = ${this_fiscal_quarter_last_year} ;;
        label: "Last Year"
      }
    }
  }

  # Used in the day_of_quarter
  dimension: fiscal_month_offset {
    type: number
    sql: 0 ;;
    hidden: yes
  }

  # BQ Specific
  # When the user provides a fiscal month offset of >3, wackiness ensues. Therefore we need to modulo to offset before using it in our calculations
  dimension: fiscal_month_offset_modulo {
    type: number
    sql: MOD(${fiscal_month_offset},3) ;;
    hidden: yes
  }

  # BQ Specific
  # When the user provides a fiscal month offset of >3, wackiness ensues. Therefore we need to modulo to offset before using it in our calculations
  dimension: fiscal_month_offset_divide {
    type: number
    sql: DIV(${fiscal_month_offset},3) ;;
    hidden: yes
  }

  # BQ Specific
  # Current day number of fiscal quarter
  dimension: day_of_fiscal_quarter {
    description: "The day of the fiscal quarter the opportunity was closed in."
    group_label: "Close Date"
    type: number
    sql: DATE_DIFF(${close_date}, DATE_ADD(DATE_ADD(CAST(CONCAT(${close_fiscal_quarter}, '-01') as date), INTERVAL ${fiscal_month_offset_modulo} MONTH), INTERVAL ${fiscal_month_offset_divide} QUARTER), day) + 1;;
  }

  dimension: current_day_of_fiscal_quarter {
    group_label: "Current Date"
    type: number
    sql: DATE_DIFF(${current_date}, DATE_ADD(DATE_ADD(CAST(CONCAT(${current_fiscal_quarter}, '-01') as date), INTERVAL ${fiscal_month_offset_modulo} MONTH), INTERVAL ${fiscal_month_offset_divide} QUARTER), day) + 1;;
    }

  # BQ Specific
  # Used specifically on "of Quota" tile as the comparison value
  dimension: beginning_of_this_fiscal_quarter {
    type: string
    sql: DATE_ADD(DATE_ADD(CAST(CONCAT(${current_fiscal_quarter}, '-01') as date), INTERVAL ${fiscal_month_offset_modulo} MONTH), INTERVAL ${fiscal_month_offset_divide} QUARTER) ;;
  }

  dimension: beginning_of_next_fiscal_quarter {
    type: string
    sql: DATE_ADD(DATE_ADD(DATE_ADD(CAST(CONCAT(${current_fiscal_quarter}, '-01') as date), INTERVAL ${fiscal_month_offset_modulo} MONTH), INTERVAL 1 QUARTER), INTERVAL ${fiscal_month_offset_divide} QUARTER) ;;
  }

  dimension: percent_of_quarter_reached {
    type: number
    sql: DATE_DIFF(${current_date}, ${beginning_of_this_fiscal_quarter}, DAY)/DATE_DIFF(${beginning_of_next_fiscal_quarter}, ${beginning_of_this_fiscal_quarter}, DAY) ;;
    value_format_name: percent_0
  }


  # BQ Specific
  dimension: days_open {
    description: "Number of days from opportunity creation to close. If not yet closed, this uses today's date."
    type: number
    sql: DATE_DIFF(coalesce(${close_date}, current_date), ${created_date}, DAY) ;;
  }

  # Used primarily for the "Opps slated to close in the next X days" tile
  dimension: close_date_custom {
    type: date
    sql: ${TABLE}.close_date ;;
    hidden: yes
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

  dimension: is_in_stage_1 {
    type: yesno
    sql:${stage_name} = '{{stage_1._sql}}' ;;
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
    hidden:  yes
  }

  dimension: created_to_closed_in_60 {
    hidden: yes
    type: yesno
    sql: ${days_open} <=60 AND ${is_closed} AND ${is_won} ;;
    drill_fields: [opp_drill_set_closed*]
  }

  dimension_group: system_modstamp { hidden: yes }



  #########################################################################################################
  ## These two fields give the percentage of current opportunities value compared to the overall average.##
  ## They are not currently used                                                                         ##
  #########################################################################################################
#
#   dimension: percent_of_average_new_deal_size {
#     type: number
#     sql: ${amount} / ${aggregate_comparison.aggregate_average_new_deal_size} ;;
#     hidden: yes
#   }
#
#   dimension: percent_of_average_sales_cycle {
#     type: number
#     sql: ${days_to_closed_won} / ${aggregate_comparison.aggregate_average_days_to_closed_won} ;;
#     hidden: yes
#   }

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
    hidden: yes
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
    hidden: yes
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
    hidden: yes
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
    description: "All open Pipeline Opps"
  }

  # May want to revisit the name here since we're using "is_included_in_quota" rather than "is_new_business"
  measure: total_pipeline_new_business_amount {
    label: "Pipeline {{ amount_display._sql }}"
    type: sum
    sql: ${amount} ;;
    hidden: yes
    filters: {
      field: is_closed
      value: "No"
    }
    filters: {
      field: is_pipeline
      value: "Yes"
    }
    filters: {
      field: is_included_in_quota
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
    hidden: yes
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
    hidden: yes
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
    hidden: yes
    filters: {
      field: is_won
      value: "Yes"
    }
    value_format_name: custom_amount_value_format
    drill_fields: [opp_drill_set_closed*]
    description: "Includes Renewals/Upsells"
  }

  # May want to revisit the name here since we're using "is_included_in_quota" rather than "is_new_business"
  measure: total_new_closed_won_amount_qtd {
    label: "Closed Won {{ amount_display._sql }} QTD - Quota"
    type: sum
    sql: ${amount}   ;;
    hidden: yes
    filters: {
      field: is_won
      value: "Yes"
    }
    filters: {
      field: close_date
      value: "this fiscal quarter"
    }
    filters: {
      field: is_included_in_quota
      value: "yes"
    }
    value_format_name: custom_amount_value_format
    drill_fields: [opp_drill_set_closed*]
    description: "New Business Won QTD"
  }

  measure: total_closed_won_amount_ytd {
    label: "Closed Won {{ amount_display._sql }} YTD  - Quota"
    description: "Total amount counted toward quota"
    type: sum
    sql: ${amount} ;;
    hidden: yes
    filters: {
      field: is_won
      value: "Yes"
    }
    filters: {
      field: close_date
      value: "this year"
    }
    filters: {
      field: is_included_in_quota
      value: "yes"
    }
    value_format_name: custom_amount_value_format
    drill_fields: [opp_drill_set_closed*]
  }

  # May want to revisit the name here since we're using "is_included_in_quota" rather than "is_new_business"
  measure: total_closed_won_new_business_amount {
    label: "Closed Won {{ amount_display._sql }}"
    type: sum
    sql: ${amount};;
    hidden: yes
    filters: {
      field: is_won
      value: "yes"
    }
    filters: {
      field: is_included_in_quota
      value: "yes"
    }
    value_format_name: custom_amount_value_format
    drill_fields: [opp_drill_set_closed*]
    description: "Only Includes Quota Contributing Opportunities"
  }

  measure: average_new_deal_size {
    type: average
    sql: ${amount} ;;
    hidden: yes
    filters: {
      field: is_included_in_quota
      value: "yes"
    }
    value_format_name: custom_amount_value_format
    drill_fields: [opp_drill_set_closed*]
  }

  measure: average_new_deal_size_won {
    type: average
    sql: ${amount} ;;
    hidden: no
    filters: {
      field: is_included_in_quota
      value: "yes"
    }
    filters: {
      field: is_won
      value: "yes"
    }
    value_format_name: custom_amount_value_format
    drill_fields: [opp_drill_set_closed*]
  }

  measure: average_renew_upsell_size {
    type: average
    sql: ${amount} ;;
    hidden: yes
    filters: {
      field: is_renewal_upsell
      value: "yes"
    }
    value_format_name: custom_amount_value_format
    drill_fields: [opp_drill_set_closed*]
  }

  measure: count {
    label: "Number of Opportunities"
  }

  measure: count_won {
    label: "Number of Opportunities Won"
    type: count
    hidden: yes
    filters: {
      field: is_won
      value: "Yes"
    }
    drill_fields: [opp_drill_set_closed*]
  }

  measure: count_won_ytd {
    label: "Number of Opportunities Won - YTD"
    type: count
    hidden: yes
    filters: {
      field: is_won
      value: "Yes"
    }
    filters: {
      field: close_date
      value: "this year"
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
    value_format_name: decimal_0
    drill_fields: [opp_drill_set_closed*]
  }
  ## BQ documentation on AVERAGE function:
  # If a row contains a missing or null value, it is not factored into the calculation.
  # If the entire column contains no values, the function returns a null value.

  measure: count_closed {
    label: "Number of Closed Opportunities"
    type: count
    group_label: "Counts"
    hidden: yes
    filters: {
      field: is_closed
      value: "Yes"
    }
    drill_fields: [opp_drill_set_closed*]
  }

  measure: count_open {
    label: "Number of Open Opportunities"
    type: count
    hidden: yes
    group_label: "Counts"
    filters: {
      field: is_closed
      value: "No"
    }
  }

  measure: count_lost {
    label: "Number of Lost Opportunities"
    type: count
    hidden: yes
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

  # May want to revisit the name here since we're using "is_included_in_quota" rather than "is_new_business"
  measure: total_closed_lost_amount {
    label: "Closed Lost {{ amount_display._sql }}"
    type: average
    hidden: yes
    sql: ${amount} ;;
    filters: {
      field: is_included_in_quota
      value: "yes"
    }
    value_format_name: custom_amount_value_format
    drill_fields: [opp_drill_set_closed*]
    description: "Only Includes New Business Opportunities"
  }

  measure: win_percentage {
    type: number
    sql: ${count_new_business_won} / NULLIF(${count_new_business_closed},0) ;;
    value_format_name: percent_1
  }

  measure: open_percentage {
    type: number
    sql: ${count_open} / NULLIF(${count}, 0) ;;
    value_format_name: percent_1
  }

  measure: win_to_loss_ratio {
    type: number
    sql: ${count_new_business_won}/IF(${count_new_business_lost} = 0, 1, ${count_new_business_lost}) ;;
    value_format_name: decimal_2
    drill_fields: [opp_drill_set_closed*]
  }

  measure: percent_of_quota_reached {
    type: number
    sql: ${total_closed_won_new_business_amount} / ${aggregate_quota.quarterly_aggregate_quota_measure} ;;
    value_format_name: percent_0
    drill_fields: [opp_drill_set_closed*]
  }

  measure: count_new_business_won {
    label: "Number of New-Business Opportunities Won"
    type: count
    hidden: yes
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

  measure: count_new_business_lost {
    label: "Number of New-Business Opportunities Lost"
    type: count
    hidden: yes
    filters: {
      field: is_won
      value: "No"
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
    hidden: yes
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

  measure: count_new_business_closed {
    label: "Number of New-Business Opportunities Closed"
    type: count
    hidden: yes
    filters: {
      field: is_closed
      value: "Yes"
    }

    filters: {
      field: is_new_business
      value: "Yes"
    }

    drill_fields: [opp_drill_set_closed*]
  }

  measure: count_new_business_won_ytd {
    label: "Number of New-Business Opportunities Won YTD"
    type: count
    hidden: yes
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
    hidden: yes
    filters: {
      field: is_new_business
      value: "yes"
    }
    drill_fields: [opp_drill_set_closed*]
  }


    measure: count_renewal_upsell_won {
      label: "Number of Renewal/Upsell Opportunities Won"
      type: count
      hidden: yes
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
      hidden: yes
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
      hidden: yes
      filters: {
        field: is_renewal_upsell
        value: "yes"
      }
      drill_fields: [opp_drill_set_closed*]
    }

    measure: total_closed_won_renewal_upsell_amount {
      type: sum
      sql: ${amount}   ;;
      hidden: yes
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
      hidden: yes
      filters: {
        field: is_probable_win
        value: "yes"
      }
      filters: {
        field: is_closed
        value: "no"
      }
      filters: {
        field: is_included_in_quota
        value: "yes"
      }
    }

    measure: number_of_opportunities_that_need_updated_closed_date {
      label: "Number of Opportunities That Need Updated Closed Date"
      type: count
      hidden: yes
      filters: {
        field: is_included_in_quota
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
      drill_fields: [opp_drill_set_closed*, opportunity.custom_stage_name]
    }

    measure: number_of_opportunities_with_next_steps {
      type: count
      hidden: yes
      filters: {
        field: is_included_in_quota
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
      drill_fields: [opp_drill_set_open*, opportunity.custom_stage_name, opportunity.next_step]
    }

  measure: number_of_opportunities_requiring_action {
    label: "Number of Opportunities That Require Action"
    type: count
    hidden: yes
    filters: {
      field: requires_action
      value: "yes"
    }

    drill_fields: [opp_drill_set_open*]
  }


  measure: number_of_upcoming_opportunities {
    label: "Number of Upcoming Opportunities"
    type: count
    hidden: yes
    filters: {
      field: has_an_upcoming_first_meeting
      value: "yes"
    }

    filters: {
      field: is_in_stage_1
      value: "yes"
    }

    drill_fields: [opp_drill_set_open*]

  }

    measure: number_of_opportunities_with_no_next_steps {
      type: count
      hidden: yes
      filters: {
        field: is_included_in_quota
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
      drill_fields: [opp_drill_set_open*, opportunity.custom_stage_name, opportunity.next_step]
    }

    measure: max_booking_amount {
      type: max
      sql: ${amount} ;;
      hidden:  yes
      value_format_name: custom_amount_value_format
      drill_fields: [opp_drill_set_open*, opportunity.custom_stage_name, opportunity.next_step]
    }

    # Referenced in the "account_facts_start_date" NDT that calculates a customer's earliest start date
    measure: earliest_close_date {
      type: date
      hidden: yes
      sql: MIN(${close_raw}) ;;
    }


  set: opp_drill_set_closed {
    fields: [opportunity.id, opportunity.name, opportunity_owner.name, account.name, close_date, type, days_as_opportunity, amount]
  }
  set: opp_drill_set_open {
    fields: [opportunity.id, opportunity.name, opportunity_owner.name, account.name, created_date, type, days_as_opportunity, amount]
  }
  set: opportunity_exclusion_set {
    fields: [percent_of_average_new_deal_size, percent_of_average_sales_cycle,logo64,logo,matches_name_select,first_meeting,percent_of_quota_reached]
  }
}
