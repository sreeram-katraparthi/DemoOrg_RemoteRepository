public with sharing class updateLeadStatus {
    @AuraEnabled(cacheable = true)
    public static string updateLead(string recId){
        Lead toUpdate = [select status from Lead where id=: recId];
        toUpdate.status = 'Closed - Not Converted';
        update toUpdate;
        return toUpdate.id;
    }

     @AuraEnabled(cacheable=true)
    public static Contact getSingleContact(){
       return [SELECT Id, FirstName, LastName FROM Contact LIMIT 1];
    }
}