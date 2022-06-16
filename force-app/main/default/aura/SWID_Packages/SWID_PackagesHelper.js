({
    fetchPickListVal: function(component, fieldName, elementId) {
        var action = component.get("c.getCountries");
        action.setParams({
            "objObject": component.get("v.objInfo"),
            "fld": fieldName
        });
        var opts = [];
        action.setCallback(this, function(response) {
            if (response.getState() == "SUCCESS") {
                component.set("v.selectedCountryVal",fieldName);
                var allValues = response.getReturnValue();
                
                for (var i = 0; i < allValues.length; i++) {
                    opts.push({
                        class: "optionClass",
                        label: allValues[i],
                        value: allValues[i]
                    });
                }
                if(opts != '' || opts != undefined || opts != " "){
                    component.set("v.fourTabsView", "false");
                    component.set("v.statusOptions", opts);
                }
                component.find(elementId).set("v.options", opts);
            }
        });
        $A.enqueueAction(action);
    },
    sortPackages: function(component,returnVals){
        var rdyPkg  = [];
        var rlsPkg  = [];
        var ignPkg  = [];
        var delPkg  = [];
        component.set("v.sortAsc", true);
        for (var i=0; i < returnVals.length; i++) {
            //alert('check 1:::'+JSON.stringify(returnVals[i].releaseStatus));
            if (returnVals[i].releaseStatus == "PENDING" || returnVals[i].releaseStatus == "TEST"){
                var checkKey = returnVals[i].releaseStatus;
                rdyPkg.push(returnVals[i]);                
            }else if(returnVals[i].releaseStatus == "IN DISTRIBUTION" ){
                var checkKey = returnVals[i].releaseStatus;
                rlsPkg.push(returnVals[i]);
            }else if(returnVals[i].releaseStatus == "IGNORED"){
                var checkKey = returnVals[i].releaseStatus;
                ignPkg.push(returnVals[i]);
            }else if(returnVals[i].releaseStatus == "DELETED"){
                var checkKey = returnVals[i].releaseStatus;
                delPkg.push(returnVals[i]);
            }
            
        }
        
        if(rdyPkg.length == 0){
            component.set("v.readyTabCount",false);
        }else{
            //alert('@@@ count of rdyPkg:::'+rdyPkg.length);
            component.set("v.maxPage", Math.floor((rdyPkg.length+49)/50));
            component.set('v.readyPackageRcds',rdyPkg);
            component.set("v.readyTabCount",true);
            this.renderPage(component);
        }
        if(rlsPkg.length == 0){
            component.set("v.inDisTabCount",false);
        }else{
            component.set("v.maxPageReleased", Math.floor((rlsPkg.length+49)/50));
            component.set('v.releasePackgeRcds',rlsPkg);
            component.set("v.inDisTabCount",true); 
            this.renderPageReleased(component);
        }
        if(delPkg.length == 0){
            component.set("v.deleteTabCount",false);           
        }else{
            component.set("v.maxPageDeleted", Math.floor((delPkg.length+49)/50));
            component.set('v.deletedPackageRcds',delPkg);
            component.set("v.deleteTabCount",true);
            this.renderPageDeleted(component);
        }
        
        if(ignPkg.length == 0){
            component.set("v.ignoreTabCount",false);
        }else{
            component.set("v.maxPageIgnored", Math.floor((ignPkg.length+49)/50));
            component.set('v.ignoredPackageRcds',ignPkg);
            component.set("v.ignoreTabCount",true);
            this.renderPageIgnored(component);
        }       
        
    },
    clearAll: function(component, event) {
        // this method set all tabs to hide and inactive
        var getAllLI = document.getElementsByClassName("customClassForTab");
        var getAllDiv = document.getElementsByClassName("customClassForTabData");
        for (var i = 0; i < getAllLI.length; i++) {
            getAllLI[i].className = "slds-tabs--scoped__item slds-text-title--caps customClassForTab";
            getAllDiv[i].className = "slds-tabs--scoped__content slds-hide customClassForTabData";
        }
    },
    sortByStringReady: function(component, event, helper,field) {
        var sortAsc = component.get("v.sortAsc"),
            sortField = component.get("v.sortField"),
            records = component.get("v.readyPackageRcds"); 
        //console.log('@records '+JSON.stringify(records))
        sortAsc = sortField != field || !sortAsc;        
        records.sort(function(a,b){
            var t1 = a[field] == b[field],
                t2 = (!a[field] && b[field]) || (a[field] < b[field]);
            return t1? 0: (sortAsc?-1:1)*(t2?1:-1);
        });
        component.set("v.sortAsc", sortAsc);
        component.set("v.sortField", field);
        component.set("v.readyPackageRcds", records);
        this.renderPage(component);
        
    },
    sortByStringReleased: function(component, event, helper,field) {
        var sortAsc = component.get("v.sortAsc"),
            sortField = component.get("v.sortField"),
            records = component.get("v.releasePackgeRcds"); 
        sortAsc = sortField != field || !sortAsc;        
        records.sort(function(a,b){
            var t1 = a[field] == b[field],
                t2 = (!a[field] && b[field]) || (a[field] < b[field]);
            return t1? 0: (sortAsc?-1:1)*(t2?1:-1);
        });
        component.set("v.sortAsc", sortAsc);
        component.set("v.sortField", field);
        component.set("v.releasePackgeRcds", records);
        this.renderPageReleased(component);
        
    },
    sortByStringDeleted: function(component, event, helper,field) {
        var sortAsc = component.get("v.sortAsc"),
            sortField = component.get("v.sortField"),
            records = component.get("v.deletedPackageRcds"); 
        sortAsc = sortField != field || !sortAsc;        
        records.sort(function(a,b){
            var t1 = a[field] == b[field],
                t2 = (!a[field] && b[field]) || (a[field] < b[field]);
            return t1? 0: (sortAsc?-1:1)*(t2?1:-1);
        });
        component.set("v.sortAsc", sortAsc);
        component.set("v.sortField", field);
        component.set("v.deletedPackageRcds", records);
        this.renderPageDeleted(component);
        
    },
    sortByStringIgnored: function(component, event, helper,field) {
        var sortAsc = component.get("v.sortAsc"),
            sortField = component.get("v.sortField"),
            records = component.get("v.ignoredPackageRcds"); 
        
        sortAsc = sortField != field || !sortAsc;        
        records.sort(function(a,b){
            var t1 = a[field] == b[field],
                t2 = (!a[field] && b[field]) || (a[field] < b[field]);
            return t1? 0: (sortAsc?-1:1)*(t2?1:-1);
        });
        component.set("v.sortAsc", sortAsc);
        component.set("v.sortField", field);
        component.set("v.ignoredPackageRcds", records);
        this.renderPageIgnored(component);
        
    },
    
    
    renderPage: function(component) {
        var records = component.get("v.readyPackageRcds"),
            pageNumber = component.get("v.pageNumber"),
            pageRecords = records.slice((pageNumber-1)*50, pageNumber*50);
        //alert("@@@ count :::"+pageRecords.length);
        component.set("v.currentReadyList", pageRecords);
    },renderPageReleased: function(component, event, helper) {
        var records = component.get("v.releasePackgeRcds"),
            pageNumberReleased = component.get("v.pageNumberReleased"),
            pageRecords = records.slice((pageNumberReleased-1)*50, pageNumberReleased*50);
        
        component.set("v.currentReleasedList", pageRecords);
    },renderPageDeleted: function(component, event, helper) {
        var records = component.get("v.deletedPackageRcds"),
            pageNumberDeleted = component.get("v.pageNumberDeleted"),
            pageRecords = records.slice((pageNumberDeleted-1)*50, pageNumberDeleted*50);
        
        component.set("v.currentDeletedList", pageRecords);
    },renderPageIgnored: function(component, event, helper) {
        var records = component.get("v.ignoredPackageRcds"),
            pageNumberIgnored = component.get("v.pageNumberIgnored"),
            pageRecords = records.slice((pageNumberIgnored-1)*50, pageNumberIgnored*50);
        
        component.set("v.currentIgnoredList", pageRecords);
    },    
    deleteTab: function(component, event, helper){
        var tab1 = component.find('readyAuraId');
        var TabOnedata = component.find('readyDataId');
        
        var tab2 = component.find('releasedAuraId');
        var TabTwoData = component.find('releasedDataId');
        
        var tab3 = component.find('ignoredAuraId');
        var TabThreeData = component.find('ignoredDataId');
        
        var tab4 = component.find('deletedAuraId');
        var TabFourData = component.find('deletedDataId');
        
        $A.util.addClass(tab4, 'slds-active');
        $A.util.addClass(TabFourData, 'slds-show');
        $A.util.removeClass(TabFourData, 'slds-hide');
        
        $A.util.removeClass(tab1, 'slds-active');
        $A.util.removeClass(TabOnedata, 'slds-show');
        $A.util.addClass(TabOnedata, 'slds-hide');
        
        $A.util.removeClass(tab2, 'slds-active');
        $A.util.removeClass(TabTwoData, 'slds-show');
        $A.util.addClass(TabTwoData, 'slds-hide');
        
        $A.util.removeClass(tab3, 'slds-active');
        $A.util.removeClass(TabThreeData, 'slds-show');
        $A.util.addClass(TabThreeData, 'slds-hide');
        
    },
    readyTab: function(component, event, helper) {
        var tab1 = component.find('readyAuraId');
        var TabOnedata = component.find('readyDataId');
        
        var tab2 = component.find('releasedAuraId');
        var TabTwoData = component.find('releasedDataId');
        
        var tab3 = component.find('ignoredAuraId');
        var TabThreeData = component.find('ignoredDataId');
        
        var tab4 = component.find('deletedAuraId');
        var TabFourData = component.find('deletedDataId');
        
        
        //show and Active Ready tab
        $A.util.addClass(tab1, 'slds-active');
        $A.util.addClass(TabOnedata, 'slds-show');
        $A.util.removeClass(TabOnedata, 'slds-hide');
        // Hide and deactivate others tab
        $A.util.removeClass(tab2, 'slds-active');
        $A.util.removeClass(TabTwoData, 'slds-show');
        $A.util.addClass(TabTwoData, 'slds-hide');
        
        $A.util.removeClass(tab3, 'slds-active');
        $A.util.removeClass(TabThreeData, 'slds-show');
        $A.util.addClass(TabThreeData, 'slds-hide');
        
        $A.util.removeClass(tab4, 'slds-active');
        $A.util.removeClass(TabFourData, 'slds-show');
        $A.util.addClass(TabFourData, 'slds-hide');
    },
    releasedTab: function(component, event, helper) {
        
        var tab1 = component.find('readyAuraId');
        var TabOnedata = component.find('readyDataId');
        
        var tab2 = component.find('releasedAuraId');
        var TabTwoData = component.find('releasedDataId');
        
        var tab3 = component.find('ignoredAuraId');
        var TabThreeData = component.find('ignoredDataId');
        
        var tab4 = component.find('deletedAuraId');
        var TabFourData = component.find('deletedDataId');
        
        //show and Active vegetables Tab
        $A.util.addClass(tab2, 'slds-active');
        $A.util.removeClass(TabTwoData, 'slds-hide');
        $A.util.addClass(TabTwoData, 'slds-show');
        // Hide and deactivate others tab
        $A.util.removeClass(tab1, 'slds-active');
        $A.util.removeClass(TabOnedata, 'slds-show');
        $A.util.addClass(TabOnedata, 'slds-hide');
        
        $A.util.removeClass(tab3, 'slds-active');
        $A.util.removeClass(TabThreeData, 'slds-show');
        $A.util.addClass(TabThreeData, 'slds-hide');
        
        $A.util.removeClass(tab4, 'slds-active');
        $A.util.removeClass(TabFourData, 'slds-show');
        $A.util.addClass(TabFourData, 'slds-hide');
        
        
    },
    ignoredTab: function(component, event, helper) {
        var tab1 = component.find('readyAuraId');
        var TabOnedata = component.find('readyDataId');
        
        var tab2 = component.find('releasedAuraId');
        var TabTwoData = component.find('releasedDataId');
        
        var tab3 = component.find('ignoredAuraId');
        var TabThreeData = component.find('ignoredDataId');
        
        var tab4 = component.find('deletedAuraId');
        var TabFourData = component.find('deletedDataId');
        
        //show and Active color Tab
        $A.util.addClass(tab3, 'slds-active');
        $A.util.addClass(TabThreeData, 'slds-show');
        // Hide and deactivate others tab
        $A.util.removeClass(tab1, 'slds-active');
        $A.util.removeClass(TabOnedata, 'slds-show');
        $A.util.addClass(TabOnedata, 'slds-hide');
        
        $A.util.removeClass(tab2, 'slds-active');
        $A.util.removeClass(TabTwoData, 'slds-show');
        $A.util.addClass(TabTwoData, 'slds-hide');
        
        $A.util.removeClass(tab4, 'slds-active');
        $A.util.removeClass(TabFourData, 'slds-show');
        $A.util.addClass(TabFourData, 'slds-hide');
        
    },
    refreshPacks:function(component,event,helper){
        //var reload = event.getParam("refreshPacks");
        //var cntry = event.getParam("Packages");
        //
        
        //alert("@@@ entered refresh in helper");
        var reload = true;
        var cntryfrompack = component.get("v.selectedCountryVal");
        //alert("@@@ cntryfrompack::::"+cntryfrompack);
        if ( reload == true){
            component.set("v.fourTabsView", true);
            component.set("v.myBool",false);
            component.set("v.myBoolReleased",false);
            component.set("v.myBoolDeleted",false);
            component.set("v.myBoolIgnored",false); 
            
            var action = component.get("c.getCountryPackages");//4 val rcds
            action.setParams({                
                "strCountry": cntryfrompack                
            });
            
            var results = [];
            action.setCallback(this, function(response){
                var Status = response.getState();
                //alert('Status:::'+Status);
                if (Status === "SUCCESS") {
                    var returnVals = response.getReturnValue();
                    if (returnVals.length > 0) {
                        //alert('@@ in success')
                        this.sortPackages(component,returnVals);
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
    },
    uncheckOtherRecords_Ready: function(component, event, helper){
        var readyCount = component.get("v.selectedCount");
        //alert("@@@ READY COUNT:::"+readyCount);
        //alert("@@@ IN DIST COUNT:::"+inDistCount);
        //alert("@@@ DELETE COUNT:::"+delCount);
        var tempPendingIds = component.get("v.PendingRecIds");
        var tempTestIds = component.get("v.TestRecIds");
        
        if(readyCount > 0){
            var varreadyPackageRcds = component.get("v.currentReadyList") 
            //alert("@@ READY YES !!:::"+varreadyPackageRcds.length);	
            for (var i=0; i < varreadyPackageRcds.length; i++) {
                //alert("@@@ varreadyPackageRcds.isSelected::"+JSON.stringify(varreadyPackageRcds));// ok displaying all selected
                if(varreadyPackageRcds[i].isSelected = true){
                    //alert("@@@@@"); 									
                    // wat to turn isSelect to false here...???
                    varreadyPackageRcds[i].isSelected = false;			
                }
                
                if(varreadyPackageRcds[i].releaseStatus = 'PENDING'){
                   for(var j=0;j<tempPendingIds.length;j++){
                        if(tempPendingIds[j] == varreadyPackageRcds[i]){
                            tempPendingIds.splice(j,1);
                        }
                    }
                }else if(varreadyPackageRcds[j].releaseStatus = 'TEST'){
                    for(var j=0;j<tempTestIds.length;j++){
                        if(tempTestIds[j] == varreadyPackageRcds[i]){
                            tempTestIds.splice(j,1);
                        }
                    }
                }
                
                
            }
            component.set("v.PendingRecIds",tempPendingIds);
            component.set("v.TestRecIds",tempTestIds);
            component.set("v.currentReadyList",varreadyPackageRcds);	
			component.set("v.enableLocRelBtn_Ready",true);
            component.set("v.enableTestRelBtn_Ready",true);
            component.set("v.enableIgnBtn_Ready",true);            
        }       
        
    },
    uncheckOtherRecords_Release: function(component, event, helper){
        var inDistCount = component.get("v.InDistributionStatusCount");
        var tempInDistIds = component.get("v.InDistRecIds");
        if(inDistCount > 0){
           // alert("@@ IN DIST YES !!"); //currentReleasedList
            var varReleasePkgRcds = component.get("v.currentReleasedList");
            for(var i=0; i<varReleasePkgRcds.length; i++){
                if(varReleasePkgRcds[i].isSelected = true){
                    varReleasePkgRcds[i].isSelected = false;
                    
                    for(var j=0;j<tempInDistIds.length;j++){
                        if(tempInDistIds[j] == varReleasePkgRcds[i]){
                            tempInDistIds.splice(j,1);
                        }
                    }
                    
                }                
            }
            component.set("v.InDistRecIds",tempInDistIds);
            component.set("v.currentReleasedList",varReleasePkgRcds);
            component.set("v.enableDelLocRelBtn_InDistrub",true);
        }
    },
    uncheckOtherRecords_Delete: function(component, event, helper){
        var delCount = component.get("v.DeletedStatusCount");
        var tempDelIds = component.get("v.DelRecIds");
        if(delCount > 0){
            //alert("@@ DELETE YES !!"); //currentDeletedList
            var varDeletePkgRcds = component.get("v.currentDeletedList");
            for(var i=0; i<varDeletePkgRcds.length; i++){
                if(varDeletePkgRcds[i].isSelected = true){
                    varDeletePkgRcds[i].isSelected = false;
                   
                    for(var j=0;j<tempDelIds.length;j++){
                        if(tempDelIds[j] == varDeletePkgRcds[i]){
                            tempDelIds.splice(j,1);
                        }
                    }
                    
                }                
            }
            component.set("v.DelRecIds",tempDelIds);
            component.set("v.currentDeletedList",varDeletePkgRcds);
            component.set("v.enableLocRelBtn_Delete",true);
        }
    },
    uncheckOtherRecords_Ignore: function(component, event, helper){
        //alert("@@ IGNORE YES !!");
        var ignoreCount = component.get("v.IgnoredStatusCount");
        var tempIgnIds = component.get("v.IgnrdRecIds");
        //alert("@@ IGNORE YES - 2 :::ignoreCount.count::!!"+ignoreCount);
        //alert("@@ tempIgnIds::"+tempIgnIds);
        if(ignoreCount > 0){
            //alert("@@ IGNORE YES - 3 !!");
            var varIgnorePkgRcds = component.get("v.currentIgnoredList");
            //alert("@@@ varIgnorePkgRcds:::"+varIgnorePkgRcds.length);
            for(var i=0; i<varIgnorePkgRcds.length; i++){
                if(varIgnorePkgRcds[i].isSelected = true){
                    varIgnorePkgRcds[i].isSelected = false;
                   
                    for(var j=0;j<tempIgnIds.length;j++){
                        if(tempIgnIds[j] == varIgnorePkgRcds[i]){
                            tempIgnIds.splice(j,1);
                        }
                    }
                    
                }                
            }
            component.set("v.IgnrdRecIds",tempIgnIds);
            component.set("v.currentIgnoredList",varIgnorePkgRcds);
            component.set("v.enableIgnBtn_Ignore",true);
        }
    },
    removefromlist:function(component,getRecId,indids){
    	var recId = getRecId;
    	var recIdsList = indids;
        //var index = recIdsList.indexOf(5);
    	for(var i=0;i<recIdsList.length;i++){
            if(recIdsList[i] == recId){
                recIdsList.splice(i,1);
        	}
        }
    	component.set("v.InDistRecIds",recIdsList);
        component.set("v.allRecsIds",recIdsList);
        
	},
    
    
    
})