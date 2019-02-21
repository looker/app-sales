view: task_core {
  extends: [task_adapter]
  extension: required


  measure: emails {
    type: count
    filters: {
      field: type
      value: "Email"
    }
  }

  measure: calls {
    type: count
    filters: {
      field: type
      value: "Call"
    }
  }

  measure: meetings {
    type: count
    filters: {
      field: type
      value: "Meeting"
    }
  }



}
