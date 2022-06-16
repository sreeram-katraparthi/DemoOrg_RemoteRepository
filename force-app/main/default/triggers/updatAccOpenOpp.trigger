trigger updatAccOpenOpp on Opportunity (after insert, after update, before delete, after undelete) {
	Set<Id> accIdSet = new Set<Id>();
    Map<Id,Account> parentAccMap;    
    //Fetch all account ids 
    if(Trigger.isUpdate || Trigger.isInsert || Trigger.isUndelete){
        system.debug('** before calling trigger handler **');
        OpportunityTriggerHandler oth = new OpportunityTriggerHandler();
        OpportunityTriggerHandler.sendRequest();
        system.debug('** after calling trigger handler **');
        /*for(Opportunity opp : Trigger.new){
            if(opp.accountId != null)
            	accIdSet.add(opp.accountId);
        }
    }
    if(Trigger.isBefore && (Trigger.isUpdate || Trigger.isDelete)){
        System.debug('** isbefore trigger.old **'+Trigger.old);
        for(Opportunity opp : Trigger.old){
            if(opp.accountId != null)
            	accIdSet.add(opp.accountId);
        }
    }
    List<Account> toUpdate = new List<Account>();
    parentAccMap =  new Map<Id,Account>([Select id,Has_Open_Opportunity__c, (select id,stagename from Opportunities) from Account where id IN : accIdSet]);
    for(Opportunity opp : Trigger.new){
		system.debug('opp.name'+opp.name);
        Account acc = parentAccMap.get(opp.AccountId);
        if(!opp.StageName.contains('Closed')){
        	acc.Has_Open_Opportunity__c = true;
        }else{
            acc.Has_Open_Opportunity__c = false;
        }
        toUpdate.add(acc);
    }
    System.debug('parentAccMap.values()'+parentAccMap.values());        
update toUpdate;*/}
}