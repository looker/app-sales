view: opportunity_stage_core {
  extends: [opportunity_stage_adapter]

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
