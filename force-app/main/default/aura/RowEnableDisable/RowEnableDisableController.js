({
    
    fetchAccounts : function(component, event, helper) {
        component.set('v.mycolumns', [
            {label: 'Account Name', fieldName: 'accName', type: 'text'},
            {label: 'Industry', fieldName: 'accIndustry', type: 'text'},
            {label: 'Type', fieldName: 'accType', type: 'text'},
            {label: 'Active?', fieldName: 'accActive', type: 'text'},
            {type: "button", typeAttributes: {
                label: 'View',
                name: 'View',
                title: 'View',
                disabled: { fieldName: 'isActive'},
                value: 'view',
                iconPosition: 'left'
            }}
        ]);
        var action = component.get("c.fetchAccts");
        action.setParams({
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.acctList", response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
    },
    viewRecord : function(component, event, helper) {
        var recId = event.getParam('row').accId;
        var actionName = event.getParam('action').name;
        if ( actionName == 'View') {
            var viewRecordEvent = $A.get("e.force:navigateToURL");
            viewRecordEvent.setParams({
                "url": "/" + recId
            });
            viewRecordEvent.fire();
        }
    }
    
})