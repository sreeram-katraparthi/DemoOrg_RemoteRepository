public class AccountListController {
    
    @AuraEnabled
    public static List < AccountWrapper > fetchAccts() {
        List < AccountWrapper > listAcctWrapper = new List < AccountWrapper >();

 

        for ( Account acc : [ SELECT Id, Name, Industry, Type, Active__c FROM Account LIMIT 10 ] ) {
            AccountWrapper AccountWrap = new AccountWrapper();
            AccountWrap.accName = acc.Name;
            AccountWrap.isActive = acc.Active__c == 'Yes' ? true : false;
            AccountWrap.accIndustry = acc.Industry;
            AccountWrap.accType = acc.Type;
            AccountWrap.accActive = acc.Active__c;
            AccountWrap.accId = acc.Id;
            listAcctWrapper.add(AccountWrap);
        }
        return listAcctWrapper;
    }
    
    
}