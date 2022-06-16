({  
     handleModalEditLeadOpen: function(component) {
         component.set('v.showModalEditLead', true);
         component.set('v.enbModalWin',true);
     },

     handleModalEditLeadCancel: function(component) {
         component.set('v.showModalEditLead', false);
     },

     handleModalEditLeadSave: function(component, event, helper) {
         /* Handle the Lead here */
         component.set('v.showModalEditLead', false);
     },

     handleOpenModalB: function(component) {
         component.set('v.showModalB', true);
     }
})