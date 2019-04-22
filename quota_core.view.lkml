view: quota_core {

  filter: segment_select {
    suggest_dimension: ae_segment
    hidden:  yes
  }


  dimension: quota_effective_date_offset {
    type: number
    sql: 0 ;;
    }

  dimension: segment_grouping {
    type: string
    sql: ${ae_segment} ;;
  }


  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
    hidden: yes
    primary_key: yes
  }

  dimension: ae_segment {
    type: string
    sql: ${TABLE}.ae_segment ;;
  }

  dimension: quota_amount {
    label: "Yearly Quota"
    type: number
    hidden: no
    value_format_name: custom_amount_value_format
  }

  dimension: quarterly_quota {
    label: "Quota"
    type: number
    hidden: yes
    sql: ${quota_amount}/4 ;;
    description: "Quarterly Quota"
    value_format_name: custom_amount_value_format
  }

  measure: total_quota {
    type: sum
    label: "Total Quota"
    group_label: "Quota"
    view_label: "Opportunity Owner"
    sql:${quota_amount} ;;
    value_format_name: custom_amount_value_format
  }


### Aggregate Quotas are defined with a hardcoded value and are independent of the quotas table.

### Default Aggregate Quota
  dimension: aggregate_quota {
    type: number
    sql: 1000000 ;;
    hidden: yes
    value_format_name: custom_amount_value_format
  }

### Might need agg_quota as a measure or viz purposes
  measure: aggregate_quota_measure {
    type: max
    label: "Aggregate Quota"
    group_label: "Quota"
    view_label: "Opportunity Owner"
    sql: ${aggregate_quota} ;;
    value_format_name: custom_amount_value_format
  }

  measure: monthly_aggregate_quota_measure {
    type: number
    label: "Monthly Quota"
    group_label: "Quota"
    view_label: "Opportunity Owner"
    sql: ${aggregate_quota}/12 ;;
    value_format_name: custom_amount_value_format
  }

  measure: quarterly_aggregate_quota_measure {
    type: number
    label: "Quarterly Quota"
    group_label: "Quota"
    view_label: "Opportunity Owner"
    sql: ${aggregate_quota}/4 ;;
    value_format_name: custom_amount_value_format
  }

}



view: quota_aggregation {
  derived_table: {
    sql:
          SELECT ae_segment, sum(quota_amount) as segment_quota
          FROM ${quota.SQL_TABLE_NAME}
          GROUP BY 1
          ;;
  }
  dimension: ae_segment {hidden: yes}
  dimension: segment_quota {
    type:number
    value_format_name: custom_amount_value_format
    hidden: yes
  }
}
