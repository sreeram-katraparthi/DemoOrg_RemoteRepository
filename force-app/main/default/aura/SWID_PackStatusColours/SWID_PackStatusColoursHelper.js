({
	toggleHelper : function(component,event) {
    var toggleText = component.find("tooltip");
        //alert('@@ helper:::'+toggleText);
       // component.set("v.toolTipMsg",true);
    $A.util.toggleClass(toggleText, "toggle");
   }
})