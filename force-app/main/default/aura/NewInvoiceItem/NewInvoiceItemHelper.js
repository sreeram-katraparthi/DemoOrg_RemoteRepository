({
	showToast : function(component, event, helper) {
        alert('** in showtoast **');
        var toastEvent = $A.get("e.force:showToast");
        alert('** toastEvent **'+toastEvent);
        toastEvent.setParams({
            "title": "Success!",
            "message": "Record is inserted and List will be updated."
        });
        toastEvent.fire();
    }
})