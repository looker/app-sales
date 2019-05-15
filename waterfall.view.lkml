
# If necessary, uncomment the line below to include explore_source.
# include: "sales_analytics.model.lkml"

view: waterfall_derived {
  derived_table: {
    explore_source: opportunity_history_waterfall {
      column: opportunity { field: opportunity.name }
      column: owner { field: opportunity_owner.name }
      column: stage_name { field: opportunity.stage_name }
      column: source { field: opportunity.source }
      column: business_segment { field: account.business_segment }
      column: is_pipeline { field: opportunity.is_pipeline }
      column: total_amount { field: opportunity.total_amount }

      column: starting_pipeline {}
      column: starting_pipeline_count {
        field:  opportunity_history_waterfall.starting_pipeline_opp_count
      }
      column: new_opportunities {}
      column: new_opportunities_count {
        field:  opportunity_history_waterfall.new_opp_count
      }
      column: date_changed_in {}
      column: date_changed_in_count {}
      column: date_changed_out {}
      column: date_changed_out_count {}
      column: value_changed_increased {}
      column: value_changed_increased_count {}
      column: value_change_decreased {}
      column: value_changed_decreased_count {}
      column: closed_lost {}
      column: closed_lost_count {}
      column: closed_won {}
      column: closed_won_count {}
      column: end_pipeline {}
      column: end_pipeline_count {
        field: opportunity_history_waterfall.end_opp_count
      }
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
    label: "Opportunity History Waterfall Pipeline"
    value_format: "[>=1000000]$0.0,,'M';[>=1000]$0,'K';$0.00"
    type: number
  }
  dimension: starting_pipeline_count {
    label: "Opportunity History Waterfall Pipeline Count"
    type: number
  }

  dimension: new_opportunities {
    label: "Opportunity History Waterfall New Opps"
    value_format: "[>=1000000]$0.0,,'M';[>=1000]$0,'K';$0.00"
    type: number
  }
  dimension: new_opportunities_count {
    label: "Opportunity History Waterfall New Opps Count"
    type: number
  }

  dimension: date_changed_in {
    label: "Opportunity History Waterfall Moved In"
    value_format: "[>=1000000]$0.0,,'M';[>=1000]$0,'K';$0.00"
    type: number
  }
  dimension: date_changed_in_count {
    label: "Opportunity History Waterfall Moved In Count"
    type: number
  }

  dimension: date_changed_out {
    label: "Opportunity History Waterfall Moved Out"
    value_format: "[<=-1000000]-$0.00,,'M';[<=-1000]-$0.00,'K';-$0.00"
    type: number
  }
  dimension: date_changed_out_count {
    label: "Opportunity History Waterfall Moved Out Count"
    type: number
  }

  dimension: value_changed_increased {
    label: "Opportunity History Waterfall Increased"
    value_format: "[>=1000000]$0.0,,'M';[>=1000]$0,'K';$0.00"
    type: number
  }
  dimension: value_changed_increased_count {
    label: "Opportunity History Waterfall Increased Count"
    type: number
  }

  dimension: value_change_decreased {
    label: "Opportunity History Waterfall Decreased"
    value_format: "[>=1000000]$0.0,,'M';[>=1000]$0,'K';$0.00"
    type: number
  }
  dimension: value_changed_decreased_count {
    label: "Opportunity History Waterfall Decreased Count"
    type: number
  }

  dimension: closed_lost {
    label: "Opportunity History Waterfall Lost"
    value_format: "[<=-1000000]-$0.00,,'M';[<=-1000]-$0.00,'K';-$0.00"
    type: number
  }
  dimension: closed_lost_count {
    label: "Opportunity History Waterfall Lost Count"
    type: number
  }

  dimension: closed_won {
    label: "Opportunity History Waterfall Won"
    value_format: "[<=-1000000]-$0.00,,'M';[<=-1000]-$0.00,'K';-$0.00"
    type: number
  }
  dimension: closed_won_count {
    label: "Opportunity History Waterfall Won Count"
    type: number
  }

  dimension: end_pipeline {
    label: "Opportunity History Waterfall Remain Open"
    value_format: "[<=-1000000]-$0.00,,'M';[<=-1000]-$0.00,'K';-$0.00"
    type: number
  }
  dimension: end_pipeline_count {
    label: "Opportunity History Waterfall Remain Open Count"
    type: number
  }
}
