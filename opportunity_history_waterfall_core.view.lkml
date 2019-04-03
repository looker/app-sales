# Used for Pipeline Waterfall Viz for "Pipeline Management" Dashboard
view: opportunity_history_waterfall_core {
  extension: required

  derived_table: {
    sql:
      WITH union_current_and_history as (

                              -- Pulls all opportunity field history records, their occur date, and the field with the updated value
                              SELECT opportunity_id, id, created_date, field, new_value
                                FROM salesforce.opportunity_field_history
                              UNION ALL

                              -- Grabs the oldest possible values for the fields of our opporunities
                              SELECT DISTINCT ofh.opportunity_id, CONCAT('old_', ofh.opportunity_id, '_', ofh.field, '_1'), o.created_date, ofh.field, FIRST_VALUE(ofh.old_value) OVER (PARTITION BY ofh.opportunity_id, ofh.field ORDER BY ofh.created_date ASC)
                                FROM salesforce.opportunity_field_history AS ofh
                                JOIN salesforce.opportunity AS o ON ofh.opportunity_id = o.id
                                WHERE field IN ('{{ amount_config._sql }}','CloseDate','Probability','StageName','ForecastCategoryName')
                              UNION ALL

                              -- Grabs the current values of our opportunities
                              SELECT id, CONCAT('new_', id, '_1'), created_date, '{{ amount_config._sql }}', CAST({{ amount_config._sql }} as STRING)
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
                            , CASE WHEN field = '{{ amount_config._sql }}' THEN NEW_VALUE
                                  ELSE LAST_VALUE(CASE WHEN field = '{{ amount_config._sql }}' THEN NEW_VALUE END IGNORE NULLS)
                                          OVER (PARTITION BY opportunity_id ORDER BY created_date ASC, field ASC, id ASC ROWS UNBOUNDED PRECEDING)
                                  END as amount
                            , CASE WHEN field = 'CloseDate' THEN NEW_VALUE
                                  ELSE LAST_VALUE(CASE WHEN field = 'CloseDate' THEN NEW_VALUE END IGNORE NULLS)
                                          OVER (PARTITION BY opportunity_id ORDER BY created_date ASC, field ASC, id ASC ROWS UNBOUNDED PRECEDING)
                                  END as close_date
                            , CASE WHEN field = 'Probability' THEN NEW_VALUE
                                  ELSE LAST_VALUE(CASE WHEN field = 'Probability' THEN NEW_VALUE END IGNORE NULLS)
                                          OVER (PARTITION BY opportunity_id ORDER BY created_date ASC, field ASC, id ASC ROWS UNBOUNDED PRECEDING)
                                  END as probability
                            , CASE WHEN field = 'StageName' THEN NEW_VALUE
                                  ELSE LAST_VALUE(CASE WHEN field = 'StageName' THEN NEW_VALUE END IGNORE NULLS)
                                          OVER (PARTITION BY opportunity_id ORDER BY created_date ASC, field ASC, id ASC ROWS UNBOUNDED PRECEDING)
                                  END as stage_name
                            , CASE WHEN field = 'ForecastCategoryName' THEN NEW_VALUE
                                  ELSE LAST_VALUE(CASE WHEN field = 'ForecastCategoryName' THEN NEW_VALUE END IGNORE NULLS)
                                          OVER (PARTITION BY opportunity_id ORDER BY created_date ASC, field ASC, id ASC ROWS UNBOUNDED PRECEDING)
                                  END as forecast_category
                            , LAST_VALUE(ID) OVER (PARTITION BY opportunity_id, TIMESTAMP_TRUNC(created_date,DAY) ORDER BY created_date, field, id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as last_id_on_created_date
                            , FIRST_VALUE(TIMESTAMP_TRUNC(created_date,DAY)) OVER (PARTITION BY opportunity_id ORDER BY created_date, field) as opportunity_created_date
                            FROM union_current_and_history
                            WHERE field IN ('{{ amount_config._sql }}','CloseDate','Probability','StageName','ForecastCategoryName')
                        ),

                        opportunity_history_by_day as (SELECT distinct id, opportunity_id, CAST(amount AS FLOAT64) as amount, CAST(close_date as TIMESTAMP) as close_date, CAST(probability AS FLOAT64) as probability, stage_name, forecast_category, opportunity_created_date
                        , TIMESTAMP_TRUNC(created_date, DAY) as window_start
                        , COALESCE(LEAD(TIMESTAMP_TRUNC(created_date, DAY),1) OVER (PARTITION BY opportunity_id ORDER BY created_date, field), CAST('2100-12-31' AS TIMESTAMP)) as window_end
                        FROM first_pass_history_flatten
                        WHERE id = last_id_on_created_date)

      SELECT
              COALESCE(first.opportunity_id, last.opportunity_id)                       AS opportunity_id
            , first.opportunity_id                                                      AS opp_id_first
            , last.opportunity_id                                                       AS opp_id_last
            , COALESCE(first.opportunity_created_date , last.opportunity_created_date)  AS opportunity_created_date
            , first.id                                                                  AS history_id_first
            , first.window_start                                                        AS window_start_first
            , first.window_end                                                          AS window_end_first
            , 1.0*first.amount                                                          AS amount_first
            , first.close_date                                                          AS close_date_first
            , 1.0*first.probability                                                     AS probability_first
            , first.stage_name                                                          AS stage_name_first
            , first.forecast_category                                                   AS forecast_category_first
            , last.id                                                                   AS history_id_last
            , last.window_start                                                         AS window_start_last
            , last.window_end                                                           AS window_end_last
            , 1.0*last.amount                                                           AS amount_last
            , last.close_date                                                           AS close_date_last
            , 1.0*last.probability                                                      AS probability_last
            , last.stage_name                                                           AS stage_name_last
            , last.forecast_category                                                    AS forecast_category_last

          FROM (
                  SELECT
                    *
                  FROM opportunity_history_by_day
                  WHERE {% date_start pipeline_dates %} >= window_start AND {% date_start pipeline_dates %} < window_end
                ) AS first

          FULL OUTER JOIN (
                  SELECT
                    *
                  FROM opportunity_history_by_day
                  WHERE {% date_end pipeline_dates %} >= window_start AND {% date_end pipeline_dates %} < window_end
                ) AS last

            ON first.opportunity_id = last.opportunity_id
           ;;
  }

  filter: pipeline_dates {
    convert_tz: no
    type: date
    default_value: "this quarter"
  }

  filter: close_dates {
    convert_tz: no
    type: date
    default_value: "this quarter"
  }

  dimension: close_date_in_range_first {
    group_label: "First Flags"
    type: yesno
    sql: {% if close_dates._is_filtered %}
            {% condition close_dates %} ${close_date_first} {% endcondition %}
         {% else %}
            {% condition pipeline_dates %} ${close_date_first} {% endcondition %}
         {% endif %} ;;
  }

  dimension: close_date_in_range_last {
    group_label: "Last Flags"
    type: yesno
    sql:  {% if close_dates._is_filtered %}
            {% condition close_dates %} ${close_date_last} {% endcondition %}
          {% else %}
            {% condition pipeline_dates %} ${close_date_last} {% endcondition %}
          {% endif %} ;;
  }

  dimension: closed_date_in_start_or_end {
    type: yesno
    sql: ${close_date_in_range_first} OR ${close_date_in_range_last}  ;;
  }

  # MAYBE INCLUDE UNCHANGED AND DYNAMIC?
  # filter: sankey_focus {
  #   type: string
  #   suggestions: ["Pipeline","Forecast","Commit","Omitted"]
  # }


# 1 pipeline +
# in close first

# 2 forecast +
# in close first

# 3 commit +
# in close first

# 4 close +
# in close first

# 5 omitted
# in close first

# 7 new deals
# history_id is null
# and close won LAST

# 6 pulled in
# not in close first and ( pipeline, forecast, commit, close LAST)
#

# NULL
# history_id is null
# OR (
#   not in close first
#   AND last omitted
#   OR close lost
# )

  dimension: pk {
    type: string
    primary_key: yes
    sql: CONCAT(${opportunity_id}, '-', CAST(${opportunity_created_date} AS STRING)) ;;
  }

  dimension: sankey_forecast_first {
    type: string
#     order_by_field: sankey_forecast_first_sort
    sql: CASE
            WHEN NOT (${close_date_in_range_first}) AND ${close_date_in_range_last} AND NOT ${new_deals} THEN 'Moved In'
            WHEN ${close_date_in_range_first} THEN ${forecast_category_first}
            WHEN ${new_deals} AND ${close_date_in_range_last} THEN 'New Opps'
            WHEN ${amount_increased} THEN 'Increased'
            END
            ;;
  }

  ################

# ORIGINAL LOGIC:

#   CASE
#            WHEN ${close_date_in_range_first} THEN CASE
#              WHEN ${forecast_category_first} = 'Pipeline' THEN 'Pipeline (+)'
#              WHEN ${forecast_category_first} = 'Forecast' THEN 'Forecast (+)'
#              WHEN ${forecast_category_first} = 'Commit' THEN 'Commit (+)'
#              WHEN ${forecast_category_first} = 'Closed' THEN 'Closed (+)'
#              WHEN ${forecast_category_first} = 'Omitted' THEN 'Omitted'
#              END
#            WHEN ${history_id_first} IS NULL AND ${closed_won_last} THEN 'New Deals'
#            WHEN ${close_date_in_range_last} AND ${forecast_category_last} IN ('Pipeline','Forecast','Commit','Closed')  THEN 'Pulled In'
#            END


  ################

#   dimension: sankey_forecast_first_sort {
#     hidden: yes
#     type: number
#     sql: CASE
#           WHEN ${close_date_in_range_first} THEN CASE
#           WHEN ${forecast_category_first} = 'Pipeline' THEN 1
#           WHEN ${forecast_category_first} = 'Forecast' THEN 2
#           WHEN ${forecast_category_first} = 'Commit' THEN 3
#           WHEN ${forecast_category_first} = 'Closed' THEN 4
#           WHEN ${forecast_category_first} = 'Omitted' THEN 5
#           END
#           WHEN ${history_id_first} IS NULL AND ${closed_won_last} AND ${close_date_in_range_last} THEN 7
#           WHEN ${close_date_in_range_last} AND ${forecast_category_last} IN ('Pipeline','Forecast','Commit','Closed')  THEN 6
#           END
#           ;;
#   }

# Will want to rethink the logic for "Abandoned" (might just be that they haven't updated the Close Date yet)
  dimension: sankey_forecast_last {
    type: string
#     order_by_field: sankey_forecast_last_sort
    sql:  CASE
            WHEN ${closed_won_last} AND ${close_date_in_range_last} THEN 'Won'
            WHEN ${closed_lost_last} AND ${close_date_in_range_last} THEN 'Lost'
            WHEN ${close_date_in_range_first} AND NOT (${close_date_in_range_last}) THEN 'Moved Out'
            WHEN ${amount_decreased} AND ${closed_date_in_start_or_end} THEN 'Decreased'
            ELSE 'Remain Open' -- Close Date in range but NOT Won or Lost
          END
          ;;
  }

#   dimension: sankey_forecast_last_sort {
#     type: number
#     hidden: yes
#     sql:  CASE
#             WHEN ${closed_won_last} THEN 5
#             WHEN ${closed_lost_last} THEN 7
#             WHEN NOT (${close_date_in_range_last}) THEN 6
#             ELSE CASE
#               WHEN ${forecast_category_last} = 'Pipeline' THEN 1
#               WHEN ${forecast_category_last} = 'Forecast' THEN 2
#               WHEN ${forecast_category_last} = 'Commit' THEN 3
#               WHEN ${forecast_category_last} = 'Close' THEN 4
#               WHEN ${forecast_category_last} = 'Omitted' THEN 8
#               END
#           END   ;;
#   }




  dimension: opportunity_id {
#     hidden: yes
  type: string
  sql: ${TABLE}.OPPORTUNITY_ID ;;
#   link: {
#     label: "Link to Salesforce"
#     url: "https://navis.my.salesforce.com/{{id._value}}?nooverride=true"
#     icon_url: "https://www.google.com/s2/favicons?domain=www.salesforce.com"
#   }

}

dimension: opp_id_first {
  hidden: yes
  type: string
  sql: ${TABLE}.opp_id_first ;;
}

dimension: opp_id_last {
  hidden: yes
  type: string
  sql: ${TABLE}.opp_id_last ;;
}


dimension: opportunity_created_date {
  type: string
  sql: ${TABLE}.OPPORTUNITY_CREATED_DATE ;;
}

dimension: history_id_first {
#     hidden: yes
type: string
sql: ${TABLE}.HISTORY_ID_FIRST ;;
}

dimension: window_start_first {
  group_label: "Record Active Dates"
  type: string
  sql: ${TABLE}.WINDOW_START_FIRST ;;
}

dimension: window_end_first {
  group_label: "Record Active Dates"
  type: string
  sql: ${TABLE}.WINDOW_END_FIRST ;;
}

dimension: amount_first {
  group_label: "First Time period"
  type: number
  sql: ${TABLE}.AMOUNT_FIRST ;;
  value_format_name: usd
}

dimension: amount_increased {
  group_label: "Amount Change Flags"
  type: yesno
  sql: ${amount_last} > ${amount_first} ;;
}

dimension: amount_decreased {
  group_label: "Amount Change Flags"
  type: yesno
  sql: ${amount_last} < ${amount_first} ;;
}

dimension: amount_unchanged {
  group_label: "Amount Change Flags"
  type: yesno
  sql: ${amount_last} = ${amount_first}  ;;
}

dimension: opportunity_unchanged {
  group_label: "Period Changes"
  type: yesno
  sql: ${history_id_first} = ${history_id_last} ;;
}

dimension: new_deals {
  group_label: "Period Changes"
  type: yesno
  sql: ${history_id_first} IS NULL ;;
}

dimension: pushed_out {
  group_label: "Period Changes"
  type: yesno
  sql: ${history_id_last} IS NULL ;;
}

dimension: new_deal_or_close_date_in_range_first {
  group_label: "Period Changes"
  type: yesno
  sql: ${new_deals} OR ${close_date_in_range_first} ;;
}

#   dimension: pipeline_first {
#     group_label: "First Timeperiod Flags"
#     type: yesno
#     sql: ${} ;;
#   }

dimension: closed_won_first {
  group_label: "First Timeperiod Flags"
  type: yesno
  sql: ${stage_name_first} LIKE '%Closed%Won%' ;;
}

dimension: closed_won_last {
  group_label: "Last Timeperiod Flags"
  type: yesno
  sql: ${stage_name_last} LIKE '%Closed%Won%' ;;
}

dimension: closed_first {
  group_label: "First Timeperiod Flags"
  type: yesno
  sql: ${stage_name_first} LIKE '%Close%' ;;
}

dimension: closed_last {
  group_label: "Last Timeperiod Flags"
  type: yesno
  sql: ${stage_name_last} LIKE '%Close%' ;;
}

dimension: closed_lost_first {
  group_label: "First Timeperiod Flags"
  type: yesno
  sql: ${stage_name_first} LIKE '%Close%' AND NOT ${closed_won_first} ;;
}

dimension: closed_lost_last {
  group_label: "Last Timeperiod Flags"
  type: yesno
  sql: ${stage_name_last} LIKE '%Close%' AND NOT ${closed_won_last} ;;
}

dimension: close_date_first {
  group_label: "First Timeperiod"
  type: string
  sql: ${TABLE}.CLOSE_DATE_FIRST ;;
}

dimension: probability_first {
  group_label: "First Timeperiod"
  type: string
  sql: ${TABLE}.PROBABILITY_FIRST ;;
}

dimension: stage_name_first {
  group_label: "First Timeperiod"
  type: string
  sql: ${TABLE}.STAGE_NAME_FIRST ;;
}

dimension: forecast_category_first {
  group_label: "First Timeperiod"
  type: string
  sql: ${TABLE}.FORECAST_CATEGORY_FIRST ;;
}

dimension: history_id_last {
  type: string
  sql: ${TABLE}.HISTORY_ID_LAST ;;
}

dimension: window_start_last {
  group_label: "Record Active Dates"
  type: string
  sql: ${TABLE}.WINDOW_START_LAST ;;
}

dimension: window_end_last {
  group_label: "Record Active Dates"
  type: string
  sql: ${TABLE}.WINDOW_END_LAST ;;
}

dimension: amount_last {
  group_label: "Last Timeperiod"
  type: number
  sql: ${TABLE}.AMOUNT_LAST ;;
  value_format_name: usd
}

dimension: close_date_last {
  group_label: "Last Timeperiod"
  type: string
  sql: ${TABLE}.CLOSE_DATE_LAST ;;
}

dimension: probability_last {
  group_label: "Last Timeperiod"
  type: string
  sql: ${TABLE}.PROBABILITY_LAST ;;
}

dimension: stage_name_last {
  group_label: "Last Timeperiod"
  type: string
  sql: ${TABLE}.STAGE_NAME_LAST ;;
}

dimension: forecast_category_last {
  group_label: "Last Timeperiod"
  type: string
  sql: ${TABLE}.FORECAST_CATEGORY_LAST ;;
}

measure: starting_pipeline {
  label: "Pipeline"
  group_label: "Pipeline Changes (Waterfall)"
  type: sum
  sql: ${amount_first} ;;
  filters: { field: close_date_in_range_first value: "Yes" }
  drill_fields: [detail*]
  value_format_name: custom_amount_value_format
}
measure: starting_pipeline_opp_count {
  label: "Pipeline Count"
  group_label: "Pipeline Changes (Opp Count)"
  type: count_distinct
  sql: ${opp_id_first} ;;
  filters: { field: close_date_in_range_first value: "Yes" }
  drill_fields: [detail*]
  # value_format_name: money_type
}

measure: starting_pipeline_forecast_or_later {
  type: sum
  sql: ${amount_first} ;;
  filters: { field: close_date_in_range_first value: "Yes" }
  filters: { field: forecast_category_first value: "Forecast,Commit,Closed" }
  drill_fields: [detail*]
  # value_format_name: money_type
}

measure: new_opportunities {
  label: "New Opps"
  group_label: "Pipeline Changes (Waterfall)"
  type: sum
  sql: ${amount_last} ;;
  filters: { field: new_deals value: "Yes"  }
  filters: { field: close_date_in_range_last value: "Yes" }
  drill_fields: [detail*]
  value_format_name: custom_amount_value_format
}
measure: new_opp_count {
  label: "New Opps Count"
  group_label: "Pipeline Changes (Opp Count)"
  type: count_distinct
  sql: ${opp_id_last} ;;
#     filters: { field: closed_last value: "No" }
  filters: { field: new_deals value: "Yes"  }
  filters: { field: close_date_in_range_last value: "Yes" }
  drill_fields: [detail*]
  # value_format_name: money_type
}

measure: date_changed_in {
  label: "Moved In"
  group_label: "Pipeline Changes (Waterfall)"
  type: sum
  sql: ${amount_first} ;;
#     filters: { field: closed_last value: "No" }
  filters: { field: close_date_in_range_first value: "No" }
  filters: { field: new_deals value: "No" }
  filters: { field: close_date_in_range_last value: "Yes" }
  drill_fields: [detail*]
  value_format_name: custom_amount_value_format
}
measure: date_changed_in_count {
  label: "Moved In Count"
  group_label: "Pipeline Changes (Opp Count)"
  type: count_distinct
  sql: ${opp_id_last} ;;
#     filters: { field: closed_last value: "No" }
  filters: { field: close_date_in_range_first value: "No" }
  filters: { field: new_deals value: "No" }
  filters: { field: close_date_in_range_last value: "Yes" }
  drill_fields: [detail*]
  # value_format_name: money_type
}

measure: date_changed_out {
  label: "Moved Out"
  group_label: "Pipeline Changes (Waterfall)"
  type: sum
  sql: -1.0*${amount_last} ;;
#     filters: { field: closed_last value: "No" }
  filters: { field: close_date_in_range_first value: "Yes" }
  filters: { field: close_date_in_range_last value: "No" }
  drill_fields: [detail*]
  # Can't use custom value format we have defined in config. Excel styling doesn't seem to allow for more than 3 potential format outputs
  value_format: "[<=-1000000]-$0.00,,\"M\";[<=-1000]-$0.00,\"K\";-$0.00"
}

measure: date_changed_out_count {
  label: "Moved Out Count"
  group_label: "Pipeline Changes (Opp Count)"
  type: count_distinct
  sql:   ${opp_id_last} ;;
#     filters: { field: closed_last value: "No" }
  filters: { field: close_date_in_range_first value: "Yes" }
  filters: { field: close_date_in_range_last value: "No" }
  drill_fields: [detail*]
  # value_format_name: money_type
}

measure: value_changed_increased {
  label: "Increased"
  group_label: "Pipeline Changes (Waterfall)"
  type: sum
  sql: ${amount_last} - ${amount_first} ;;
  filters: { field: amount_increased value: "Yes" }
#     filters: { field: close_date_in_range_first value: "Yes" }
  filters: { field: closed_date_in_start_or_end value: "Yes" }
  drill_fields: [detail*]
  value_format_name: custom_amount_value_format
}

  measure: value_changed_increased_count {
    label: "Increased Count"
    group_label: "Pipeline Changes (Opp Count)"
    type: count_distinct
    sql: ${opp_id_last} ;;
    filters: { field: amount_increased value: "Yes" }
#     filters: { field: close_date_in_range_first value: "Yes" }
    filters: { field: closed_date_in_start_or_end value: "Yes" }
    drill_fields: [detail*]
  }

measure: value_change_decreased {
  label: "Decreased"
  group_label: "Pipeline Changes (Waterfall)"
  type: sum
  sql: ${amount_last} - ${amount_first} ;;
  filters: { field: amount_decreased value: "Yes" }
#     filters: { field: close_date_in_range_first value: "Yes" }
  filters: { field: closed_date_in_start_or_end value: "Yes" }
  drill_fields: [detail*]
  value_format_name: custom_amount_value_format
}

  measure: value_changed_decreased_count {
    label: "Decreased Count"
    group_label: "Pipeline Changes (Opp Count)"
    type: count_distinct
    sql: ${opp_id_last} ;;
    filters: { field: amount_decreased value: "Yes" }
#     filters: { field: close_date_in_range_first value: "Yes" }
    filters: { field: closed_date_in_start_or_end value: "Yes" }
    drill_fields: [detail*]
  }

measure: closed_won {
  label: "Won"
  group_label: "Pipeline Changes (Waterfall)"
  type: sum
  sql: -1.0*${amount_last} ;;
  filters: { field: closed_won_last value: "Yes" }
#     filters: { field: new_deal_or_close_date_in_range_first value: "Yes" }
  filters: { field: close_date_in_range_last value: "Yes" }
  drill_fields: [detail*]
  # Can't use custom value format we have defined in config. Excel styling doesn't seem to allow for more than 3 potential format outputs
  value_format: "[<=-1000000]-$0.00,,\"M\";[<=-1000]-$0.00,\"K\";-$0.00"
}
measure: closed_won_count {
  label: "Won Count"
  group_label: "Pipeline Changes (Opp Count)"
  type: count_distinct
  sql: ${opp_id_last} ;;
  filters: { field: closed_won_last value: "Yes" }
#     filters: { field: new_deal_or_close_date_in_range_first value: "Yes" }
  filters: { field: close_date_in_range_last value: "Yes" }
  drill_fields: [detail*]
  # value_format_name: money_type
}

measure: closed_lost {
  group_label: "Pipeline Changes (Waterfall)"
  label: "Lost"
  type: sum
  sql: -1.0*${amount_last} ;;
  filters: { field: closed_lost_last value: "Yes" }
  filters: { field: close_date_in_range_last value: "Yes" }
#     filters: { field: new_deal_or_close_date_in_range_first value: "Yes" }
  drill_fields: [detail*]
  # Can't use custom value format we have defined in config. Excel styling doesn't seem to allow for more than 3 potential format outputs
  value_format: "[<=-1000000]-$0.00,,\"M\";[<=-1000]-$0.00,\"K\";-$0.00"
}
measure: closed_lost_count {
  label: "Lost Count"
  group_label: "Pipeline Changes (Opp Count)"
  type: count_distinct
  sql: ${opp_id_last} ;;
  filters: { field: closed_lost_last value: "Yes" }
  filters: { field: close_date_in_range_last value: "Yes" }
  drill_fields: [detail*]
  # value_format_name: money_type
}

measure: end_pipeline {
  label: "Remain Open"
  group_label: "Pipeline Changes (Waterfall)"
  type: sum
  sql: -1 *  ${amount_last} ;;
  filters: { field: close_date_in_range_last value: "Yes" }
  filters: { field: closed_last value: "No" }
  drill_fields: [detail*]
  # Can't use custom value format we have defined in config. Excel styling doesn't seem to allow for more than 3 potential format outputs
  value_format: "[<=-1000000]-$0.00,,\"M\";[<=-1000]-$0.00,\"K\";-$0.00"
}

measure: end_opp_count {
  label: "Remain Open Count"
  group_label: "Pipeline Changes (Opp Count)"
  type: count_distinct
  sql:   ${opp_id_last} ;;
  filters: { field: close_date_in_range_last value: "Yes" }
  filters: { field: closed_last value: "No" }
  drill_fields: [detail*]
  # value_format_name: money_type
}


measure: sankey_sum_amount {
  type: sum
  sql: ${amount_last} ;;
  drill_fields: [detail*]
  # value_format_name: money_type
  value_format_name: custom_amount_value_format
}

measure: total_amount_last {
  type: sum
  sql: ${amount_last} ;;
  drill_fields: [detail*]
  # value_format_name: money_type
}

measure: count {
  type: count
  drill_fields: [detail*]
}

measure: count_date_changed_in {
  label: "Count Date Change In"
  type: count
#     filters: { field: closed_last value: "No" }
  filters: { field: close_date_in_range_first value: "No" }
  filters: { field: new_deals value: "No" }
  filters: { field: close_date_in_range_last value: "Yes" }
  drill_fields: [detail*]
}

measure: count_date_changed_in_or_new_deal {
  label: "Count Date Change In or New Deal"
  type: count
#     filters: { field: closed_last value: "No" }
  filters: { field: close_date_in_range_first value: "No" }
  # filters: { field: new_deals value: "No" }
  filters: { field: close_date_in_range_last value: "Yes" }
  drill_fields: [detail*]
}

measure: count_date_changed_out {
  label: "Count Date Change Out"
  type: count
  filters: { field: close_date_in_range_first value: "Yes" }
  filters: { field: close_date_in_range_last value: "No" }
  drill_fields: [detail*]
}

measure: count_closed_won {
  label: "Count Closed Won"
  type: count
  filters: { field: closed_won_last value: "Yes" }
  drill_fields: [detail*]
}



set: detail {
  fields: [
    opportunity.opportunity_name,
    opportunity_id,
    opportunity_created_date,
#       history_id_first,
#       window_start_first,
#       window_end_first,
    amount_first,
    close_date_first,
    probability_first,
    stage_name_first,
    forecast_category_first,
#       history_id_last,
#       window_start_last,
#       window_end_last,
    amount_last,
    close_date_last,
    probability_last,
    stage_name_last,
    forecast_category_last
  ]
}
}

####################################################################################

view: opportunity_history_waterfall_filter_suggestions {
  derived_table: {
    sql:
      -- Produce suggestions for Sankey Forecast Category First
      SELECT DISTINCT old_value AS suggestions_first, CAST(null as STRING) AS suggestions_last
      FROM opportunity_field_history
      WHERE field = 'ForecastCategoryName'
      UNION ALL
      SELECT 'Moved In', null
      UNION ALL
      SELECT 'New Opps', null

      UNION ALL

      -- Produce suggestions for Sankey Forecast Category Last
      SELECT null, 'Moved Out'
      UNION ALL
      SELECT null, 'Lost'
      UNION ALL
      SELECT null, 'Won'
      UNION ALL
      SELECT null, 'Remain Open' ;;
  }

  dimension: suggestions_first {
    type: string
  }

  dimension: suggestions_last {
    type: string
  }
}


# If necessary, uncomment the line below to include explore_source.
# include: "sales_analytics.model.lkml"
explore: opp_history_waterfall_derived {hidden: yes}
view: opp_history_waterfall_derived {
  derived_table: {
    explore_source: opportunity_history_waterfall {
      column: sankey_forecast_first {}
      column: sankey_forecast_last {}
      column: stage_name { field: opportunity.stage_name }
      column: name { field: opportunity.name }
      column: is_pipeline { field: opportunity.is_pipeline }
      column: total_amount { field: opportunity.total_amount }
      column: source { field: opportunity.source }
      column: owner_name { field: opportunity_owner.name }
      column: business_segment { field: account.business_segment }
      filters: {
        field: opportunity_history_waterfall.pipeline_dates
        value: "last quarter"
      }
    }

  datagroup_trigger: sales_analytics_etl
  }
  dimension: sankey_forecast_first {}
  dimension: sankey_forecast_last {}
  dimension: stage_name {
    label: "Stage Name"
  }
  dimension: name {
    label: "Opportunity"
  }
  dimension: owner_name {
    label: "Owner Name"
  }
  dimension: is_pipeline {
    label: "Is Pipeline"
    type: yesno
  }
  dimension: total_amount {
    label: "Total ACV "
    value_format_name: custom_amount_value_format
    type: number
  }
  dimension: source {
    label: "Source"
  }
  dimension: business_segment {}
}
