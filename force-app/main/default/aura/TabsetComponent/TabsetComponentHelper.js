({
    createTabset: function(component) {
        var newComponents = [];
        newComponents.push(["lightning:tab", {
            "id" : "tab1",
            "title": "Tab 1"
        }]);
        newComponents.push(["aura:text",{
            "value" : "Tab 1"
        }]);
        newComponents.push(["lightning:tab", {
            "id" : "tab2",
            "title": "Tab 2"
        }]);
        newComponents.push(["aura:text",{
            "value" : "Tab 2"
        }]);
        newComponents.push(["lightning:tab", {
            "id" : "tab3",
            "title": "Tab 3"
        }]);
        newComponents.push(["aura:text",{
            "value" : "Tab 3"
        }]);
        $A.createComponents(newComponents,
            function (components, status, errorMessage) {
                console.log(errorMessage);
                if (component.isValid() && status === "SUCCESS") {
                    var tabs = [];
                    for(var i = 0; i < components.length; i++) {
                        if(i % 2 === 0) {
                            tabs.push(components[i]);
                        } else {
                            components[i-1].set("v.label", components[i]);
                        }
                    }
                    component.set("v.horizontalTabs", tabs);
                } else {

                }
            }
        );
    }
})