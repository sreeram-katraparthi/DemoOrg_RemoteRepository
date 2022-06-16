@isTest
public class CBREClientContactFactory extends ContactFactory{

    private String contactFileStaticResource;
    
    //Constructor
    public CBREClientContactFactory (String contactFileStaticResource) {
        dataFileStaticResourseName = contactFileStaticResource;
    }    
    
    
    //Constructor
    public CBREClientContactFactory () {
        this('CBREClientContactTestData');
    }    
    
    //Set data for Opportunity
    public SObject setRecordData(Contact con) {
        con.LastName ='Test Contact';         
        //con.Immagine_ID__c = '123456';
        con.Email = 'test@1.com';
        //con.Bypass_Validation__c = true;
        //con.CIF_Source_System_Id__c = '4';
        //con.RecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByDeveloperName().get('CBRE_Client_Contact').getRecordTypeId();
        return (SObject) con;
    }
}