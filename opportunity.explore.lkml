
explore: opportunity_core {
  extension: required
  view_name: opportunity
  fields: [ALL_FIELDS*]
  sql_always_where: NOT ${opportunity.is_deleted} ;;

    join: account {
      sql_on: ${opportunity.account_id} = ${account.id} ;;
      relationship: many_to_one
    }
    join: sf_opportunity_facts {
      sql_on: ${account.id} = ${sf_opportunity_facts.account_id}  ;;
      relationship: one_to_one
    }
    join: account_owner {
      from: user
      sql_on: ${account.owner_id} = ${account_owner.id} ;;
      relationship: many_to_one
    }
    join: campaign {
      sql_on: ${opportunity.campaign_id} = ${campaign.id} ;;
      relationship: many_to_one
    }
    join: opportunity_owner {
      from: user
      type: full_outer # Needed full outer here since we want to include reps in quota aggregations (regardless of whether they have an opp registered or not)
      sql_on: ${opportunity.owner_id} = ${opportunity_owner.id} ;;
      relationship: many_to_one
    }
    join: manager {
      from: user
      sql_on: ${opportunity_owner.manager_id} = ${manager.id};;
      relationship: many_to_one
    }
    join: task {
      sql_on: ${opportunity.id} = ${task.what_id} ;;
      relationship: one_to_many
    }
    join: opportunity_stage_history {
      sql_on:  ${opportunity.id} = ${opportunity_stage_history.opportunity_id} ;;
      relationship: one_to_one
    }
    join: opportunity_history_days_in_current_stage {
      view_label: "Opportunity"
      type: left_outer
      relationship: one_to_one
      sql_on: ${opportunity_history_days_in_current_stage.opportunity_id} = ${opportunity.id} ;;
    }
    join: user_age {
      view_label: "Opportunity Owner"
      sql_on: ${user_age.owner_id} = ${opportunity_owner.id} AND ${user_age.opportunity_id} = ${opportunity.id};;
      relationship: many_to_many
    }

    join: segment_lookup {
      type: left_outer
      sql_on: ${segment_lookup.segment_grouping} = ${quota.segment_grouping} ;;
      relationship: many_to_one
    }

    join: account_facts_start_date {
      view_label: "Account Facts"
      sql_on: ${account_facts_start_date.account_id} = ${account.id} ;;
      relationship: one_to_one
    }

    join: account_facts_customer_lifetime_value {
      view_label: "Account Facts"
      sql_on: ${account_facts_customer_lifetime_value.account_id} = ${account.id} ;;
      relationship: one_to_one
    }

    join: quota {
      view_label: "Quota"
      sql_on: ${quota.name} = ${opportunity_owner.name} ;;
      relationship: one_to_one
    }

    join: aggregate_quota {
      sql_on: ${aggregate_quota.quota_start_fiscal_quarter} = ${opportunity.close_fiscal_quarter}  ;;
      relationship: many_to_one
    }
#     join: quota_aggregation {
#       view_label: "Quota"
#       sql_on: ${quota_aggregation.ae_segment} = ${quota.ae_segment} ;;
#       relationship: one_to_one
#     }

    join: new_deal_size_comparison {
      view_label: "Comparison"
      sql_on: ${new_deal_size_comparison.owner_id} = ${opportunity_owner.id} ;;
      relationship: one_to_one
    }

    join: win_percentage_comparison {
      view_label: "Comparison"
      sql_on: ${win_percentage_comparison.owner_id} = ${opportunity_owner.id};;
      relationship: one_to_one
    }

    join: sales_cycle_comparison {
      view_label: "Comparison"
      sql_on:  ${sales_cycle_comparison.owner_id} = ${opportunity_owner.id};;
      relationship: one_to_one
    }
    join: total_amount_comparison {
      view_label: "Comparison"
      sql_on:  ${total_amount_comparison.owner_id} = ${opportunity_owner.id};;
      relationship: one_to_one
    }
    join: qtd_amount_comparison {
      view_label: "Comparison"
      sql_on:  ${qtd_amount_comparison.owner_id} = ${opportunity_owner.id};;
      relationship: one_to_one
    }

    join: ytd_amount_comparison {
      view_label: "Comparison"
      sql_on:  ${ytd_amount_comparison.owner_id} = ${opportunity_owner.id};;
      relationship: one_to_one
    }
    join: aggregate_comparison {
      view_label: "Comparison"
      type: cross
      relationship: one_to_one
    }
    join: new_deal_size_comparison_current {
      view_label: "Comparison Current"
      sql_on: ${new_deal_size_comparison_current.owner_id} = ${opportunity_owner.id} ;;
      relationship: one_to_one
    }
    join: win_percentage_comparison_current {
      view_label: "Comparison Current"
      sql_on: ${win_percentage_comparison_current.owner_id} = ${opportunity_owner.id};;
      relationship: one_to_one
    }
    join: sales_cycle_comparison_current {
      view_label: "Comparison Current"
      sql_on:  ${sales_cycle_comparison_current.owner_id} = ${opportunity_owner.id};;
      relationship: one_to_one
    }
    join: first_meeting {
      view_label: "Opportunity"
      sql_on: ${opportunity.id} = ${first_meeting.opportunity_id} ;;
      relationship: one_to_one
    }
    join: first_deal_closed {
      sql_on: ${first_deal_closed.opportunity_owner_id} = ${opportunity_owner.id} ;;
      relationship: one_to_one
    }
}
