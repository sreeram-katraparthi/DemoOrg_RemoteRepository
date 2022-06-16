@isTest
public class CBREAccountFactory extends AccountFactory{

    private String accountFileStaticResource;
    
    //Constructor
    public CBREAccountFactory (String accountFileStaticResource) {
        dataFileStaticResourseName = accountFileStaticResource;
    }    
    
    
    //Constructor
    public CBREAccountFactory () {
        this('CBREAccountTestData');
    }    
    
    //Set data for Account
    public SObject setRecordData(Account acct) {
        
        acct.Name ='Test' + counter;      
        //acct.BillingCountryCode = 'US';
        acct.BillingStreet = '1234 test address';
        acct.BillingCity = 'Dallas';
        //acct.BillingStateCode = 'TX';
        //acct.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('CBRE_Account').getRecordTypeId();
               
        return (SObject) acct;
    }
}