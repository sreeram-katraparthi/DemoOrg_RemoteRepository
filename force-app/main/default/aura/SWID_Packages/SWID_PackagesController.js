({
    doInit: function(component, event, helper) {
        helper.fetchPickListVal(component, 'Routing_Country__c', 'routingCntryId');
    },
    onPicklistChange: function(component, event, helper) {
        if (event.getSource().get("v.value") != "" ){
            component.set("v.fourTabsView", "true");
            component.set("v.myBool",false);
            component.set("v.myBoolReleased",false);
            component.set("v.myBoolDeleted",false);
            component.set("v.myBoolIgnored",false);  
            
            
            //alert(event.getSource().get("v.value"));
            component.set("v.selectedCountryVal",event.getSource().get("v.value"));
            var vcntry = event.getSource().get("v.value");
            var action = component.get("c.getCountryPackages");//4 val rcds
            action.setParams({
                
                "strCountry": event.getSource().get("v.value")                
            });
            
            var results = [];
            action.setCallback(this, function(response){
                var Status = response.getState();
                //alert('Status:::'+Status);
                if (Status === "SUCCESS") {
                    var returnVals = response.getReturnValue();
                    if (returnVals.length > 0) {
                        //alert('@@ in success')
                        helper.sortPackages(component,returnVals);
                        component.set('v.lstPackages', response.getReturnValue());                        
                        component.set("v.countToDisplay",returnVals.length);
                        component.set("v.sortedByVal",'Arrived Date');
                        component.set("v.displayCountOfPcks",true);
                        component.set("v.selectedCount",0);
                        component.set("v.InDistributionStatusCount",0);
                        component.set("v.DeletedStatusCount",0);
                        component.set("v.IgnoredStatusCount",0);
                        
                    }else{
                        //component.set("v.fourTabsView", "false");
                        component.set("v.displayCountOfPcks",false);
                        component.set("v.readyTabCount",false);
                        component.set("v.inDisTabCount",false);
                        component.set("v.deleteTabCount",false);
                        component.set("v.ignoreTabCount",false);
                        //alert('NO RECORDS RELATED TO SELECTED ROUTING COUNTRY !!!');
                    }
                    
                }                
            });
            $A.enqueueAction(action);
        }else{
            component.set("v.fourTabsView", "false");
            //alert(event.getSource().get("v.value"));            
        }
        helper.readyTab(component, event, helper);
    },
    
    sortByString: function(component, event, helper) {
        //alert('@@@ value of ::'+component.find("readyDataId"));
        var sortField=event.currentTarget.dataset.sortfield;
        helper.sortByStringReady(component, event, helper,sortField);
        component.set("v.myBool",false);
        component.set("v.sortedByVal",sortField);
    },
    sortByStringReleased: function(component, event, helper) {
        var sortField=event.currentTarget.dataset.sortfield;
        helper.sortByStringReleased(component, event, helper,sortField);
        component.set("v.sortedByVal",sortField);
    },
    sortByStringDeleted: function(component, event, helper) {
        var sortField=event.currentTarget.dataset.sortfield;
        helper.sortByStringDeleted(component, event, helper,sortField);
        component.set("v.sortedByVal",sortField);
    },
    sortByStringIgnored: function(component, event, helper) {
        var sortField=event.currentTarget.dataset.sortfield;
        helper.sortByStringIgnored(component, event, helper,sortField);
        component.set("v.sortedByVal",sortField);
    },
    renderPage: function(component, event, helper) {
        helper.renderPage(component);
        component.set("v.myBool",false);
    },
    renderPageReleased: function(component, event, helper) {
        helper.renderPageReleased(component);
    },renderPageDeleted: function(component, event, helper) {
        helper.renderPageDeleted(component);
    },renderPageIgnored: function(component, event, helper) {
        helper.renderPageIgnored(component);
    },
    checkboxSelect: function(component, event, helper) {
        var enbButn = event.getParam("enblButtons");
        var status = event.getParam("Packages");
        var getRecId = event.getParam("recId");
        //alert("@@@ getRecId::::"+getRecId);
        var PendingCount = component.get("v.PendingStatusCount");
        var ErrorCount = component.get("v.ErrorStatusCount");
        var TestCount = component.get("v.TestStatusCount");
        var getSelectedNumber = component.get("v.selectedCount");
        
        var inDistCount = component.get("v.InDistributionStatusCount");
        var delCount = component.get("v.DeletedStatusCount");
        var ignoreCount = component.get("v.IgnoredStatusCount");
        
        var testids = component.get("v.TestRecIds");
        var pendids = component.get("v.PendingRecIds");
        var tempAllIds = component.get("v.allRecsIds");
        if(enbButn == true){
            getSelectedNumber++;            
        }else{
            getSelectedNumber--;
        }
        component.set("v.selectedCount",getSelectedNumber);
        
        if(getSelectedNumber > 0){
            //component.set("v.enableIgnBtn_Ready",false);
            component.set("v.enableLocRelBtn_Ready",false);
            component.set("v.enableTestRelBtn_Ready",false);
        }else{
            //component.set("v.enableIgnBtn_Ready",true);
            component.set("v.enableLocRelBtn_Ready",true);
            component.set("v.enableTestRelBtn_Ready",true);
        }
        
        if(enbButn == true){            
            if(status == "PENDING"){  //status != "ERROR" &&
                PendingCount++;
                pendids.push(getRecId);
                tempAllIds.push(getRecId);
                component.set("v.PendingRecIds",pendids);
            }else{ //status != "ERROR" && 
                TestCount++;
                tempAllIds.push(getRecId);
                testids.push(getRecId);
                component.set("v.TestRecIds",testids);
            }            
        }else{
            if(status == "PENDING"){ //status != "ERROR" &&
                PendingCount--;
                helper.removefromlist(component,getRecId,pendids);
            }else{  //status != "ERROR" && 
                TestCount--;
                helper.removefromlist(component,getRecId,testids);
            }            
        }
        
        component.set("v.ErrorStatusCount", ErrorCount);
        component.set("v.PendingStatusCount", PendingCount);
        component.set("v.TestStatusCount", TestCount);
        
        //
        //component.set("v.allRecsIds",tempAllIds);
        if(PendingCount > 0 ){
            component.set("v.enableIgnBtn_Ready",false);
        }else {
            component.set("v.enableIgnBtn_Ready",true);
        }
        
        if(enbButn == true){
            if(inDistCount >0){
                helper.uncheckOtherRecords_Release(component, event, helper);
            }
            if(delCount >0){
                helper.uncheckOtherRecords_Delete(component, event, helper);
            }
            if(ignoreCount >0){
                helper.uncheckOtherRecords_Ignore(component, event, helper);
            }
        }
        
    },
    checkboxSelectReleased: function(component, event, helper) {
        var getSelectedNumber = component.get("v.InDistributionStatusCount");
        var indids = component.get("v.InDistRecIds");
        var tempAllIds = component.get("v.allRecsIds");
        var getRecId = event.getParam("recId");
        var enbButn = event.getParam("enblButtons");
        var status = event.getParam("Packages");
        
        //check others
        var readyCount = component.get("v.selectedCount");
        var delCount = component.get("v.DeletedStatusCount");
        var ignoreCount = component.get("v.IgnoredStatusCount");
        
        if (enbButn == true ) {
            getSelectedNumber++;
            indids.push(getRecId);
            tempAllIds.push(getRecId);            
            component.set("v.InDistRecIds",indids);
        } else {
            getSelectedNumber--;
            helper.removefromlist(component,getRecId,indids);
        }
        component.set("v.InDistributionStatusCount", getSelectedNumber);
        if(getSelectedNumber > 0 && status == "IN DISTRIBUTION"){
            component.set("v.enableDelLocRelBtn_InDistrub",false);
            component.set("v.enableTestRelBtn_InDistrub",false);
        }else{
            component.set("v.enableDelLocRelBtn_InDistrub",true);
            component.set("v.enableTestRelBtn_InDistrub",true);
        }
        //component.set("v.InDistRecIds",indids);
        //component.set("v.allRecsIds",tempAllIds);
        if(enbButn == true){
            if(readyCount >0){
                helper.uncheckOtherRecords_Ready(component, event, helper);
            }
            if(delCount >0){
                helper.uncheckOtherRecords_Delete(component, event, helper);
            }
            if(ignoreCount >0){
                helper.uncheckOtherRecords_Ignore(component, event, helper);
            }
        }
        
    },
    checkboxSelectDeleted: function(component, event, helper) {
        var getSelectedNumber = component.get("v.DeletedStatusCount");
        var delids = component.get("v.DelRecIds");
        var getRecId = event.getParam("recId");
        var tempAllIds = component.get("v.allRecsIds");
        var enbButn = event.getParam("enblButtons");
        var status = event.getParam("Packages");
        var readyCount = component.get("v.selectedCount");
        var inDistCount = component.get("v.InDistributionStatusCount");
        var ignoreCount = component.get("v.IgnoredStatusCount");
        //alert("@@ DELETE getRecId:::"+getRecId);
        if (enbButn == true) {
            getSelectedNumber++;
            delids.push(getRecId);
            tempAllIds.push(getRecId);            
            component.set("v.DelRecIds",delids);
        } else {
            getSelectedNumber--;
            helper.removefromlist(component,getRecId,delids);
        }
        component.set("v.DeletedStatusCount", getSelectedNumber);
        if(getSelectedNumber > 0 && status == "DELETED" ){
            component.set("v.enableLocRelBtn_Delete",false);
            component.set("v.enableTestRelBtn_Delete",false);
        }else{
            component.set("v.enableLocRelBtn_Delete",true);
            component.set("v.enableTestRelBtn_Delete",true);
        }
        if(enbButn == true){
            if(inDistCount >0){
                helper.uncheckOtherRecords_Release(component, event, helper);
            }
            if(ignoreCount >0){
                helper.uncheckOtherRecords_Ignore(component, event, helper);
            }
            if(readyCount >0){
                helper.uncheckOtherRecords_Ready(component, event, helper);
            }
        }
        //component.set("v.DelRecIds",delids);
        //component.set("v.allRecsIds",tempAllIds);
    },
    checkboxSelectIgnored: function(component, event, helper) {
        var getSelectedNumber = component.get("v.IgnoredStatusCount");
        //alert("@@@ getSelectedNumber::-------"+getSelectedNumber);
        var ignids = component.get("v.IgnrdRecIds");
        var getRecId = event.getParam("recId");
        //alert("@@@ getRecId------::"+getRecId);
        var enbButn = event.getParam("enblButtons");
        var status = event.getParam("Packages");
        var tempAllIds = component.get("v.allRecsIds");
        var readyCount = component.get("v.selectedCount");
        var inDistCount = component.get("v.InDistributionStatusCount");
        var delCount = component.get("v.DeletedStatusCount");
        if (enbButn == true) {
            getSelectedNumber++;
            ignids.push(getRecId);
            //alert("@@@ ignids:::-----"+ignids);
            tempAllIds.push(getRecId);            
            component.set("v.IgnrdRecIds",ignids);
            //alert("@@@---");
        } else {
            getSelectedNumber--;
            helper.removefromlist(component,getRecId,ignids);
        }
        component.set("v.IgnoredStatusCount", getSelectedNumber);
        if(getSelectedNumber > 0 && status == "IGNORED"){
            component.set("v.enableIgnBtn_Ignore",false);
        }else{
            component.set("v.enableIgnBtn_Ignore",true);
        }
        //component.set("v.IgnrdRecIds",ignids);
        //component.set("v.allRecsIds",tempAllIds);
        if(enbButn == true){
            if(inDistCount >0){
                helper.uncheckOtherRecords_Release(component, event, helper);
            }
            if(delCount >0){
                helper.uncheckOtherRecords_Delete(component, event, helper);
            }
            if(readyCount >0){
                helper.uncheckOtherRecords_Ready(component, event, helper);
            }
        }
    },
    selectAll: function(component, event, helper) {
        
    },
    selectAllReleased: function(component, event, helper) {
        
        
    },
    selectAllDeleted: function(component, event, helper) {
        
    },
    selectAllIgnored: function(component, event, helper) {
        
    },
    onClkTestModal:function(component, event, helper) {
        component.set("v.modalBox",true);
    },
    closeModal:function(component, event, helper) {
        component.set("v.modalBox",false);
    },
    refreshPacks:function(component,event,helper){
        var reload = event.getParam("refreshPacks");
        var cntry = event.getParam("Packages");
        var cntryfrompack = component.get("v.selectedCountryVal");
        if ( reload == true){
            component.set("v.fourTabsView", "true");
            component.set("v.myBool",false);
            component.set("v.myBoolReleased",false);
            component.set("v.myBoolDeleted",false);
            component.set("v.myBoolIgnored",false); 
            
            var action = component.get("c.getCountryPackages");//4 val rcds
            action.setParams({                
                "strCountry": cntry                
            });
            
            var results = [];
            action.setCallback(this, function(response){
                var Status = response.getState();
                //alert('Status:::'+Status);
                if (Status === "SUCCESS") {
                    var returnVals = response.getReturnValue();
                    if (returnVals.length > 0) {
                        //alert('@@ in success')
                        helper.sortPackages(component,returnVals);
                        component.set('v.lstPackages', response.getReturnValue());                        
                        component.set("v.countToDisplay",returnVals.length);
                        component.set("v.sortedByVal",'Arrived Date');
                        component.set("v.displayCountOfPcks",true);
                        
                    }else{
                        //component.set("v.fourTabsView", "false");
                        component.set("v.displayCountOfPcks",false);
                        component.set("v.readyTabCount",false);
                        component.set("v.inDisTabCount",false);
                        component.set("v.deleteTabCount",false);
                        component.set("v.ignoreTabCount",false);
                        //alert('NO RECORDS RELATED TO SELECTED ROUTING COUNTRY !!!');
                    }
                    
                }                
            });
            $A.enqueueAction(action);
        }else{
            component.set("v.fourTabsView", "false");
            //alert(event.getSource().get("v.value"));            
        } 
    },
    readyTab: function(component, event, helper) {
        helper.readyTab(component, event, helper);
    },
    releasedTab: function(component, event, helper) {
        helper.releasedTab(component, event, helper);
    },
    deleteTab: function(component, event, helper){
        helper.deleteTab(component, event, helper); 
    },
    ignoredTab: function(component, event, helper) {
        helper.ignoredTab(component, event, helper);
    },
    showSpinner: function(component, event, helper) {
        component.set("v.Spinner", true); 
    },
    hideSpinner : function(component,event,helper){
        component.set("v.Spinner", false);
    },
    localReleaseButton_Ready : function(component,event,helper){
        // Parent Local Release - READY        
        //var valhereLabel = event.getSource().get("v.Name");
        component.set("v.btnActionName",'Local Release');
        component.set("v.actionVal",'released');
        var cnt = component.get("v.selectedCount");
        component.set("v.cntOfRcds",cnt);
        component.set("v.modalBox",true);
        component.set("v.SelectedButton",'READY LOCAL REL BUTTON');       
        
    },
    TestReleaseButton_Ready : function(component,event,helper){
        // Parent TEST Release - READY
        component.set("v.btnActionName",'Test Release');
        component.set("v.actionVal",'test released');
        var cnt = component.get("v.selectedCount");
        component.set("v.cntOfRcds",cnt);
        component.set("v.modalBox",true);
        component.set("v.SelectedButton",'READY TEST REL BUTTON');
    },
    IgnoreButton_Ready : function(component,event,helper){
        // Parent Ignore - READY								// cross check validation !!
        var testSelectedAlready = component.get("v.TestStatusCount");
        if(testSelectedAlready > 0){
            alert("Can't perform Ignore action for packages with Test Status. Please select packages only with status Pending.");
        }else{
            component.set("v.btnActionName",'Ignore');
            component.set("v.actionVal",'Ignored');
            component.set("v.ignoreActionOnly",true);
            var cnt = component.get("v.selectedCount");
            component.set("v.cntOfRcds",cnt);
            component.set("v.modalBox",true);
            component.set("v.SelectedButton",'READY IGNORE BUTTON');
        }
    },
    delLocRelButton_InDistrub : function(component,event,helper){
        // Parent Delete Local Release - In Distribution
        component.set("v.btnActionName",'Delete Local Release');
        component.set("v.actionVal",'deleted');
        var cnt = component.get("v.InDistributionStatusCount");
        component.set("v.cntOfRcds",cnt);
        component.set("v.modalBox",true);
        component.set("v.SelectedButton",'INDIST DELETE LOCAL BUTTON');
    },
    TestReleaseButton_InDistrub : function(component,event,helper){
        component.set("v.LookupmodalBox",true);
    },
    localReleaseButton_Delete : function(component,event,helper){
        // Parent Local Release - Delete
        component.set("v.btnActionName",'Local Release');
        component.set("v.actionVal",'released');
        var cnt = component.get("v.DeletedStatusCount");
        component.set("v.cntOfRcds",cnt);
        component.set("v.modalBox",true);
        component.set("v.SelectedButton",'DELETE LOCAL REL BUTTON');
    },
    TestReleaseButton_Delete : function(component,event,helper){
        component.set("v.LookupmodalBox",true);
    },
    setLookupModal: function(component,event,helper){
        var LookupModalFalse = event.getParam("setLookupModalFalse");
        if(LookupModalFalse == false){
        	component.set("v.LookupmodalBox",false);
        }        
    },
    unIgnoreButton_Ignore : function(component,event,helper){
        // Parent UnIgnore - Ignore
        component.set("v.btnActionName",'Unignore');
        component.set("v.actionVal",'Unignored');    
        var cnt = component.get("v.IgnoredStatusCount");
        component.set("v.cntOfRcds",cnt);
        component.set("v.modalBox",true);
        component.set("v.SelectedButton",'UNIGNORE BUTTON');
        
    },
    saveModalAction : function(component,event,helper){
        var valtocheck = component.get('v.SelectedButton');
        //alert("@@@ value of valtocheck::"+valtocheck);
        if(valtocheck == 'READY LOCAL REL BUTTON'){
            var tstIds = component.get("v.TestRecIds");
        }else if(valtocheck == 'READY TEST REL BUTTON' ){
            var tstIds = component.get("v.TestRecIds");
        }else if(valtocheck == 'READY IGNORE BUTTON' ){
            var tstIds = component.get("v.PendingRecIds");
        }else if(valtocheck == 'INDIST DELETE LOCAL BUTTON' ){
            var tstIds = component.get("v.InDistRecIds");
        }else if(valtocheck == 'DELETE LOCAL REL BUTTON' ){
            var tstIds = component.get("v.DelRecIds");
        }else if(valtocheck == 'UNIGNORE BUTTON'){
            var tstIds = component.get("v.IgnrdRecIds");
        }
        //alert("@@@ tstIds:::####"+tstIds);
        var ignChk = component.get("v.ignoreActionOnly");
        //alert("@@@ ignChk:::"+ignChk);
        
        var action = component.get("c.changeStatusOfPackage");
        action.setParams({            
            "lstOfrecId": tstIds,
            "onlyIgnCheck" : ignChk
        });
        action.setCallback(this, function(response) {
            if (response.getState() == "SUCCESS") {
                var allValues = response.getReturnValue();               
            }
        });
        $A.enqueueAction(action);
        component.set("v.modalBox",false);
        helper.refreshPacks(component,event,helper);
        
    }
})