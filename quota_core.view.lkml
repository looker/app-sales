# Quota Explore: Solely used for the Sales App Audit dashboard
explore: quota {
  fields: [ALL_FIELDS*, -quota.manager_quota]
}

view: quota_core {

  filter: segment_select {
    suggest_dimension: ae_segment
    hidden:  yes
  }

  dimension_group: quota_start {
    type: time
    datatype: date
    timeframes: [fiscal_quarter]
    sql: ${quota_start_date} ;;
  }

  dimension: quota_start_date {
    description: "The first date of the Quotas effective period"
    sql: ${TABLE}.quota_start_date ;;
  }


  dimension: quota_effective_date_offset {
    type: number
    sql: 0 ;;
    }

  dimension: segment_grouping {
    type: string
    sql: ${ae_segment} ;;
  }

  dimension: primary_key {
    type: string
    primary_key: yes
    sql: CONCAT(${name},${quota_start_date}) ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
    hidden: yes
  }

  dimension: ae_segment {
    type: string
    sql: ${TABLE}.ae_segment ;;
  }

  dimension: quota_amount {
    description: "An Individuals Quota for the quarter"
    label: "Quarterly Quota"
    type: number
    hidden: no
    value_format_name: custom_amount_value_format
    view_label: "Opportunity Owner"
  }

  dimension: yearly_quota {
    description: "An Individuals Quota for the year - Quarterly Quota * 4"
    label: "Yearly Quota"
    type: number
    hidden: yes
    sql: ${quota_amount}*4 ;;
    value_format_name: custom_amount_value_format
    view_label: "Opportunity Owner"
  }

  # Placeholder value in the core. This is expected to be configure in the config project
  dimension: manager_quota {
    type: number
    sql: 1000000 ;;
    value_format_name: custom_amount_value_format
  }

  measure: total_quota {
    description: "The Quota aggregated for the group selected"
    type: sum
    label: "Total Quota"
    group_label: "Quota"
    view_label: "Opportunity Owner"

    sql:${quota_amount} ;;
  }
}

view: aggregate_quota_core {
  derived_table: {
    sql:
     SELECT '2018-01-01' as quota_start_date, 10000000 as aggregate_quota
     UNION ALL
     SELECT '2018-04-01' as quota_start_date, 10000000 as aggregate_quota
     UNION ALL
     SELECT '2018-07-01' as quota_start_date, 10000000 as aggregate_quota
     UNION ALL
     SELECT '2018-10-01' as quota_start_date, 10000000 as aggregate_quota
     UNION ALL
     SELECT '2019-01-01' as quota_start_date, 10000000 as aggregate_quota
     UNION ALL
     SELECT '2019-04-01' as quota_start_date, 10000000 as aggregate_quota ;;
  }

  dimension: quota_start_date {
    primary_key: yes
    description: "The first date of the Quotas effective period"
    sql: ${TABLE}.quota_start_date ;;
  }

  dimension_group: quota_start {
    type: time
    datatype: date
    timeframes: [fiscal_quarter]
    sql: ${quota_start_date} ;;
  }

### Aggregate Quotas are defined with a hardcoded value and are independent of the quotas table.

### Default Aggregate Quota (represents a quaterly goal for the entire org)
  dimension: aggregate_quota {
    type: number
    description: "The Quota for the entire Sales Organization"
    label: "Aggregate Quota"
    sql: ${TABLE}.aggregate_quota ;;
    hidden: yes
    value_format_name: custom_amount_value_format
  }

### Might need agg_quota as a measure or viz purposes
  measure: monthly_aggregate_quota_measure {
    description: "The Quota for the entire Sales Organization - Monthly"
    type: number
    label: "Monthly Aggregate Quota"
    sql: ${quarterly_aggregate_quota_measure}/3 ;;
    value_format_name: custom_amount_value_format
  }

  measure: quarterly_aggregate_quota_measure {
    description: "The Quota for the entire Sales Organization - Quarterly"
    type: max
    label: "Quarterly Aggregate Quota"
    sql: ${aggregate_quota} ;;
    value_format_name: custom_amount_value_format
  }

  measure: yearly_aggregate_quota_measure {
    description: "The Quota for the entire Sales Organization - Yearly"
    type: number
    label: "Yearly Aggregate Quota"
    sql: ${quarterly_aggregate_quota_measure}*4 ;;
    value_format_name: custom_amount_value_format
  }
}

# view: quota_aggregation {
#   derived_table: {
#     sql:
#           SELECT ae_segment, sum(quota_amount) as segment_quota
#           FROM ${quota.SQL_TABLE_NAME}
#           GROUP BY 1
#           ;;
#   }
#   dimension: ae_segment {hidden: yes}
#   dimension: segment_quota {
#     type:number
#     value_format_name: custom_amount_value_format
#     hidden: yes
#   }
# }
