trigger UpdateRequestTrigger on Update_Request__c (after insert) {
    public string APROVAL_STATUS_APPROVED = 'Approved';
    if(trigger.isInsert && trigger.isAfter){
        for(Update_Request__c updateObj : Trigger.new){
            if(APROVAL_STATUS_APPROVED.equals(updateObj.ApprovalStatus__c)){
                
            } 
        }
    }
}