({
	handleClick : function(cmp, event, helper) {
		var attributeValue = cmp.get("v.text");
        console.log("current text: " + attributeValue);
        var target = event.getSource();
        cmp.set("v.text", target.get("v.label"));
    }
})