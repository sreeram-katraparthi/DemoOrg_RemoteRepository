public class ContactRollupTriggerHandler {
	public static void countContacts(Set<Id> accIdSet){
        List<Account> accToUpdate = new List<Account>();
        for(Account acc : [select Id,conCount__c,(select Id from Contacts) from account where Id IN : accIdSet]){
            acc.conCount__c = acc.Contacts.size();
			accToUpdate.add(acc);            
        }
        update accToUpdate;
    }
}