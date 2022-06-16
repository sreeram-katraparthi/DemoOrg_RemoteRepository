//https://salesforce.stackexchange.com/questions/115092/how-to-display-modal-popup-with-a-form-inside-a-lightning-component
//http://blog.jeffdouglas.com/2011/08/12/roll-your-own-salesforce-lookup-popup-window/
({
	newEvent: function(component, event, className){
        //helper.showPopupHelper(component, 'modaldialog', 'slds-fade-in-');
		//helper.showPopupHelper(component,'backdrop','slds-backdrop--');
		var modal = component.find('modaldialog');
        $A.util.removeClass(modal, 'slds-fade-in-' + 'hide');
        $A.util.addClass(modal, 'slds-backdrop--' + 'open');
    },
})