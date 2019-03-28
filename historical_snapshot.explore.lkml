include: "historical_snapshot_core.view.lkml"

explore: historical_snapshot_core  {
  extension: required
  view_name: historical_snapshot
  label: "Historical Opportunity Snapshot"
  fields: [ALL_FIELDS*,-opportunity.opportunity_exclude_set*,-account.account_exclusion_set*]
  join: opportunity {
    view_label: "Current Opportunity State"
    sql_on: ${historical_snapshot.opportunity_id} = ${opportunity.id} ;;
    type: inner
    relationship: many_to_one
  }

#   join: opportunity_stage {
#     sql_on: ${opportunity_stage.api_name} = ${historical_snapshot.stage_name_funnel} ;;
#     relationship: one_to_one
#   }

  join: account {
    sql_on: ${opportunity.account_id} = ${account.id} ;;
    relationship: many_to_one
  }

  join: account_owner {
    from: user
    sql_on: ${account.owner_id} = ${account_owner.id} ;;
    relationship: many_to_one
  }

  join: manager {
    from: user
    sql_on: ${account_owner.manager_id} = ${manager.id};;
    fields: []
    relationship: many_to_one
  }
}
