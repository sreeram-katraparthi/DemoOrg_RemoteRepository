({
	changeStatusToInDistribution : function(component,event,helper) {
        var recid = component.get("v.view.prid");
        var status = component.get("v.view.releaseStatus");
        var action = component.get("c.changeStatusOfPackage");
        var ignoreBoolcheck= component.get("v.ignoreActionOnly");
        
        action.setParams({
            "lstOfrecId": recid,
            "onlyIgnCheck" : ignoreBoolcheck
        });
        action.setCallback(this, function(response) {
            //alert("@@ response.getState()"+response.getState());
            if (response.getState() == "SUCCESS") {
            	var allValues = response.getReturnValue();
            }
        });
        //alert('@@ in helper ::::');
        $A.enqueueAction(action);
        component.set("v.modalBox",false);
        var event = component.getEvent("OnStatusChange");
        var country = component.get("v.view.country");
        event.setParams({"refreshPacks": true});
        event.setParams({"Packages": country});
        event.setParams({"recId":recid});
		event.fire();
	},
})