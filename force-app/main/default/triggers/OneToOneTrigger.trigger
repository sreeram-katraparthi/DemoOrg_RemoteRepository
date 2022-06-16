trigger OneToOneTrigger on Additional_Address__c (before insert) {
	set<id> acctIds = new set<Id>();
    Map<id,List<Additional_Address__c>> accAddMap = new Map<id,List<Additional_Address__c>>();
    Map<id,account> oldAccts;
    List<Account> accts;
    List<Additional_Address__c> addresses;
    
    for(Additional_Address__c addr : trigger.new){
        acctIds.add(addr.AccountName__c);
    }
    
    oldAccts  = new Map<id,account>([select id,name from account where id in :acctIds]);
    accts = [select id,name,(select id,name from Additional_Addresses__r) from Account where id in : acctIds];
    
    for(Account a : accts){
        accAddMap.put(a.id,a.Additional_Addresses__r);
    }
    
    for(Additional_Address__c addrs : trigger.new){        
        //addresses.add(accAddMap.get(addrs.AccountName__c));
        System.debug('** addresses **'+addresses);
        if(accAddMap.get(addrs.AccountName__c).size() >= 1){
            System.debug('** accAddMap **'+accAddMap.get(addrs.AccountName__c).size());
            addrs.addError('already address is defined for this account'+oldAccts.get(addrs.AccountName__c));
        }            
    }
}