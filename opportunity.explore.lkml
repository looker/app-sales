
explore: opportunity_core {
  extension: required
  view_name: opportunity
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

  }
