public abstract class ContactFactory extends SObjectFactory{
    
    //Constructor
    public ContactFactory() {
        sObjectType = Contact.sObjectType;
    }
    
    //Set Data related to account
    public SObject buildRecordWithData() {
        Contact con = new Contact(LastName ='Test Contact');
        return setRecordData(con);
    }
    
    //to be implemented by extending class 
    abstract SObject setRecordData(Contact con);
}