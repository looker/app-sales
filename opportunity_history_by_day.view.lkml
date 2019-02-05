view: opportunity_history_by_day {
  derived_table: {
    sql: WITH union_current_and_history as (

                              -- Pulls all opportunity field history records, their occur date, and the field with the updated value
                              SELECT opportunity_id, id, created_date, field, new_value
                                FROM salesforce.opportunity_field_history
                              UNION ALL

                              -- Grabs the oldest possible values for the fields of our opporunities
                              SELECT DISTINCT ofh.opportunity_id, CONCAT('old_', ofh.opportunity_id, '_1'), o.created_date, ofh.field, FIRST_VALUE(ofh.old_value) OVER (PARTITION BY ofh.opportunity_id, ofh.field ORDER BY ofh.created_date ASC)
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
                            , LAST_VALUE(ID) OVER (PARTITION BY opportunity_id, TIMESTAMP_TRUNC(created_date,DAY) ORDER BY created_date, field ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as last_id_on_created_date
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
    sql: ${TABLE}.id ;;
  }

  dimension: opportunity_id {
    type: string
    sql: ${TABLE}.opportunity_id ;;
  }

  dimension: amount {
    type: string
    sql: ${TABLE}.amount ;;
  }

  dimension: close_date {
    type: string
    sql: ${TABLE}.close_date ;;
  }

  dimension: probability {
    type: string
    sql: ${TABLE}.probability ;;
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
    sql: ${TABLE}.opportunity_created_date ;;
  }

  dimension_group: window_start {
    type: time
    sql: ${TABLE}.window_start ;;
  }

  dimension_group: window_end {
    type: time
    sql: ${TABLE}.window_end ;;
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
