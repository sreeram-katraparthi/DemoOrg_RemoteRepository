trigger ContactRollupTrigger on Contact (after insert,after update,after delete,after undelete) {
    Set<Id> accIdSet = new Set<Id>();    
    if(Trigger.isAfter){
        if(Trigger.isInsert  || Trigger.isUndelete){            
        	for(Contact con : Trigger.New){
            	accIdSet.add(con.AccountId);
        	}
        ContactRollupTriggerHandler.countContacts(accIdSet);
        }else if(Trigger.isUpdate || Trigger.isDelete){
            for(Contact con : Trigger.old){
                accIdSet.add(con.AccountId);
                if(Trigger.oldMap != null && Trigger.newMap != null){
                    if(Trigger.oldMap.get(con.Id).accountId != Trigger.newMap.get(con.Id).accountId){
						accIdSet.add(Trigger.newMap.get(con.Id).accountId);
                	}
                }                               
            }
            ContactRollupTriggerHandler.countContacts(accIdSet);
        }   
    }    
    
    
}