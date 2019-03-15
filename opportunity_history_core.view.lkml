view: opportunity_history_core {
  extends: [opportunity_history_adapter]
  #extension: required

  dimension_group: _fivetran_synced { hidden: yes }
  dimension: created_by_id { hidden: yes }
  dimension_group: created {
    label: "Snapshot"
    timeframes: [date, raw, month]
    }
  dimension: is_deleted { hidden: yes }
  dimension_group: system_modstamp { hidden: yes }

  dimension: amount { hidden: yes }

  measure: max_created_date {
    type: date
    sql: MAX(${created_date}) ;;
  }

  measure: total_amount {
    type: sum
    sql: ${amount} ;;
  }
}

explore: opportunity_history_core {
  hidden: yes
}

view: opportunity_stage_history {
  derived_table: {
    sql:
    SELECT
      opportunity_id,
      SUM(amount) as amount,
      MAX(CASE WHEN (stage_name = 'Validate' OR stage_name = 'Qualify' OR stage_name = 'Develop' OR stage_name = 'Develop Positive' OR stage_name = 'Sales Submitted' OR stage_name = 'Closed Won') THEN 1 else 0 END) as stage_1_reached,
      MAX(CASE WHEN (stage_name = 'Qualify' OR stage_name = 'Develop' OR stage_name = 'Develop Positive' OR stage_name = 'Sales Submitted' OR stage_name = 'Closed Won') THEN 1 else 0 END) as stage_2_reached,
      MAX(CASE WHEN (stage_name = 'Develop' OR stage_name = 'Develop Positive' OR stage_name = 'Sales Submitted' OR stage_name = 'Closed Won') THEN 1 else 0 END) as stage_3_reached,
      MAX(CASE WHEN (stage_name = 'Develop Positive'  OR stage_name = 'Sales Submitted' OR stage_name = 'Closed Won') THEN 1 else 0 END) as stage_4_reached,
      MAX(CASE WHEN (stage_name = 'Sales Submitted' OR stage_name = 'Closed Won') THEN 1 else 0 END) as stage_5_reached,
      MAX(CASE WHEN (stage_name = 'Closed Won') THEN 1 else 0 END) as stage_6_reached,
      MAX(days_in_stage_1_2) as days_in_stage_1_2,
      MAX(days_in_stage_2_3) as days_in_stage_2_3,
      MAX(days_in_stage_3_4) as days_in_stage_3_4,
      MAX(days_in_stage_4_5) as days_in_stage_4_5,
      MAX(days_in_stage_5_6) as days_in_stage_5_6

    FROM (
      SELECT
        opportunity_history_core.opportunity_id  AS opportunity_id,
        opportunity_history_core.stage_name  AS stage_name,
        SUM(opportunity_history_core.amount)  AS amount,
        TIMESTAMP_TRUNC(CAST(MAX((CAST(opportunity_history_core.created_date  AS DATE)))  AS TIMESTAMP), DAY) AS max_created_date,
        CASE WHEN stage_name = 'Qualify' THEN DATE_DIFF(DATE(TIMESTAMP_TRUNC(CAST(MAX((CAST(opportunity_history_core.created_date  AS DATE)))  AS TIMESTAMP), DAY)), DATE(LAG(TIMESTAMP_TRUNC(CAST(MAX((CAST(opportunity_history_core.created_date  AS DATE)))
        AS TIMESTAMP), DAY)) OVER (PARTITION BY opportunity_id ORDER BY TIMESTAMP_TRUNC(CAST(MAX((CAST(opportunity_history_core.created_date  AS DATE)))  AS TIMESTAMP), DAY) ASC)), day) ELSE NULL END as days_in_stage_1_2,
        CASE WHEN stage_name = 'Develop' THEN DATE_DIFF(DATE(TIMESTAMP_TRUNC(CAST(MAX((CAST(opportunity_history_core.created_date  AS DATE)))  AS TIMESTAMP), DAY)), DATE(LAG(TIMESTAMP_TRUNC(CAST(MAX((CAST(opportunity_history_core.created_date  AS DATE)))
        AS TIMESTAMP), DAY)) OVER (PARTITION BY opportunity_id ORDER BY TIMESTAMP_TRUNC(CAST(MAX((CAST(opportunity_history_core.created_date  AS DATE)))  AS TIMESTAMP), DAY) ASC)), day) ELSE NULL END as days_in_stage_2_3,
        CASE WHEN stage_name = 'Develop Positive' THEN DATE_DIFF(DATE(TIMESTAMP_TRUNC(CAST(MAX((CAST(opportunity_history_core.created_date  AS DATE)))  AS TIMESTAMP), DAY)), DATE(LAG(TIMESTAMP_TRUNC(CAST(MAX((CAST(opportunity_history_core.created_date  AS DATE)))
        AS TIMESTAMP), DAY)) OVER (PARTITION BY opportunity_id ORDER BY TIMESTAMP_TRUNC(CAST(MAX((CAST(opportunity_history_core.created_date  AS DATE)))  AS TIMESTAMP), DAY) ASC)), day) ELSE NULL END as days_in_stage_3_4,
        CASE WHEN stage_name = 'Sales Submitted' THEN DATE_DIFF(DATE(TIMESTAMP_TRUNC(CAST(MAX((CAST(opportunity_history_core.created_date  AS DATE)))  AS TIMESTAMP), DAY)), DATE(LAG(TIMESTAMP_TRUNC(CAST(MAX((CAST(opportunity_history_core.created_date  AS DATE)))
        AS TIMESTAMP), DAY)) OVER (PARTITION BY opportunity_id ORDER BY TIMESTAMP_TRUNC(CAST(MAX((CAST(opportunity_history_core.created_date  AS DATE)))  AS TIMESTAMP), DAY) ASC)), day) ELSE NULL END as days_in_stage_4_5,
        CASE WHEN stage_name = 'Closed Won' THEN DATE_DIFF(DATE(TIMESTAMP_TRUNC(CAST(MAX((CAST(opportunity_history_core.created_date  AS DATE)))  AS TIMESTAMP), DAY)), DATE(LAG(TIMESTAMP_TRUNC(CAST(MAX((CAST(opportunity_history_core.created_date  AS DATE)))
        AS TIMESTAMP), DAY)) OVER (PARTITION BY opportunity_id ORDER BY TIMESTAMP_TRUNC(CAST(MAX((CAST(opportunity_history_core.created_date  AS DATE)))  AS TIMESTAMP), DAY) ASC)), day) ELSE NULL END as days_in_stage_5_6
      FROM salesforce.opportunity_history  AS opportunity_history_core
      GROUP BY 1,2
      ) stage_history
    GROUP BY 1;;
    }

  dimension: id {
    type: string
    sql: ${TABLE}.opportunity_id ;;
    primary_key: yes
  }

  dimension: opportunity_id {
    type: string
  }

  dimension: amount {
    type: number
    hidden: yes
  }

  dimension: stage_1_reached {
    type: yesno
    sql: CASE WHEN ${TABLE}.stage_1_reached = 1 THEN TRUE ELSE FALSE END ;;
  }

  dimension: stage_2_reached {
    type: yesno
    sql: CASE WHEN ${TABLE}.stage_2_reached = 1 THEN TRUE ELSE FALSE END ;;
  }

  dimension: stage_3_reached {
    type: yesno
    sql: CASE WHEN ${TABLE}.stage_3_reached = 1 THEN TRUE ELSE FALSE END ;;
  }

  dimension: stage_4_reached {
    type: yesno
    sql: CASE WHEN ${TABLE}.stage_4_reached = 1 THEN TRUE ELSE FALSE END ;;
  }

  dimension: stage_5_reached {
    type: yesno
    sql: CASE WHEN ${TABLE}.stage_5_reached = 1 THEN TRUE ELSE FALSE END ;;
  }

  dimension: stage_6_reached {
    type: yesno
    sql: CASE WHEN ${TABLE}.stage_6_reached = 1 THEN TRUE ELSE FALSE END ;;
  }

  dimension: days_in_stage_5_6 {
    type: number
    hidden: yes
  }

  dimension: days_in_stage_4_5 {
    type: number
    hidden: yes
  }

  dimension: days_in_stage_3_4 {
    type: number
    hidden: yes
  }

  dimension: days_in_stage_2_3 {
    type: number
    hidden: yes
  }

  dimension: days_in_stage_1_2 {
    type: number
    hidden: yes
  }

  dimension: highest_stage {
    hidden: yes
    type: string
    sql: CASE
          WHEN ${stage_6_reached} = TRUE THEN  'Stage 6'
          WHEN ${stage_5_reached} = TRUE THEN  'Stage 5'
          WHEN ${stage_4_reached} = TRUE THEN  'Stage 4'
          WHEN ${stage_3_reached} = TRUE THEN  'Stage 3'
          WHEN ${stage_2_reached} = TRUE THEN  'Stage 2'
          WHEN ${stage_1_reached} = TRUE THEN  'Stage 1'
          ELSE null
          END
          ;;
  }

  dimension: highest_stage_reached {
    label: "Stage Reached"
    sql: CASE
      WHEN ${stage_reached} = 6 THEN 'Stage 5 - 6'
      WHEN ${stage_reached} = 5 THEN 'Stage 4 - 5'
      WHEN ${stage_reached} = 4 THEN 'Stage 3 - 4'
      WHEN ${stage_reached} = 3 THEN 'Stage 2 - 3'
      WHEN ${stage_reached} = 2 THEN 'Stage 1 - 2'
      ELSE NULL END;;
  }

  dimension: stage_reached {
    hidden: yes
    sql:
      ${TABLE}.stage_1_reached + ${TABLE}.stage_2_reached +
      ${TABLE}.stage_3_reached + ${TABLE}.stage_4_reached + ${TABLE}.stage_5_reached +
      ${TABLE}.stage_6_reached ;;
    }

  measure: avg_days_stage_1_2 {
    description: "Avg duration of opportunities moving from Stage 1 to at Stage 2"
    type: average
    group_label: "Days In Stage"
    sql: ${days_in_stage_1_2} ;;
    value_format: "0.00"
  }

  measure: avg_days_stage_2_3 {
    description: "Avg duration of opportunities moving from Stage 2 to at Stage 3"
    type: average
    group_label: "Days In Stage"
    sql: ${days_in_stage_2_3} ;;
    value_format: "0.00"
  }

  measure: avg_days_stage_3_4 {
    description: "Avg duration of opportunities moving from Stage 3 to at Stage 4"
    type: average
    group_label: "Days In Stage"
    sql: ${days_in_stage_3_4} ;;
    value_format: "0.00"
  }

  measure: avg_days_stage_4_5 {
    description: "Avg duration of opportunities moving from Stage 4 to at Stage 5"
    type: average
    group_label: "Days In Stage"
    sql: ${days_in_stage_4_5} ;;
    value_format: "0.00"
  }

  measure: avg_days_stage_5_6 {
    description: "Avg duration of opportunities moving from Stage 5 to at Stage 6"
    type: average
    group_label: "Days In Stage"
    sql: ${days_in_stage_5_6} ;;
    value_format: "0.00"
  }

  measure: avg_days_in_stage {
    type: average
    description: "Avg number of days opportunities spend in each stage"
    sql:
      CASE
        WHEN ${highest_stage_reached} = 'Stage 1 - 2' THEN ${days_in_stage_1_2}
        WHEN ${highest_stage_reached} = 'Stage 2 - 3' THEN ${days_in_stage_2_3}
        WHEN ${highest_stage_reached} = 'Stage 3 - 4' THEN ${days_in_stage_3_4}
        WHEN ${highest_stage_reached} = 'Stage 4 - 5' THEN ${days_in_stage_4_5}
        WHEN ${highest_stage_reached} = 'Stage 5 - 6' THEN ${days_in_stage_5_6}
      ELSE NULL END
      ;;
    value_format: "0.00"
    group_label: "Days In Stage"
  }

  measure: opps_in_each_stage {
    description: "Number of opportunities in each stage"
    type: count_distinct
    sql: ${opportunity_id} ;;
    hidden: no
    drill_fields: [opportunity_id]
  }

  measure: running_count_in_each_stage {
    type: running_total
    sql: ${opps_in_each_stage} ;;
  }

  measure: conv_rate_stage_1_2 {
    label: "Stage 1 - 2 Conv Rate"
    group_label: "Conversion Rates"
    type: number
    sql: ${opps_in_stage_2} / NULLIF(${opps_in_stage_1},0);;
    value_format_name: percent_1
  }

  measure: conv_rate_stage_2_3 {
    label: "Stage 2 - 3 Conv Rate"
    group_label: "Conversion Rates"
    type: number
    sql: ${opps_in_stage_3} / NULLIF(${opps_in_stage_2},0);;
    value_format_name: percent_1
  }

  measure: conv_rate_stage_3_4 {
    label: "Stage 3 - 4 Conv Rate"
    group_label: "Conversion Rates"
    type: number
    sql: ${opps_in_stage_4} / NULLIF(${opps_in_stage_3},0);;
    value_format_name: percent_1
  }

  measure: conv_rate_stage_4_5 {
    label: "Stage 4 - 5 Conv Rate"
    group_label: "Conversion Rates"
    type: number
    sql: ${opps_in_stage_5} / NULLIF(${opps_in_stage_4},0);;
    value_format_name: percent_1
  }

  measure: conv_rate_stage_5_6 {
    label: "Stage 5 - 6 Conv Rate"
    group_label: "Conversion Rates"
    type: number
    sql: ${opps_in_stage_6} / NULLIF(${opps_in_stage_5},0);;
    value_format_name: percent_1
  }

  measure: opps_in_stage_1 {
    type: count
    group_label: "Count Opps"
    filters: {
      field: stage_1_reached
      value: "yes"
    }
  }

  measure: opps_in_stage_2 {
    type: count
    group_label: "Count Opps"
    filters: {
      field: stage_2_reached
      value: "yes"
    }
  }

  measure: opps_in_stage_3 {
    type: count
    group_label: "Count Opps"
    filters: {
      field: stage_3_reached
      value: "yes"
    }
  }


  measure: opps_in_stage_4 {
    type: count
    group_label: "Count Opps"
    filters: {
      field: stage_4_reached
      value: "yes"
    }
  }

  measure: opps_in_stage_5 {
    type: count
    group_label: "Count Opps"
    filters: {
      field: stage_5_reached
      value: "yes"
    }
  }

  measure: opps_in_stage_6 {
    type: count
    group_label: "Count Opps"
    filters: {
      field: stage_6_reached
      value: "yes"
    }
  }

  measure: avg_revenue_in_stage {
    type: average
    description: "Avg revenue of opportunities moving between stages"
    sql: CASE
          WHEN ${stage_1_reached} = 'yes' THEN opportunity_stage_history.amount
          WHEN ${stage_2_reached} = 'yes' THEN opportunity_stage_history.amount
          WHEN ${stage_3_reached} = 'yes' THEN opportunity_stage_history.amount
          WHEN ${stage_4_reached} = 'yes' THEN opportunity_stage_history.amount
          WHEN ${stage_5_reached} = 'yes' THEN opportunity_stage_history.amount
          WHEN ${stage_6_reached} = 'yes' THEN opportunity_stage_history.amount
          ELSE null
          END
      ;;
    value_format_name: usd
  }

}
