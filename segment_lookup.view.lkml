##########################################################################################################
## Used to fetch the segment of the rep in question                                                     ##
##########################################################################################################
view: segment_lookup {
  derived_table: {
    explore_source: opportunity {
      bind_filters: {
        from_field: opportunity_owner.name_select
        to_field: opportunity_owner.name
      }
      column: segment_grouping {
        field: quota.segment_grouping
      }
    }
  }

  dimension: segment_grouping {
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.segment_grouping ;;
  }

  dimension: is_in_same_segment_as_specified_user {
    type: yesno
    hidden: yes
    sql: ${segment_grouping} = ${quota.segment_grouping} ;;
  }

  dimension: grouping {
    type: string
    sql: CASE WHEN {% condition opportunity_owner.name_select %} ${opportunity_owner.name} {% endcondition %} THEN ${opportunity_owner.name}
          WHEN ${is_in_same_segment_as_specified_user} THEN CONCAT('Rest of ', ${segment_grouping})
          ELSE 'Rest of Company'
          END;;
    order_by_field: grouping_sort
  }

  dimension: grouping_sort {
    hidden: yes
    sql: CASE WHEN {% condition opportunity_owner.name_select %} ${opportunity_owner.name} {% endcondition %} THEN 1
          WHEN ${is_in_same_segment_as_specified_user} THEN 2
          ELSE 3
          END;;
  }
}
