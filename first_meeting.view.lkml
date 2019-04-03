view: first_meeting {
  derived_table: {
    explore_source: opportunity {
      filters: {field: task.is_meeting value: "Yes"}
      column: opportunity_id {field:opportunity.id}
      column: meeting_date {field:task.activity_raw}
      derived_column: first_meeting {
        sql: FIRST_VALUE (meeting_date) OVER (PARTITION BY opportunity_id order by meeting_date rows between unbounded preceding and unbounded following)  ;;
      }}}
dimension: first_meeting {type: date_raw hidden:yes}
dimension: opportunity_id {primary_key: yes}
}
