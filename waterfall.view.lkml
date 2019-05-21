
# If necessary, uncomment the line below to include explore_source.
# include: "sales_analytics.model.lkml"

view: waterfall_derived {
  derived_table: {
    persist_for: "24 hours"

    explore_source: opportunity_history_waterfall {
      column: opportunity { field: opportunity.name }
      column: owner { field: opportunity_owner.name }
      column: stage_name { field: opportunity.stage_name }
      column: source { field: opportunity.source }
      column: business_segment { field: account.business_segment }
      column: is_pipeline { field: opportunity.is_pipeline }
      column: total_amount { field: opportunity.total_amount }

      column: starting_pipeline {}
      column: new_opportunities {}
      column: date_changed_in {}
      column: date_changed_out {}
      column: value_changed_increased {}
      column: value_change_decreased {}
      column: closed_lost {}
      column: closed_won {}
      filters: {
        field: opportunity_history_waterfall.pipeline_dates
        value: "last fiscal quarter"
      }
    }
  }
  dimension: opportunity {
    label: "Opportunity"
  }
  dimension: owner {
    label: "Owner Name"
  }
  dimension: stage_name {
    label: "Stage Name"
  }
  dimension: source {
    label: "Source"
  }
  dimension: business_segment {}
  dimension: is_pipeline {
    label: "Is Pipeline"
    type: yesno
  }
  dimension: total_amount {
    label: "Total ACV "
    value_format_name: custom_amount_value_format
    type: number
  }

  dimension: starting_pipeline {
    label: "Pipeline"
    value_format: "[>=1000000]$0.0,,'M';[>=1000]$0,'K';$0.00"
    type: number
  }
  dimension: new_opportunities {
    label: "New Opportunities"
    value_format: "[>=1000000]$0.0,,'M';[>=1000]$0,'K';$0.00"
    type: number
  }
  dimension: date_changed_in {
    label: "Moved In"
    value_format: "[>=1000000]$0.0,,'M';[>=1000]$0,'K';$0.00"
    type: number
  }
  dimension: date_changed_out {
    label: "Moved Out"
    value_format: "[<=-1000000]-$0.00,,'M';[<=-1000]-$0.00,'K';-$0.00"
    type: number
  }
  dimension: value_changed_increased {
    label: "Increased"
    value_format: "[>=1000000]$0.0,,'M';[>=1000]$0,'K';$0.00"
    type: number
  }
  dimension: value_change_decreased {
    label: "Decreased"
    value_format: "[>=1000000]$0.0,,'M';[>=1000]$0,'K';$0.00"
    type: number
  }
  dimension: closed_lost {
    label: "Lost"
    value_format: "[<=-1000000]-$0.00,,'M';[<=-1000]-$0.00,'K';-$0.00"
    type: number
  }
  dimension: closed_won {
    label: "Won"
    value_format: "[<=-1000000]-$0.00,,'M';[<=-1000]-$0.00,'K';-$0.00"
    type: number
  }
  dimension: end_pipeline {
    label: "Remain Open"
    value_format: "[<=-1000000]-$0.00,,'M';[<=-1000]-$0.00,'K';-$0.00"
    type: number
  }
}
