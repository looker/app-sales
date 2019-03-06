view: opportunity_history_core {
  extends: [opportunity_history_adapter]
  #extension: required

  dimension_group: _fivetran_synced { hidden: yes }
  dimension: created_by_id { hidden: yes }
  dimension_group: created { label: "Snapshot" }
  dimension: is_deleted { hidden: yes }
  dimension_group: system_modstamp { hidden: yes }

  dimension: expected_revenue { hidden: yes }

  measure: max_created_date {
    type: date
    sql: MAX(${created_date}) ;;
  }
}

explore: opportunity_history_core {
  hidden: yes
}

explore: opportunity_stage_history {
  hidden: yes
}

view: opportunity_stage_history {
  derived_table: {
    explore_source: opportunity_history_core {
      column: opportunity_id {}
      column: stage_name {}
      column: max_created_date {}
      column: expected_revenue {}
      derived_column: days_in_current_stage {
        sql:  DATE_DIFF(DATE(max_created_date), DATE(LAG(max_created_date) OVER (PARTITION BY
          opportunity_id ORDER BY max_created_date ASC)), day);;
      }
      derived_column: last_stage {
        sql: LAG(stage_name) OVER (PARTITION BY opportunity_id ORDER BY
          max_created_date ASC);;
      }
    }
  }
  dimension: id {
    hidden: yes
    sql: ${opportunity_id} ||  ;;
  }
  dimension: opportunity_id {
    type: string
  }
  dimension: stage_name {
    type: string
    hidden: no
    order_by_field: opportunity.custom_stage_name
  }
  dimension: last_stage {
    type: string
    hidden: no
  }
  dimension: days_in_current_stage {
    type: number
  }

  dimension: expected_revenue {
    type: number
  }

  dimension: max_created_date {
    label: "Date"
    type:  date
    hidden: no
  }

  dimension: stage {
    type: string
    sql: CASE
          WHEN ${stage_name} = 'Qualify' AND ${last_stage} = 'Validate' THEN  'Stage 1'
          WHEN ${stage_name} = 'Develop' AND ${last_stage} = 'Qualify' THEN  'Stage 2'
          WHEN ${stage_name} = 'Develop Positive' AND ${last_stage} = 'Develop' THEN  'Stage 3'
          WHEN ${stage_name} = 'Negotiate' AND ${last_stage} = 'Develop Positive' THEN  'Stage 4'
          WHEN ${stage_name} = 'Sales Submitted' AND ${last_stage} = 'Negotiate' THEN  'Stage 5'
          WHEN ${stage_name} = 'Closed Won' AND ${last_stage} = 'Sales Submitted' THEN  'Stage 6'
          ELSE null
          END
          ;;
  }

  measure: avg_days_stage_1_to_2 {
    description: "Avg duration of opportunities moving from Stage 1 to at Stage 2"
    type: average
    group_label: "Days In Stage"
    sql: ${days_in_current_stage} ;;
    filters: {
      field: stage_name
      value: "Qualify"
    }
    filters: {
      field: last_stage
      value: "Validate"
    }
    value_format: "0.00"
  }

  measure: avg_days_stage_2_to_3 {
    description: "Avg duration of opportunities moving from Stage 2 to at Stage 3"
    type: average
    group_label: "Days In Stage"
    sql: ${days_in_current_stage} ;;
    filters: {
      field: stage_name
      value: "Develop"
    }
    filters: {
      field: last_stage
      value: "Qualify"
    }
    value_format: "0.00"
  }

  measure: avg_days_stage_3_to_4 {
    description: "Avg duration of opportunities moving from Stage 3 to at Stage 4"
    type: average
    group_label: "Days In Stage"
    sql: ${days_in_current_stage} ;;
    filters: {
      field: stage_name
      value: "Develop Positive"
    }
    filters: {
      field: last_stage
      value: "Develop"
    }
    value_format: "0.00"
  }

  measure: avg_days_stage_4_to_5 {
    description: "Avg duration of opportunities moving from Stage 4 to at Stage 5"
    type: average
    group_label: "Days In Stage"
    sql: ${days_in_current_stage} ;;
    filters: {
      field: stage_name
      value: "Negotiate"
    }
    filters: {
      field: last_stage
      value: "Develop Positive"
    }
    value_format: "0.00"
  }

  measure: avg_days_stage_5_to_6 {
    description: "Avg duration of opportunities moving from Stage 5 to at Stage 6"
    type: average
    group_label: "Days In Stage"
    sql: ${days_in_current_stage} ;;
    filters: {
      field: stage_name
      value: "Sales Submitted"
    }
    filters: {
      field: last_stage
      value: "Negotiate"
    }
    value_format: "0.00"
  }

  measure: avg_days_stage_6_to_7 {
    description: "Avg duration of opportunities moving from Stage 6 to at Stage 7"
    type: average
    group_label: "Days In Stage"
    sql: ${days_in_current_stage} ;;
    filters: {
      field: stage_name
      value: "Closed Won"
    }
    filters: {
      field: last_stage
      value: "Sales Submitted"
    }
    value_format: "0.00"
  }

  measure: avg_days_in_stage {
    type: average
    description: "Avg duration of opportunities moving between stages"
    sql: CASE
          WHEN ${stage} = 'Stage 1' THEN (CASE WHEN (opportunity_stage_history.stage_name = 'Qualify') AND (opportunity_stage_history.last_stage = 'Validate') THEN opportunity_stage_history.days_in_current_stage  ELSE NULL END)
          WHEN ${stage} = 'Stage 2' THEN (CASE WHEN (opportunity_stage_history.stage_name = 'Develop') AND (opportunity_stage_history.last_stage = 'Qualify') THEN opportunity_stage_history.days_in_current_stage  ELSE NULL END)
          WHEN ${stage} = 'Stage 3' THEN (CASE WHEN (opportunity_stage_history.stage_name = 'Develop Positive') AND (opportunity_stage_history.last_stage = 'Develop') THEN opportunity_stage_history.days_in_current_stage  ELSE NULL END)
          WHEN ${stage} = 'Stage 4' THEN (CASE WHEN (opportunity_stage_history.stage_name = 'Negotiate') AND (opportunity_stage_history.last_stage = 'Develop Positive') THEN opportunity_stage_history.days_in_current_stage  ELSE NULL END)
          WHEN ${stage} = 'Stage 5' THEN (CASE WHEN (opportunity_stage_history.stage_name = 'Sales Submitted') AND (opportunity_stage_history.last_stage = 'Negotiate') THEN opportunity_stage_history.days_in_current_stage  ELSE NULL END)
          WHEN ${stage} = 'Stage 6' THEN (CASE WHEN (opportunity_stage_history.stage_name = 'Closed Won') AND (opportunity_stage_history.last_stage = 'Sales Submitted') THEN opportunity_stage_history.days_in_current_stage  ELSE NULL END)
          ELSE null
          END
      ;;
    value_format: "0.00"
    group_label: "Days In Stage"
  }

  measure: opps_in_each_stage {
    type: count
    sql: ${opportunity_id} ;;
    hidden: yes
  }

  dimension: stages_for_conversion_rate {
    type:  string
    sql: 'Stage 1-2';;
  }

  measure: stage_conversion_rates {
    type: number
    description: "Avg duration of opportunities moving between stages"
    sql: CASE
          WHEN ${stage} = 'Stage 1' THEN ${conv_rate_stage_1}
          WHEN ${stage} = 'Stage 2' THEN ${conv_rate_stage_2}
          WHEN ${stage} = 'Stage 3' THEN ${conv_rate_stage_3}
          WHEN ${stage} = 'Stage 4' THEN ${conv_rate_stage_4}
          WHEN ${stage} = 'Stage 5' THEN ${conv_rate_stage_5}
          ELSE NULL
          END
      ;;
    value_format_name: percent_1
  }

  measure: conv_rate_stage_1 {
    label: "Stage 1 Conv Rate"
    group_label: "Conversion Rates"
    type: number
    sql: ${opps_in_stage_1_2} / NULLIF(${opps_in_stage_1},0);;
    value_format_name: percent_1
  }

  measure: conv_rate_stage_2 {
    label: "Stage 2 Conv Rate"
    group_label: "Conversion Rates"
    type: number
    sql: ${opps_in_stage_2_3} / NULLIF(${opps_in_stage_1_2},0);;
    value_format_name: percent_1
  }

  measure: conv_rate_stage_3 {
    label: "Stage 3 Conv Rate"
    group_label: "Conversion Rates"
    type: number
    sql: ${opps_in_stage_3_4} / NULLIF(${opps_in_stage_2_3},0);;
    value_format_name: percent_1
  }

  measure: conv_rate_stage_4 {
    label: "Stage 4 Conv Rate"
    group_label: "Conversion Rates"
    type: number
    sql: ${opps_in_stage_4_5} / NULLIF(${opps_in_stage_3_4},0);;
    value_format_name: percent_1
  }

  measure: conv_rate_stage_5 {
    label: "Stage 5 Conv Rate"
    group_label: "Conversion Rates"
    type: number
    sql: ${opps_in_stage_5_6} / NULLIF(${opps_in_stage_4_5},0);;
    value_format_name: percent_1
  }

  measure: opps_in_stage_1_2 {
    hidden: yes
    type: count
    sql: ${opportunity_id} ;;
    filters: {
      field: stage_name
      value: "Qualify"
    }
    filters: {
      field: last_stage
      value: "Validate"
    }
  }

  measure: opps_in_stage_1 {
    hidden: yes
    type: count
    sql: ${opportunity_id} ;;
    filters: {
      field: stage_name
      value: "Validate"
    }
  }

  measure: opps_in_stage_2_3 {
    hidden: yes
    type: count
    sql: ${opportunity_id} ;;
    filters: {
      field: stage_name
      value: "Develop"
    }
    filters: {
      field: last_stage
      value: "Qualify"
    }
  }

  measure: opps_in_stage_3_4 {
    hidden: yes
    type: count
    sql: ${opportunity_id} ;;
    filters: {
      field: stage_name
      value: "Develop Positive"
    }
    filters: {
      field: last_stage
      value: "Develop"
    }
  }


  measure: opps_in_stage_4_5 {
    hidden: yes
    type: count
    sql: ${opportunity_id} ;;
    filters: {
      field: stage_name
      value: "Negotiate"
    }
    filters: {
      field: last_stage
      value: "Develop Positive"
    }
  }

  measure: opps_in_stage_5_6 {
    hidden: yes
    type: count
    sql: ${opportunity_id} ;;
    filters: {
      field: stage_name
      value: "Sales Submitted"
    }
    filters: {
      field: last_stage
      value: "Negotiate"
    }
  }

  measure: avg_revenue_in_stage {
    type: average
    description: "Avg revenue of opportunities moving between stages"
    sql: CASE
          WHEN ${stage} = 'Stage 1' THEN (CASE WHEN (opportunity_stage_history.stage_name = 'Qualify') AND (opportunity_stage_history.last_stage = 'Validate') THEN opportunity_stage_history.expected_revenue  ELSE NULL END)
          WHEN ${stage} = 'Stage 2' THEN (CASE WHEN (opportunity_stage_history.stage_name = 'Develop') AND (opportunity_stage_history.last_stage = 'Qualify') THEN opportunity_stage_history.expected_revenue  ELSE NULL END)
          WHEN ${stage} = 'Stage 3' THEN (CASE WHEN (opportunity_stage_history.stage_name = 'Develop Positive') AND (opportunity_stage_history.last_stage = 'Develop') THEN opportunity_stage_history.expected_revenue  ELSE NULL END)
          WHEN ${stage} = 'Stage 4' THEN (CASE WHEN (opportunity_stage_history.stage_name = 'Negotiate') AND (opportunity_stage_history.last_stage = 'Develop Positive') THEN opportunity_stage_history.expected_revenue  ELSE NULL END)
          WHEN ${stage} = 'Stage 5' THEN (CASE WHEN (opportunity_stage_history.stage_name = 'Sales Submitted') AND (opportunity_stage_history.last_stage = 'Negotiate') THEN opportunity_stage_history.expected_revenue  ELSE NULL END)
          WHEN ${stage} = 'Stage 6' THEN (CASE WHEN (opportunity_stage_history.stage_name = 'Closed Won') AND (opportunity_stage_history.last_stage = 'Sales Submitted') THEN opportunity_stage_history.expected_revenue  ELSE NULL END)
          ELSE null
          END
      ;;
    value_format_name: usd
  }

}
