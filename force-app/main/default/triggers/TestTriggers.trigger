trigger TestTriggers on Contact (after insert, after update, after delete, after undelete) {    
    
    Set<Id> accountIds = new Set<Id>();
    
    if(Trigger.isInsert || Trigger.isUpdate || Trigger.isUndelete){
        for(Contact con : Trigger.new){
            if(con.accountId != null){
                accountIds.add(con.accountId);
            }               
        }
    }
    
    if(Trigger.isDelete || Trigger.isUpdate){
        for(Contact con : Trigger.old){
            if(con.accountId != null){
                accountIds.add(con.accountId);                
            }
        }
    }
    
    if(!accountIds.isEmpty()){
        List<Account> accList = [select id, conCount__c, (select id from contacts) from Account where id IN : accountIds];
        if(!accList.isEmpty()){
            List<Account> accToUpdate = new List<Account>();
            for(account acc : accList){
                account a = new account();
                a.Id = acc.Id;
                a.conCount__c = acc.Contacts.Size();
                accToUpdate.add(a);
            }
            if(!accToUpdate.isEmpty()){
                update accToUpdate;
            }
        }
    }
    
    /*if(trigger.isBefore){
        if(trigger.isinsert){
            system.debug('** before insert trigger.new **'+trigger.new);
            system.debug('** before insert trigger.old **'+trigger.old);
            system.debug('** before insert trigger.newmap **'+trigger.newmap);
            system.debug('** before insert trigger.oldmap **'+trigger.oldmap);
        }
        if(trigger.isupdate){
            system.debug('** before update trigger.new **'+trigger.new);
            system.debug('** before update trigger.old **'+trigger.old);
            system.debug('** before update trigger.newmap **'+trigger.newmap);
            system.debug('** before update trigger.oldmap **'+trigger.oldmap);            
        }
        if(trigger.isdelete){
            system.debug('** before delete trigger.new **'+trigger.new);
            system.debug('** before delete trigger.old **'+trigger.old);
            system.debug('** before delete trigger.newmap **'+trigger.newmap);
            system.debug('** before delete trigger.oldmap **'+trigger.oldmap);
        }        
    }
    if(trigger.isAfter){
        if(trigger.isinsert){
            system.debug('** after insert trigger.new **'+trigger.new);
            system.debug('** after insert trigger.old **'+trigger.old);
            system.debug('** after insert trigger.newmap **'+trigger.newmap);
            system.debug('** after insert trigger.oldmap **'+trigger.oldmap);
        }
        if(trigger.isupdate){
            system.debug('** after update trigger.new **'+trigger.new);
            system.debug('** after update trigger.old **'+trigger.old);
            system.debug('** after update trigger.newmap **'+trigger.newmap);
            system.debug('** after update trigger.oldmap **'+trigger.oldmap);            
        }
        if(trigger.isdelete){
            system.debug('** after delete trigger.new **'+trigger.new);
            system.debug('** after delete trigger.old **'+trigger.old);
            system.debug('** after delete trigger.newmap **'+trigger.newmap);
            system.debug('** after delete trigger.oldmap **'+trigger.oldmap);
        }
        if(trigger.isundelete){
            system.debug('** after undelete trigger.new **'+trigger.new);
            system.debug('** after undelete trigger.old **'+trigger.old);
            system.debug('** after undelete trigger.newmap **'+trigger.newmap);
            system.debug('** after undelete trigger.oldmap **'+trigger.oldmap);
        }        
    }*/        
}