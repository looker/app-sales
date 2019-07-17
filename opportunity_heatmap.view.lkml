explore: heatmap {}

view: heatmap {
  derived_table: {
    explore_source: opportunity {
      column: name {}
      column: days_open {}
      column: amount {}
      column: x_coordinate { field: opportunity_heatmap_days_open_tier.x_coordinate }
      column: y_coordinate { field: opportunity_heatmap_amount_tier.y_coordinate }
      column: win_percentage { field: opportunity_heatmap_historical_win_percentages.win_percentage }
      filters: {
        field: opportunity.is_closed
        value: "No"
      }
      filters: {
        field: opportunity.close_date
        value: "this fiscal quarter"
      }
      filters: {
        field: opportunity.is_new_business
        value: "Yes"
      }
      filters: {
        field: opportunity_heatmap_days_open_tier.x_coordinate
        value: "-NULL"
      }
      filters: {
        field: opportunity_heatmap_amount_tier.y_coordinate
        value: "-NULL"
      }
    }
  }
  dimension: name {}
  dimension: days_open {
    description: "Number of days from opportunity creation to close. If not yet closed, this uses today's date."
    type: number
  }
  dimension: amount {
    label: "Opportunity ACV "
    value_format: "[>=1000000]$0.0,,\"M\";[>=1000]$0,\"K\";$0.00"
    type: number
  }
  dimension: x_coordinate {}
  dimension: y_coordinate {}
  dimension: win_percentage {
    type: number
    sql: ROUND(${TABLE}.win_percentage*100,2) ;;
  }
}


######################## HELPER NDTs ########################

view: opportunity_heatmap_historical_win_percentages {
  derived_table: {
    explore_source: opportunity {
      column: x_coordinate { field: opportunity_heatmap_days_open_tier.x_coordinate }
      column: y_coordinate { field: opportunity_heatmap_amount_tier.y_coordinate }
      column: win_percentage {}
      filters: {
        field: opportunity_heatmap_days_open_tier.x_coordinate
        value: "-NULL"
      }
      filters: {
        field: opportunity_heatmap_amount_tier.y_coordinate
        value: "-NULL"
      }
    }
  }
  dimension: x_coordinate {}
  dimension: y_coordinate {}
  dimension: win_percentage {
    value_format: "#,##0.0%"
    type: number
  }
}

view: opportunity_heatmap_days_open_tier {
  derived_table: {
    explore_source: opportunity {
      column: days_open_tier {}
      derived_column: x_coordinate {
        sql: ROW_NUMBER() OVER (ORDER BY opportunity_days_open_tier__sort_ ASC) - 1 ;;
      }
      filters: {
        field: opportunity.days_open
        value: ">=0"
      }
      filters: {
        field: opportunity.days_open_tier
        value: "-%inf)"
      }
    }
  }

  dimension: days_open_tier {}
  dimension: x_coordinate {}
}

view: opportunity_heatmap_amount_tier {
  derived_table: {
    explore_source: opportunity {
      column: amount_tier {}
      derived_column: y_coordinate {
        sql: ROW_NUMBER() OVER (ORDER BY opportunity_amount_tier__sort_ ASC) - 1 ;;
      }
      filters: {
        field: opportunity.amount
        value: ">=0"
      }
      filters: {
        field: opportunity.amount_tier
        value: "-%inf)"
      }
    }
  }

  dimension: amount_tier {}
  dimension: y_coordinate {}
}
