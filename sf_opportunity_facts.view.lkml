view: sf_opportunity_facts {
  derived_table: {
    datagroup_trigger: fivetran_synced
    sql: SELECT account_id AS account_id
        , SUM(CASE
                WHEN stage_name = 'Closed Won'
                THEN 1
                ELSE 0
              END) AS opportunities_won
        , SUM(CASE
                WHEN stage_name = 'Closed Won'
                THEN amount
                ELSE 0
              END) AS all_time_amount
      FROM `salesforce.opportunity`
      GROUP BY 1
       ;;
  }

  # DIMENSIONS #

  dimension: account_id {
    hidden: yes
    primary_key: yes
    sql: ${TABLE}.account_id ;;
  }

  dimension: lifetime_opportunities_won {
    view_label: "Account"
    type: number
    sql: ${TABLE}.opportunities_won ;;
  }

  dimension: lifetime_won_amount {
    view_label: "Account"
    label: "Lifetime Opportunity Won Amount"
    type: number
    sql: ${TABLE}.all_time_amount ;;
  }
}
