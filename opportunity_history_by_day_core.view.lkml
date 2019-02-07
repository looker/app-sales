# Used for the Pipeline Waterfall Viz and Pipeline Report for "Pipeline Management" Dashboard
view: opportunity_history_by_day_core {
  extension: required

  derived_table: {
    sql: WITH union_current_and_history as (

                              -- Pulls all opportunity field history records, their occur date, and the field with the updated value
                              SELECT opportunity_id, id, created_date, field, new_value
                                FROM salesforce.opportunity_field_history
                              UNION ALL

                              -- Grabs the oldest possible values for the fields of our opporunities
                              SELECT DISTINCT ofh.opportunity_id, CONCAT('old_', ofh.opportunity_id, '_', ofh.field, '_1'), o.created_date, ofh.field, FIRST_VALUE(ofh.old_value) OVER (PARTITION BY ofh.opportunity_id, ofh.field ORDER BY ofh.created_date ASC)
                                FROM salesforce.opportunity_field_history AS ofh
                                JOIN salesforce.opportunity AS o ON ofh.opportunity_id = o.id
                                WHERE field IN ('Amount','CloseDate','Probability','StageName','ForecastCategoryName')
                              UNION ALL

                              -- Grabs the current values of our opportunities
                              SELECT id, CONCAT('new_', id, '_1'), created_date, 'Amount', CAST(amount as STRING)
                                FROM salesforce.opportunity
                              UNION ALL
                              SELECT id, CONCAT('new_', id, '_2'), created_date, 'CloseDate', CAST(close_date as STRING)
                                FROM salesforce.opportunity
                              UNION ALL
                              SELECT id, CONCAT('new_', id, '_3'), created_date, 'Probability', CAST(probability as STRING)
                                FROM salesforce.opportunity
                              UNION ALL
                              SELECT id, CONCAT('new_', id, '_4'), created_date, 'StageName', stage_name
                                FROM salesforce.opportunity
                              UNION ALL
                              SELECT id, CONCAT('new_', id, '_5'), created_date, 'ForecastCategoryName', forecast_category_name
                                FROM salesforce.opportunity
                        ),

                        first_pass_history_flatten as (
                            SELECT distinct
                            opportunity_id
                            , id
                            , created_date
                            , field
                            , CASE WHEN field = 'Amount' THEN NEW_VALUE
                                  ELSE LAST_VALUE(CASE WHEN field = 'Amount' THEN NEW_VALUE END IGNORE NULLS)
                                          OVER (PARTITION BY opportunity_id ORDER BY created_date, field ROWS UNBOUNDED PRECEDING)
                                  END as amount
                            , CASE WHEN field = 'CloseDate' THEN NEW_VALUE
                                  ELSE LAST_VALUE(CASE WHEN field = 'CloseDate' THEN NEW_VALUE END IGNORE NULLS)
                                          OVER (PARTITION BY opportunity_id ORDER BY created_date, field ROWS UNBOUNDED PRECEDING)
                                  END as close_date
                            , CASE WHEN field = 'Probability' THEN NEW_VALUE
                                  ELSE LAST_VALUE(CASE WHEN field = 'Probability' THEN NEW_VALUE END IGNORE NULLS)
                                          OVER (PARTITION BY opportunity_id ORDER BY created_date, field ROWS UNBOUNDED PRECEDING)
                                  END as probability
                            , CASE WHEN field = 'StageName' THEN NEW_VALUE
                                  ELSE LAST_VALUE(CASE WHEN field = 'StageName' THEN NEW_VALUE END IGNORE NULLS)
                                          OVER (PARTITION BY opportunity_id ORDER BY created_date, field ROWS UNBOUNDED PRECEDING)
                                  END as stage_name
                            , CASE WHEN field = 'ForecastCategoryName' THEN NEW_VALUE
                                  ELSE LAST_VALUE(CASE WHEN field = 'ForecastCategoryName' THEN NEW_VALUE END IGNORE NULLS)
                                          OVER (PARTITION BY opportunity_id ORDER BY created_date, field ROWS UNBOUNDED PRECEDING)
                                  END as forecast_category
                            , LAST_VALUE(ID) OVER (PARTITION BY opportunity_id, TIMESTAMP_TRUNC(created_date,DAY) ORDER BY created_date, field, id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as last_id_on_created_date
                            , FIRST_VALUE(TIMESTAMP_TRUNC(created_date,DAY)) OVER (PARTITION BY opportunity_id ORDER BY created_date, field) as opportunity_created_date
                            FROM union_current_and_history
                            WHERE field IN ('Amount','CloseDate','Probability','StageName','ForecastCategoryName')
                        )

                         SELECT distinct id, opportunity_id, CAST(amount AS FLOAT64) as amount, CAST(close_date as TIMESTAMP) as close_date, CAST(probability AS FLOAT64) as probability, stage_name, forecast_category, opportunity_created_date
                        , TIMESTAMP_TRUNC(created_date, DAY) as window_start
                        , COALESCE(LEAD(TIMESTAMP_TRUNC(created_date, DAY),1) OVER (PARTITION BY opportunity_id ORDER BY created_date, field), CAST('2100-12-31' AS TIMESTAMP)) as window_end
                        FROM first_pass_history_flatten
                        WHERE id = last_id_on_created_date
                         ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: id {
    type: string
    primary_key: yes
    sql: ${TABLE}.id ;;
  }

  dimension: opportunity_id {
    type: string
    sql: ${TABLE}.opportunity_id ;;
  }

  dimension: amount {
    type: number
    sql: ${TABLE}.amount ;;
    value_format_name: usd_0
  }

  dimension: close_date {
    type: string
    sql: ${TABLE}.close_date ;;
  }

  dimension: probability {
    type: number
    sql: ${TABLE}.probability ;;
  }

  dimension: probability_tier {
    type: string
    case: {
      when: {
        sql: ${probability} = 100 ;;
        label: "Won"
      }

      when: {
        sql: ${probability} >= 80 ;;
        label: "80 - 99%"
      }

      when: {
        sql: ${probability} >= 60 ;;
        label: "60 - 79%"
      }

      when: {
        sql: ${probability} >= 40 ;;
        label: "40 - 59%"
      }

      when: {
        sql: ${probability} >= 20 ;;
        label: "20 - 39%"
      }

      when: {
        sql: ${probability} > 0 ;;
        label: "1 - 19%"
      }

      when: {
        sql: ${probability} = 0 ;;
        label: "Lost"
      }
    }
  }

  dimension: stage_name {
    type: string
    sql: ${TABLE}.stage_name ;;
  }

  dimension: forecast_category {
    type: string
    sql: ${TABLE}.forecast_category ;;
  }

  dimension_group: opportunity_created_date {
    type: time
    convert_tz: no # no time data, timezone conversions not necessary
    sql: ${TABLE}.opportunity_created_date ;;
  }

  dimension_group: window_start {
    type: time
    convert_tz: no # no time data, timezone conversions not necessary
    sql: ${TABLE}.window_start ;;
  }

  dimension_group: window_end {
    type: time
    convert_tz: no # no time data, timezone conversions not necessary
    sql: ${TABLE}.window_end ;;
  }

  measure: total_amount {
    type: sum
    sql: ${amount} ;;
    value_format_name: usd_0
    drill_fields: [detail*]
  }

  measure: total_amount_open_opportunities {
    type: sum
    filters: {
      field: stage_name
      value: "-Closed Won, -Closed Lost,-Qualify Renewal, -Expected Renewal"
    }
    sql: ${amount} ;;

    value_format_name: usd_0
    drill_fields: [detail*]
  }

  set: detail {
    fields: [
      id,
      opportunity_id,
      amount,
      close_date,
      probability,
      stage_name,
      forecast_category,
      opportunity_created_date_time,
      window_start_time,
      window_end_time
    ]
  }
}
