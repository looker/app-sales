# Placeholder derived table that's being used exclusively for the QoQ Percent to Goal viz on the Sales Leadership Dash
view: quota_quarter_goals {
  derived_table: {
    sql:
        SELECT '2019-Q1' as quarter, 35000000 as quota
        UNION ALL
        SELECT '2018-Q4' as quarter, 35000000 as quota
        UNION ALL
        SELECT '2018-Q3' as quarter, 35000000 as quota
        UNION ALL
        SELECT '2018-Q2' as quarter, 35000000 as quota
        UNION ALL
        SELECT '2018-Q1' as quarter, 35000000 as quota
       ;;
   }

  dimension: quarter {
    type: string
    primary_key: yes
  }

  dimension: quota {
    type: number
  }

  measure: quota_sum {
    type: sum
    sql: ${quota} ;;
  }
}
