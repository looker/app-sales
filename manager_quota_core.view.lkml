view: manager_quota_core {
  derived_table: {
    explore_source: opportunity {
      column: id { field: manager.id }
      column: manager { field: manager.manager }
      column: quota_start_fiscal_quarter { field: quota.quota_start_fiscal_quarter }
      column: total_quota { field: quota.total_quota }
    }
  }
  dimension: id { hidden: yes }
  dimension: manager {}
  dimension: quota_start_fiscal_quarter {
    type: date_fiscal_quarter
    convert_tz: no
  }
  dimension: total_quota {
    label: "Manger Quarterly Total Quota"
    type: number
  }
}
