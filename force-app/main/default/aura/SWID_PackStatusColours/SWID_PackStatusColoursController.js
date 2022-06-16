({
    onLoad: function(component, event, helper) {
        //alert("@@@ from pack status init !!")
        console.log('colorCmp load');
        //var sName = component.get("v.status");
        var sName = component.get("v.status.releaseStatus");
        var autoRel = component.get("v.status.skipLocRel");
        
        if (sName != undefined) {
            
            // **** write picklist values in Lower Case ***** //       
            //var tempLowerCase = sName.toLowerCase();
            var cPending = 'PENDING';
            var cError = 'ERROR';
            var cInDist = 'IN DISTRIBUTION';
            var cTest = 'TEST';
            var cIgnored = 'IGNORED';
            var cDeleted = 'DELETED';
            // ...add more values vaiable here 
            
            // set the color on based on picklist values
            if (cPending == sName) {//cOrange.indexOf(tempLowerCase) != -1
                component.set("v.Color", '#C2E7DA');
                component.set("v.autoRel",false);    
            } else if (cError == sName) {
                component.set("v.Color", '#EFAEBE');
                component.set("v.autoRel",false);
            } else if (cInDist == sName) {
                component.set("v.Color", '#C2E7DA');          
                if(autoRel == true){
                    component.set("v.autoRel",true);
                }          
            } else if (cTest == sName) {
                component.set("v.Color", '#E1EEFA');
                component.set("v.autoRel",false);
            }else if(cIgnored == sName){
                component.set("v.Color", '#E0E5EE');
                component.set("v.autoRel",false);
            }else if(cDeleted == sName){
                component.set("v.Color", '#FDDAB6');
                component.set("v.autoRel",false);
            }
        }
    },
    display : function(component, event, helper) {
        //alert("alert 1/1");
        helper.toggleHelper(component, event);
        //alert("alert 1/2");
        component.set("v.toolTipMsg",true);
        var tooltip = component.get("v.toolTipMsg");
          
			//component.set("v.modalStyle", "<style>.forceStyle .viewport .oneHeader {z-index:0; } .slds-global-header_container {position: static;} .forceStyle.desktop .viewport{overflow:hidden}</style>");
    },    
    displayOut : function(component, event, helper) {
        //alert("alert 2/1");
        helper.toggleHelper(component, event);
         //alert("alert 2/2");
        component.set("v.toolTipMsg",false);
        //event.setParam("v.toolTipMsg",false);
       // component.set("v.modalStyle", " ");
       //compEvent.fire();
    }
})