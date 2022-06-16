({
    
    getValueFromLwc : function(component, event, helper) {
        //var closeWin = component.set("v.clsoeQAWindow",event.getParam('value'));
        var closeWin = event.getParam('value');
        $A.get("e.force:closeQuickAction").fire();
    }
   
})