({
    doInit: function (component, event, helper) {
        // Set the columns of the Table 
        component.set('v.isSending',true);
        component.set('v.columns', [
            {label: 'Contact Name', fieldName: 'conName', type: 'text', sortable : true},
            {label: 'Title', fieldName: 'Title', type: 'text', sortable : true},
            {label: 'Email', fieldName: 'Email', type: 'email', sortable : true},
            {label: 'Mobile Phone', fieldName: 'accWebsite', type: 'phone', sortable : true},
            {label: 'Account Industry', fieldName: 'accIndustry', type: 'text', sortable : true},
        ]);
            helper.doFetchContact(component);
    },
  getSelectedName: function (component, event) {
            var selectedRows = event.getParam('selectedRows');
            // Display that fieldName of the selected rows
            for (var i = 0; i < selectedRows.length; i++){
            //alert("You selected: " + selectedRows[i].Name);
    }
   },
 next: function (component, event, helper) {
    helper.next(component, event);
},
    previous: function (component, event, helper) {
    helper.previous(component, event);
},
})