({
    doInit: function(component, event, helper) {
        helper.fetchPickListVal(component, 'CustomerPriority__c', 'custPriority');//CleanStatus
    },
    onPicklistChange: function(component, event, helper) {
        // get the value of select option
        alert(event.getSource().get("v.value"));
        var sel = component.find("custPriority");
        var nav = sel.get("v.value");
        if(nav != null || nav !=  "--- None ---"){
        	component.set("v.dispTabs",true);   	
        }
    },   
})