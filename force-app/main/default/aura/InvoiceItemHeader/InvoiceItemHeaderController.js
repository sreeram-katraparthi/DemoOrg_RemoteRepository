({
    doInit : function(component, event, helper) {
        helper.doInit(component, event, helper);
    },
    OpenPopup : function(component, event, helper){
        component.set("v.isOpen", "true");
    },
    handleComponentEvent : function(component, event, helper){
        var closeModal = event.getParam("isOpen");
        component.set("v.isOpen", closeModal);
        helper.isRefreshed(component, event, helper);
    },    
})