@isTest
public class TestClass_ContactHelper {
    
    @testSetup static void setupData() {
        
        //ByPass all Validation Rules        
        ByPassSettingValidationRules__c byPassValidation = (ByPassSettingValidationRules__c) new ByPassSettingValidationRulesFactory(true).buildAndInsertRecord();
        //ByPass all Processes Rules
        ByPassSettingProcess__c byPassProcess = (ByPassSettingProcess__c) new ByPassSettingProcessFactory(true).buildAndInsertRecord();
        //ByPass all Triggers Rules
        ByPassSettingTriggers__c byPassTriggers = (ByPassSettingTriggers__c) new ByPassSettingTriggerFactory(true).buildAndInsertRecord();        
        //ByPass all workflow rules
        ByPassSettingWorkflows__c byPassWorkFlows = (ByPassSettingWorkflows__c) new ByPassSettingWorkFlowFactory(true).buildAndInsertRecord();        
        
        //Create APAC Lead User
        //TestUsersGenerator.CreateAPACLeaderUser('APACLeaduser@test.com');
        //Create EMEA User
        TestUsersGenerator.CreateEmeaUser('EmeaTestUser@test.com');
        //Asset services User
        //TestUsersGenerator.CreateIndiaUser('indianTestUser@test.com');
        //Load Accounts from Static Resource
        User emeaUser = [select id, Name,Profile.Name from user where UserName='EmeaTestUser@test.com'];
        
         List<SObject> accts = (List<Account>) new CBREAccountFactory().InsertRecordsFromStaticResource();
        
        //Load Opportunities from Static Resource
        //List<SObject> opps = (List<Opportunity>) new AMERPMHeeryOpportunityFactory().InsertRecordsFromStaticResource();
        
        //Load Contacts from Static Resource
        List<SObject> Cons = (List<Contact>) new CBREClientContactFactory().InsertRecordsFromStaticResource();
		
        //Creating "Location".
        /*Location__c loc_obj = new 
            Location__c(Account__c = accts[0].id,
                        Billing_Street__c = '123 Main Street building left corner and right exit white color building',
                        Billing_City__c = 'Lakewood',Billing_State_Province__c='Oklahoma', Billing_Country__c ='United States',
                        Billing_Zip_Postal_Code__c='75075',IsPrimary__c = true);
        Location__c loc_obj1 = new 
            Location__c(Account__c = accts[0].id,
                        Billing_Street__c = '123 Main Street building',
                        Billing_City__c = 'Irving',Billing_State_Province__c='Texas', Billing_Country__c ='United States',
                        Billing_Zip_Postal_Code__c='75039',IsPrimary__c = false);
        
        List<Location__c> locdatalist = new List<Location__c>();
         locdatalist.add((Location__c) new LocationFactory().setRecordData(loc_obj));
         locdatalist.add((Location__c) new LocationFactory().setRecordData(loc_obj1));
        Insert locdatalist ;*/
    }
    
    static testMethod void testUpdateContactFields() {
        //Query Data created in setupData
        /*User emeaUser = [select id, Name,CountryCode,Profile.Name from user where UserName='EmeaTestUser@test.com'];
        List<Contact> lstCons;
        lstCons = [select id, Name,AccountId,SF_INTG_DATASRC_CREATEDBY_COUNTRY__c,SF_INTG_DATASRC_LASTUPDATEDBY_COUNTRY__c,
                   Last_Manually_Modified_By__c,Account.EMEA_Searchable__c,Last_Manually_Modified_Date__c FROM Contact  WHERE RecordType.developerName = 'CBRE_Client_Contact' limit 1];
        Map<Id, Contact> mapContact = new Map<Id, Contact>(lstCons);
        //Login as test user
        system.runAs(emeaUser) {
            //Run Test
            test.startTest();
            //Calling Method here
            ContactHelper.updateContactFields(lstCons,mapContact);
            test.stopTest();
        }*/
    }
    
    static testMethod void testUpdateAccountFields() {
        //Query Data created in setupData
        /*User apacUser = [select id, Name from user where UserName='APACLeaduser@test.com'];
        User emeaUser = [select id, Name,CountryCode,Profile.Name from user where UserName='EmeaTestUser@test.com'];
        List<Contact> lstCons;
        lstCons = [select id, Name,AccountId,Account.EMEA_Searchable__c FROM Contact  WHERE RecordType.developerName = 'CBRE_Client_Contact' limit 1];
        List<Account> lstAccounts = [select id,EMEA_Searchable__c, Name, Investor_Services_Account__c from Account];            
        for(Contact c: lstCons) {
		c.AccountId=lstAccounts[0].id;		
		}
		update lstCons;
		for(Account acc:lstAccounts) {
		acc.Investor_Services_Account__c =false;
        acc.EMEA_Searchable__c = false;
        acc.OwnerId = emeaUser.Id;
		}
		update lstAccounts;
		SObjectUnitOfWork unitOfWork = new SObjectUnitOfWork();
        List<Schema.SObjectType> sObjectTypes = new List<Schema.SObjectType>();
        sObjectTypes.add(Contact.getSObjectType());
        sObjectTypes.add(Account.getSObjectType());
        unitOfWork.addObjectTypes(sObjectTypes);
        //Login as test user
        system.runAs(apacUser) {
            //Run Test
            test.startTest();
            //Calling Method here
            ContactHelper.updateAccountFields(lstCons,unitOfWork);
            test.stopTest();
        }*/
    }
    
    static testMethod void testInActivePreviousContact() {
        //Query Data created in setupData
       /* User apacUser = [select id, Name from user where UserName='APACLeaduser@test.com'];
        List<Contact> lstCons;
        lstCons = [select id, Name,Inactive_Contact__c,AccountId FROM Contact  WHERE RecordType.developerName = 'CBRE_Client_Contact'];
        SObjectUnitOfWork unitOfWork = new SObjectUnitOfWork();
        List<Schema.SObjectType> sObjectTypes = new List<Schema.SObjectType>();
        sObjectTypes.add(Contact.getSObjectType());
        sObjectTypes.add(Account.getSObjectType());
        unitOfWork.addObjectTypes(sObjectTypes);
        //Login as test user
        system.runAs(apacUser) {
            //Run Test
            test.startTest();
            //Calling Method here
            ContactHelper.inActivePreviousContact(lstCons,unitOfWork);
            test.stopTest();
        }*/
    }
    
    static testMethod void testContactActivateAndInactivationCheck() {
        //Query Data created in setupData
        /*User apacUser = [select id, Name from user where UserName='APACLeaduser@test.com'];
        List<Contact> lstCons;
        lstCons = [select id, Name,Status__c,Inactive_Contact__c,AccountId FROM Contact  WHERE RecordType.developerName = 'CBRE_Client_Contact' limit 1];
        
        Map<Id, Contact> mapContact = new Map<Id, Contact>(lstCons);
        for(Contact c: lstCons) {
            c.Status__c = 'Active';
        }
        update lstCons;
        SObjectUnitOfWork unitOfWork = new SObjectUnitOfWork();
        List<Schema.SObjectType> sObjectTypes = new List<Schema.SObjectType>();
        sObjectTypes.add(Contact.getSObjectType());
        sObjectTypes.add(Account.getSObjectType());
        unitOfWork.addObjectTypes(sObjectTypes);
        //Login as test user
        system.runAs(apacUser) {
            //Run Test
            test.startTest();
            //Calling Method here
            ContactHelper.contactActivateAndInactivationCheck(lstCons,mapContact,unitOfWork);
            test.stopTest();
        }*/
    }
}