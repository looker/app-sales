
explore: opportunity_core {
  extension: required
  view_name: opportunity
  fields: [ALL_FIELDS*]
  sql_always_where: NOT ${opportunity.is_deleted} ;;

    join: opportunity_stage {
      sql_on: ${opportunity_stage.api_name} = ${opportunity.stage_name} ;;
      relationship: one_to_one
    }
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
      sql_on: ${opportunity.owner_id} = ${opportunity_owner.id} ;;
      relationship: many_to_one
    }
    join: manager {
      from: user
      sql_on: ${opportunity_owner.manager_id} = ${manager.id};;
      fields: []
      relationship: many_to_one
    }
    join: task {
      sql_on: ${opportunity.id} = ${task.what_id} ;;
      relationship: one_to_many
    }
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
    #   join: pipeline_comparison {
#     sql_on: ${pipeline_comparison.owner_id} = ${comparison.owner_id} ;;
#     relationship: one_to_one
#   }
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
}
