view: contact_core {
  extension: required
  extends: [contact_adapter]
  # dimensions #

  dimension_group: _fivetran_synced { hidden: yes }

  dimension: mailing_city { group_label: "Mailing Details" }
  dimension: mailing_country { group_label: "Mailing Details" }
  dimension: mailing_geocode_accuracy { group_label: "Mailing Details" }
  dimension: mailing_latitude { group_label: "Mailing Details" }
  dimension: mailing_longitude { group_label: "Mailing Details" }
  dimension: mailing_postal_code { group_label: "Mailing Details" }
  dimension: mailing_state { group_label: "Mailing Details" }
  dimension: mailing_street { group_label: "Mailing Details" }

  dimension: other_city { group_label: "Other Contact Details" }
  dimension: other_country { group_label: "Other Contact Details" }
  dimension: other_geocode_accuracy { group_label: "Other Contact Details" }
  dimension: other_latitude { group_label: "Other Contact Details" }
  dimension: other_longitude { group_label: "Other Contact Details" }
  dimension: other_phone { group_label: "Other Contact Details" }
  dimension: other_postal_code { group_label: "Other Contact Details" }
  dimension: other_state { group_label: "Other Contact Details" }
  dimension: other_street { group_label: "Other Contact Details" }

  dimension: name {
    html: <a href="mailto:{{ contact.email._value }}" target="_blank">
        <img src="https://upload.wikimedia.org/wikipedia/commons/4/4e/Gmail_Icon.png" width="16" height="16" />
      </a>
      {{ linked_value }}
      ;;
  }

  dimension_group: system_modstamp { hidden: yes }

  # measures #

  measure: count { label: "Number of Contacts" }
}
