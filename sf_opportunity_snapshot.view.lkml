view: historical_snapshot {
  derived_table: {
    datagroup_trigger: fivetran_synced
    sql: with dates as (
      --Generate 5 years of dates.
          select date
          from UNNEST(GENERATE_DATE_ARRAY(DATE_SUB(CURRENT_DATE, INTERVAL 5 YEAR), CURRENT_DATE)) date
      ),

       snapshot_window as (
            select opportunity_history.*
                  , coalesce(lead(EXTRACT(date FROM created_date),1) over(partition by opportunity_id order by created_date), current_date) as stage_end
                    from `fivetran-fivetran-fivetran-loo.salesforce.opportunity_history` AS opportunity_history
      )
    -- https://discourse.looker.com/t/analytic-block-state-or-status-data-and-slowly-changing-dimensions/1937
      select dates.date as observation_date
           , snapshot_window.*
            from snapshot_window
            left join dates as dates
            on dates.date >= EXTRACT(date FROM snapshot_window.created_date)
            and dates.date <= snapshot_window.stage_end
            where dates.date <= current_date
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension_group: snapshot {
    type: time
    datatype: date
    description: "What snapshot date are you interetsed in?"
    timeframes: [time, date, week, month]
    sql: ${TABLE}.observation_date ;;
  }

  dimension: id {
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: amount {
    type: number
    sql: ${TABLE}.amount ;;
  }

  dimension_group: close {
    type: time
    datatype: date
    description: "At the time of snapshot, what was the projected close date?"
    timeframes: [date, week, month]
    sql: EXTRACT(date from ${TABLE}.close_date) ;;
  }

  dimension: created_by_id {
    type: string
    sql: ${TABLE}.created_by_id ;;
  }

  dimension_group: created {
    type: time
    datatype: date
    timeframes: [date, week, month]
    sql: ${TABLE}.created_date ;;
  }

  dimension: expected_revenue {
    type: number
    sql: ${TABLE}.expected_revenue ;;
  }

  dimension: forecast_category {
    type: string
    sql: ${TABLE}.forecast_category ;;
  }

  dimension: is_deleted {
    type: string
    sql: ${TABLE}.is_deleted ;;
  }

  dimension: opportunity_id {
    type: string
    sql: ${TABLE}.opportunity_id ;;
  }

  dimension: probability {
    type: number
    sql: ${TABLE}.probability ;;
  }

  dimension: probability_tier {
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

  dimension: stage_name_funnel {
    alias: [stage_name]
    description: "At the time of snapshot, what funnel stage was the prospect in?"
    type: string
    sql: ${TABLE}.stage_name ;;
  }

  dimension_group: system_modstamp {
    type: time
    sql: ${TABLE}.system_modstamp ;;
  }

  dimension_group: stage_end {
    type: time
    datatype: date
    hidden: yes
    timeframes: [time, date, week, month]
    sql: ${TABLE}.stage_end ;;
  }

  measure: total_amount {
    type: sum
    description: "At the time of snapshot, what was the total projected ACV?"
    sql: ${amount} ;;
    value_format: "$#,##0"
    drill_fields: [account.name, snapshot_date, close_date, amount, probability, stage_name_funnel]
  }

  measure: count_opportunities {
    type: count_distinct
    sql: ${opportunity_id} ;;
  }

  set: detail {
    fields: [
      snapshot_date,
      id,
      amount,
      created_by_id,
      expected_revenue,
      forecast_category,
      opportunity_id,
      probability,
      stage_name_funnel,

    ]
  }
}
