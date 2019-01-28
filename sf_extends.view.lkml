# This file contains "extensions" of all your Salesforce views.
# This is where you can edit and override auto-generated field settings such as
# SQL definitions, front-end labels, hiding, grouping, and more.

include: "_*"

view: opportunity_stage {
  extends: [_opportunity_stage]

  dimension_group: _fivetran_synced { hidden: yes }
  dimension: id { hidden: yes }
  dimension: api_name { hidden: yes }
  dimension: created_by_id { hidden: yes }
  dimension_group: created { hidden: yes }
  dimension: default_probability { hidden: yes }
  dimension: description { hidden: yes }
  dimension: forecast_category { hidden: yes }
  dimension: forecast_category_name { hidden: yes }
  dimension: is_active { hidden: yes }
  dimension: is_closed { hidden: yes }
  dimension: is_won { hidden: yes }
  dimension: last_modified_by_id { hidden: yes }
  dimension_group: last_modified { hidden: yes }
  dimension: master_label { hidden: yes }
  dimension: sort_order { hidden: yes }
  dimension_group: system_modstamp { hidden: yes }

}

view: opportunity_history {
  extends: [_opportunity_history]

  dimension_group: _fivetran_synced { hidden: yes }
  dimension: created_by_id { hidden: yes }
  dimension_group: created { label: "Snapshot" }
  dimension: is_deleted { hidden: yes }
  dimension_group: system_modstamp { hidden: yes }
}
