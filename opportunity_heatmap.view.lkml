# If necessary, uncomment the line below to include explore_source.
# include: "sales_analytics.model.lkml"

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
