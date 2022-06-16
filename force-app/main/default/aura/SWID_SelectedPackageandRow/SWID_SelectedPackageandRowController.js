({
    dispCols : function(component, event, helper){        
        var checkState = component.get("v.view.releaseStatus");
        if(checkState == 'PENDING'||checkState == 'TEST'){
            component.set("v.rdyTabState",true);
            if(checkState == 'PENDING'){                
                component.set("v.showIgnrBtn",false);
            }
        }else if(checkState == 'IN DISTRIBUTION'){
            component.set("v.inDTabState",true);
        }else if(checkState == 'DELETED'){
            component.set("v.delTabState",true);
        }else if(checkState == 'IGNORED'){
            component.set("v.ignTabState",true);
        }
    },
    
    checkboxSelect : function(component, event, helper) {
        var isSelected = component.get("v.selected");
        var skipLocRel = component.get("v.view.skipLocRel");
        var addAutoRelIcon = component.get("v.autoRel");
        
        //To highlite the background Colour of the selected Row
        if(isSelected == false){
            component.set("v.selected",true);
        }else{
            component.set("v.selected",false);
        } 
        
        //fire the event to enable buttons on selection of a record
        var enableButtonsEvnet = component.getEvent("OnRecSelection");
        var firstselect = event.getSource().get("v.value");
        var status = component.get("v.view.releaseStatus");
        var varRecId = component.get("v.view.prid");
        enableButtonsEvnet.setParams({"Packages": status});
        enableButtonsEvnet.setParams({"recId":varRecId});
        if(firstselect == true){
            enableButtonsEvnet.setParams({ "enblButtons": true });
            enableButtonsEvnet.fire();
        }else{
            enableButtonsEvnet.setParams({ "enblButtons": false });
            enableButtonsEvnet.fire();
        }            
    },
    
    navigateToPackDetails : function(component, event, helper){
        var currentRecordId = component.get("v.view.packageId");
        var currentRecordId = component.set("v.showDetailWindow",true);
        var cmpTarget = component.find('Modalbox');
        $A.util.addClass(cmpTarget, 'slds-fade-in-open');
        //component.set("v.modalStyle", "<style>.forceStyle .viewport .oneHeader {z-index:0; } .slds-global-header_container {position: static;} .forceStyle.desktop .viewport{overflow:hidden}</style>");
        
    },    
    ReadyTabLocalRelease : function(component, event, helper){
        var currentRecordId = component.get("v.view.packageId");
        helper.changeStatusToInDistribution(component, event, helper);        
    },
    closeWindow:function(component, event, helper) {
        component.set("v.showDetailWindow",false);
    },
    closeModal:function(component, event, helper) {
        component.set("v.modalBox",false);
    },
    
    detail_LocRelAction_Ready:function(component, event, helper) {
        //alert('Detail window Button selected !!');
        component.set("v.btnActionName",'Local Release');
        component.set("v.actionVal",'released');
        component.set("v.showDetailWindow",false);
        component.set("v.modalBox",true);
    },
    detail_TestRelAction:function(component, event, helper) {
        //alert('Detail window Button selected !!');
        component.set("v.btnActionName",'Test Release');
        component.set("v.actionVal",'test released');
        component.set("v.showDetailWindow",false);
        component.set("v.modalBox",true);
    },
    detail_IgnoreAction:function(component, event, helper) {
        //alert('Detail window Button selected !!');
        component.set("v.btnActionName",'Ignore');
        component.set("v.actionVal",'Ignored');
        component.set("v.showDetailWindow",false);        
        component.set("v.ignoreActionOnly",true);
        component.set("v.modalBox",true);
    },
    
    detail_DeleteLocalRelAction:function(component, event, helper) {
        //alert('DETELE ACTION CHECK');
        component.set("v.btnActionName",'Delete Local Release');
        component.set("v.showDetailWindow",false);
        component.set("v.actionVal",'deleted');
        component.set("v.modalBox",true);
    },
    detail_LocalRelAction_Delete:function(component, event, helper) {
        //alert('Detail window Button selected !!');
        component.set("v.btnActionName",'Local Release');
        component.set("v.showDetailWindow",false);
        component.set("v.actionVal",'released');
        component.set("v.modalBox",true);
    },
    detail_UnIgnoreAction:function(component, event, helper) {
        //alert('Detail window Button selected !!');
        component.set("v.btnActionName",'Unignore');
        component.set("v.showDetailWindow",false);        
		component.set("v.actionVal",'Unignored');
        
        component.set("v.modalBox",true);
    },
    testDistTab:function(component, event, helper) {
        //
    },
    logsTab:function(component, event, helper) {
        //
    }
})