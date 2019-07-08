view: manager_quota_core {

  derived_table: {
    explore_source: opportunity {
      column: manager { field: opportunity_owner.manager }
      column: manager_id { field: manager.id }
      column: quota_start_date { field: quota.quota_start_date }
      column: total_quota { field: quota.total_quota }
    }
  }
  dimension: manager {}
  dimension: manager_id {}
  dimension: quota_start_date {
    description: "The first date of the Quotas effective period"
  }
  dimension: total_quota {
    label: "Opportunity Owner Total Quota"
    description: "The Quota aggregated for the group selected"
    type: number
  }

}
