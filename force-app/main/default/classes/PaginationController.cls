public class PaginationController {
    @AuraEnabled
    public static List<AccConWrapper> showContacts(){
        /*List<Contact> contactList = new List<Contact>();
        contactList = [Select Id, Name, Title, Email, MobilePhone, Fax, AccountId,Account.Industry From Contact LIMIT 100 ];
        return contactList;*/
        List<Contact> cons = [select id,name,account.industry,account.website from contact limit 10];
        List<AccConWrapper> wrapListRecs = new List<AccConWrapper>();
        for(Contact wrap : cons){
            AccConWrapper wrapList = new AccConWrapper();
            wrapList.conName = wrap.name;
            wrapList.accIndustry = wrap.account.Industry;
            wrapList.accWebsite = wrap.account.website;
            wrapListRecs.add(wrapList);
        }
        system.debug('wrapListRecs'+wrapListRecs);
        return wrapListRecs;
        
    }
    public class AccConWrapper{
		public string conName;
        public string accIndustry;
        public string accWebsite;
    }
}