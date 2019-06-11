view: opportunity_history_days_in_current_stage_core {
  derived_table: {
    sql:
    WITH stage_changes AS (

    -- Get the created date for every opportunity
    SELECT DISTINCT id as opportunity_id, created_date
    FROM {{ schema_name._sql }}.opportunity -- If schema is not named "salesforce" then need to change

    UNION ALL

    -- Get the date that every change to StageName from opportunity history for each id
    SELECT DISTINCT opportunity_id, created_date
    FROM {{ schema_name._sql }}.opportunity_field_history -- If schema is not named "salesforce" then need to change
    WHERE field = 'StageName'
    )

    SELECT opportunity_id, MAX(created_date) as most_recent_stage_change
    FROM stage_changes
    GROUP BY 1 ;;
  }

  dimension: schema_name {
    sql: salesforce ;;
  }

  dimension_group: most_recent_stage_change {
    type: time
    datatype: timestamp
    sql: ${TABLE}.most_recent_stage_change ;;
    hidden: yes
  }

  dimension: opportunity_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.opportunity_id ;;
  }
}
