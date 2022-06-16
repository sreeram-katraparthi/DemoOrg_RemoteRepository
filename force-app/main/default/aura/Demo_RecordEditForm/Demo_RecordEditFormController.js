({
    handleOnload : function(component, event, helper) {
        
        var recUi = event.getParam("recordUi");
        //alert('** recUi at first onload method **'+recUi);
        console.assert(null === recUi.record.id);
        
         console.assert(null === recUi.record.fields["Account"].displayValue);
        console.assert(null === recUi.record.fields["Account"].value);
        
         console.assert("Account" === recUi.objectInfos["Account"].label);
    },
    /*handleOnload : function(component, event, helper) {
        var recUi = event.getParam("recordUi");
        alert('** recUi.record.id **'+recUi.record.id);
        console.assert(null !== recUi.record.id);
        
        console.assert(recUi.record.fields["Account"].value.fields.Name === recUi.record.fields["Account"].displayValue);
        console.assert(recUi.record.fields["Account"].value.id === recUi.record.fields["AccountId"].value);
        console.assert(recUi.record.fields["Account"].value.fields.id === recUi.record.fields["AccountId"].value);
        console.assert(recUi.record.fields["Account"].id === recUi.record.fields["AccountId"].value);
    },
    handleOnload : function(component, event, helper) {
        var parentId = component.get("v.parentId");
        
        // requires inputFields to have aura:id
        component.find("accountLookup").set("v.value", parentId);
        component.find("departmentText").set("v.value", "Accounting");
    },*/
    handleOnSubmit : function(component, event, helper) {
        event.preventDefault();
        var fields = event.getParam("fields");
        fields["AccountId"] = component.get("v.parentId");
        component.find("form").submit(fields);
    },
    /*handleOnSubmit : function(component, event, helper) {
    var fields = event.getParam("fields");
    fields["AccountId"] = component.get("v.parentId");
},*/
    handleOnSuccess : function(component, event, helper) {
        var record = event.getParam("response");
        component.find("notificationsLibrary").showToast({
            "title": "Saved",
            "message": "{0} saved for {1}",
            "messageData": [
                {
                    url: '/' + record.id,
                    label: record.fields.FirstName.value + ' ' + record.fields.LastName.value
                },
                {
                    url: '/' + record.fields.AccountId.value,
                    label: record.fields.Account.displayValue
                }
            ]
        });
    },
    
})