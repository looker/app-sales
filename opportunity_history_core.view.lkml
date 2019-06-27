
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

explore: opportunity_stage_history {
  hidden: yes
}

# This derived table first pulls the user-defined stages from the app-sales-config project. Then it generates a list of all the possible
# stages and joins that to the stages present in the opportunity history table. By joining the list of all possible stages to the present stages,
# the table then ensures that any missing stages are filled in. In the outer query, additional metrics such as days in each stage and
# amount are selected.
view: opportunity_stage_history_core {
  extends: [stage_customization]
  derived_table: {
    sql:
      with stages as (
        SELECT
          '{{stage_1._sql}}' as stage, 1 as order_of_stage UNION ALL
        SELECT
          '{{stage_2._sql}}' as stage, 2 as order_of_stage UNION ALL
        SELECT
          '{{stage_3._sql}}' as stage, 3 as order_of_stage UNION ALL
        SELECT
          '{{stage_4._sql}}' as stage, 4 as order_of_stage UNION ALL
         SELECT
          '{{stage_5._sql}}' as stage, 5 as order_of_stage UNION ALL
        SELECT
          '{{stage_6._sql}}' as stage, 6 as order_of_stage UNION ALL
        SELECT
          '{{stage_7._sql}}' as stage, 7 as order_of_stage
          ),
        days_in_stage as(
          SELECT
            opportunity_history_core.opportunity_id  AS opportunity_id,
            opportunity_history_core.stage_name  AS stage_name,
            SUM(opportunity_history_core.amount)  AS amount,
            TIMESTAMP_TRUNC(CAST(MAX((CAST(opportunity_history_core.created_date  AS DATE)))  AS TIMESTAMP), DAY) AS max_created_date,
            DATE_DIFF(DATE(LAG(TIMESTAMP_TRUNC(CAST(MAX((CAST(opportunity_history_core.created_date  AS DATE)))
              AS TIMESTAMP), DAY)) OVER (PARTITION BY opportunity_id ORDER BY TIMESTAMP_TRUNC(CAST(MAX((CAST(opportunity_history_core.created_date  AS DATE)))
              AS TIMESTAMP), DAY) DESC)), DATE(TIMESTAMP_TRUNC(CAST(MAX((CAST(opportunity_history_core.created_date  AS DATE)))  AS TIMESTAMP), DAY)), day)  as days_in_stage,
            CASE WHEN opportunity_history_core.stage_name = '{{stage_1._sql}}' THEN 1
               WHEN opportunity_history_core.stage_name = '{{stage_2._sql}}' THEN 2
               WHEN opportunity_history_core.stage_name = '{{stage_3._sql}}' THEN 3
               WHEN opportunity_history_core.stage_name = '{{stage_4._sql}}' THEN 4
               WHEN opportunity_history_core.stage_name = '{{stage_5._sql}}' THEN 5
               WHEN opportunity_history_core.stage_name = '{{stage_6._sql}}' THEN 6
                WHEN opportunity_history_core.stage_name = '{{stage_7._sql}}' THEN 7
            ELSE 0 END as number_reached
          FROM salesforce.opportunity_history  AS opportunity_history_core
          WHERE opportunity_history_core.stage_name IN ('{{stage_1._sql}}', '{{stage_2._sql}}', '{{stage_3._sql}}', '{{stage_4._sql}}', '{{stage_5._sql}}', '{{stage_6._sql}}', '{{stage_7._sql}}')
          GROUP BY 1,2),

        highest_reached AS
          (SELECT
            days_in_stage.opportunity_id,
            MAX(days_in_stage.number_reached) as number_reached
          FROM days_in_stage
          GROUP BY 1),

        filled_in_stages AS
          (SELECT
            stages.order_of_stage as order_of_filled_in_stage,
            highest_reached.opportunity_id
          FROM
          stages
          LEFT JOIN highest_reached on stages.order_of_stage  BETWEEN stages.order_of_stage AND highest_reached.number_reached
          LEFT JOIN days_in_stage ON days_in_stage.opportunity_id = highest_reached.opportunity_id

          WHERE highest_reached.number_reached >= stages.order_of_stage
          GROUP BY 1,2)

        SELECT
          filled_in_stages.order_of_filled_in_stage as order_of_stages,
          CASE
              WHEN filled_in_stages.order_of_filled_in_stage = 1 THEN '{{stage_1._sql}}'
              WHEN filled_in_stages.order_of_filled_in_stage = 2 THEN '{{stage_2._sql}}'
              WHEN filled_in_stages.order_of_filled_in_stage = 3 THEN '{{stage_3._sql}}'
              WHEN filled_in_stages.order_of_filled_in_stage = 4 THEN '{{stage_4._sql}}'
              WHEN filled_in_stages.order_of_filled_in_stage = 5 THEN '{{stage_5._sql}}'
              WHEN filled_in_stages.order_of_filled_in_stage = 6 THEN '{{stage_6._sql}}'
              WHEN filled_in_stages.order_of_filled_in_stage = 7 THEN '{{stage_7._sql}}'
            ELSE NULL END as filled_in_stage,
          filled_in_stages.opportunity_id as opportunity_id,
          days_in_stage.amount as amount,
          days_in_stage.days_in_stage as days_in_stage,
          days_in_stage.stage_name as stage_name

        FROM filled_in_stages
        LEFT JOIN days_in_stage ON filled_in_stages.opportunity_id = days_in_stage.opportunity_id AND filled_in_stages.order_of_filled_in_stage = days_in_stage.number_reached;;
  }

  dimension: id {
    type: string
    sql: CONCAT(${opportunity_id}, ${stage})  ;;
    primary_key: yes
    hidden: yes
  }

  dimension: opportunity_id {
    type: string
    hidden: yes
  }

  dimension: stage_1 {
    hidden: yes
  }

  dimension: stage_2 {
    hidden: yes
  }

  dimension: stage_3 {
    hidden: yes
  }

  dimension: stage_4 {
    hidden: yes
  }

  dimension: stage_5 {
    hidden: yes
  }

  dimension: stage_6 {
    hidden: yes
  }

  dimension: stage_7 {
    hidden: yes
  }

  dimension: order_of_stages {
    type: number
    hidden: yes
  }

  dimension: amount {
    type: number
    hidden: yes
  }

  # dimension: custom_stage_name {
  #   hidden: yes
  # }

  dimension: days_in_stage {
    type: number
    hidden:  no
  }

  measure: total_days_in_stage {
    type: sum
    sql: ${days_in_stage} ;;
  }

  dimension: stage {
    description: "Configurable stages that opportunities move through. Includes all the stages that each opportunity moved through, even if it skipped some."
    type: string
    sql: ${TABLE}.filled_in_stage ;;
    order_by_field: order_of_stages
  }

  measure: avg_days_in_stage {
    type: average
    description: "Avg number of days opportunities spend in each stage"
    sql: ${days_in_stage};;
    value_format: "0"
    group_label: "Days In Stage"
  }

  measure: opps_in_each_stage {
    description: "Number of opportunities in each stage"
    type: count_distinct
    sql: ${opportunity_id} ;;
    drill_fields: [opportunity.opp_drill_set_closed*]
  }


}
