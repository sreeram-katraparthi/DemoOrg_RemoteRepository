public abstract class AccountFactory extends SObjectFactory{

    //Constructor
    public AccountFactory() {
        sObjectType = Account.sObjectType;
    }
    
    //Set Data related to account
    public SObject buildRecordWithData() {
        
        Account acct = new Account( Name = 'Test Account');
        return setRecordData(acct);
    }
    
    //to be implemented by extending class 
    abstract SObject setRecordData(Account acct);
}