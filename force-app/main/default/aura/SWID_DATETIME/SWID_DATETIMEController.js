({
    onLoad: function(component, event, helper) {
        var dtVal = component.get("v.dateTimeVal");
        if(dtVal != null && dtVal != '' && dtVal != undefined && dtVal != ''){
            //var d = dtVal;
           // d.setTime(1432851021000);            
            //var newdate = moment(d);            
            //alert(d.format("DD.MM.YYYY HH:mm:ss"));
            var tempDt = ($A.localizationService.formatDateTime(dtVal, "DD.MM.YYYY HH:mm:ss"));
            //alert("@@@@ tempDt:::"+tempDt);
            //component.set("v.dateTimeVal.ArrivedDate",tempDt);
            
            var varDateVal = ($A.localizationService.formatDateTime(dtVal, "DD.MM.YYYY"));
            component.set("v.dateVal",varDateVal);
            //alert("@@@ Date val:::"+varDateVal);
            var varTimeVal = ($A.localizationService.formatDateTime(dtVal, "HH:mm"));
            component.set("v.timeVal",varTimeVal);
            //alert("@@@ Time val:::"+varTimeVal);
        }
    }
})