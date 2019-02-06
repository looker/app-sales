# Used for the Pipeline Report Viz on the "Pipeline Management" Dashboard
view: calendar {
  derived_table: {
    sql: SELECT *
      FROM UNNEST(GENERATE_DATE_ARRAY(DATE_ADD(CURRENT_DATE(), INTERVAL -4 QUARTER),CURRENT_DATE(), INTERVAL 1 DAY)) as generated_date
       ;;
  }

  dimension_group: generated {
    type: time
    datatype: date
    timeframes: [date,raw]
    convert_tz: no # no time data, timezone conversions not necessary
    sql: ${TABLE}.generated_date ;;
  }

  dimension: pk {
    primary_key: yes
    sql: ${generated_raw} ;;
  }
}
