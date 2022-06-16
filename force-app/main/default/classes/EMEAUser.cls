public class EMEAUser extends UserFactory{

    private String userName{get;set;}
    
    //Constructor
    public EMEAUser () {
        this('cbob1@cbre.com.test');
    }    
    
    //Constructor
    public EMEAUser (String usrName) {
        dataFileStaticResourseName = 'CBREUserTestData';        
        userName = usrName;
    }    
    
    //Set data for Contact
    public SObject setRecordData(User obj) {
        
        /*Profile p = [SELECT Id FROM Profile WHERE Name='CBRE Broker - EMEA - Multi Business Line']; 
        UserRole role = [SELECT Id FROM UserRole WHERE Name='EMEA' limit 1]; 
        
        obj.Alias ='standt';      
        obj.Email = 'cbob1@cbre.com';
        obj.EmailEncodingKey = 'UTF-8';
        obj.LastName = 'emea';
        obj.LanguageLocaleKey = 'en_US';
        obj.LocaleSidKey = 'en_US';
        obj.ProfileId = p.Id;
        obj.Geographical_Role__c = 'EMEA';
        obj.Main_Market__c='UK';
        obj.Sub_Region__c='UK';
        obj.EmployeeNumber='1234567';
        obj.TimeZoneSidKey = 'America/Los_Angeles';
        obj.UserName = userName;
        obj.countrycode = 'NL';
        obj.City = 'Los Angeles';
        obj.Business_Line__c = 'A&T';
        obj.User_Market__c = 'London';
        obj.UserRoleId = role.id;*/ 
        return (SObject) obj;
    }
}