public with sharing class ContactHandler extends SObjectDomain {
    List<Contact> contactList;
    Map<Id,Contact> mapOldContacts;
    
    public ContactHandler(List<Contact> sObjectList) {
        super(sObjectList);
        contactList = sObjectList;
        // register types for SObjectUnitOfWork
        List<Schema.SObjectType> sObjectTypes = new List<Schema.SObjectType>();
        sObjectTypes.add(Contact.getSObjectType());
        sObjectTypes.add(Account.getSObjectType());
        //sObjectTypes.add(Location__c.getSObjectType());
        
        //Added by Mphasis Team for test class purpose
        if(Test.isRunningTest() && unitOfWork == null){
           unitOfWork = new SObjectUnitOfWork ();
        }
        
        unitOfWork.addObjectTypes(sObjectTypes);
    }
    
    /*public override void onBeforeInsert() {
        //Update contact Maling Address with Contacts account mailing address.
        #333437- This Code is covered in WORKFLOW - "Copy Billing Address from Account".
       // ContactService.updateContactMaliningAddress(contactList,null); 
        //ContactService.updateContactFields(contactList,null); //US# 805530
    }
    
    /*public override void onAfterInsert() {
        ContactService.syncContactAlias(contactList,null,unitOfWork);
        //ContactService.createContactAlias(contactList,unitOfWork);
        ContactService.updateAccountFields(contactList, unitOfWork);
        ContactService.inActivePreviousContact(contactList, unitOfWork);        
         // US 820382 - ByPass for automated actions when a contact is synced from Lightning Sync
          System.debug('$#$ Bypass' + ByPassSettingTriggers__c.getInstance().Contact_Lightning_Sync_Domain_Match__c);
        if (!ByPassSettingTriggers__c.getInstance().Contact_Lightning_Sync_Domain_Match__c) 
        {
             ContactService.matchContactAccountByDomainName(contactList,unitOfWork);
        }
        
          System.debug('$#$ Bypass' + ByPassSettingTriggers__c.getInstance().Contact_Lightning_Sync_Create_ContactRel__c);
        if (!ByPassSettingTriggers__c.getInstance().Contact_Lightning_Sync_Create_ContactRel__c) 
        {
             ContactService.CreateContactRelationAfterSync(contactList,unitOfWork);
        } 
       
        if(!Test.isRunningTest()){
        	CIFBaseInterface cntctTriggerHandler=CIFTriggerFactory.executeCreateHandler(Contact.sObjectType,'OUT');
        }
        ContactService.createFeeSharePartnerUsers(contactList,null);
        
        ContactService.trackMarketingPreferences(contactList, null, unitOfWork);
            
    }
    
    public override void onBeforeUpdate(Map<Id,SObject> existingRecords) {
        system.debug('Handler Debug on before update');
        mapOldContacts = (Map<Id,Contact>)existingRecords;
        //Update contact Maling Address with Contacts account mailing address.
        /*#333437- This Code is covered in WORKFLOW - "Copy Billing Address from Account".
       // ContactService.updateContactMaliningAddress(contactList,mapOldContacts); */
        /*ContactService.updateContactFields(contactList,mapOldContacts);
        ContactService.checkAccountNameNotNull(contactList);
        ContactService.updateDummyAccountOnContact(contactList);
        ContactService.copyMarketingPreferenceFields(contactList);  
        //TFS ## 332952
       // ContactService.populateArgoSourceOnContact(contactList);
        ContactService.updateContactSourceofMailingAddress(contactList,mapOldContacts);
        ContactService.updateContactAddress(contactList);
        ContactService.resetLocationOnContact(contactList, mapOldContacts); //US# 805530
    }
    
    public override void onAfterUpdate(Map<Id,SObject> existingRecords) {
        
        mapOldContacts = (Map<Id,Contact>)existingRecords;
        ContactService.syncContactAlias(contactList,mapOldContacts,unitOfWork);
        ContactService.updateAccountFields(contactList, unitOfWork);
        ContactService.updateContactRelationshipsOfContacts(contactList, unitOfWork);
        ContactService.inActivePreviousContact(contactList, unitOfWork);
        ContactService.updatePreferencesOfContacts(contactList,mapOldContacts,unitOfWork);
        if(!Test.isRunningTest()){
        	CIFBaseInterface cntctTriggerHandler=CIFTriggerFactory.executeCreateHandler(Contact.sObjectType,'OUT');
        }
        ContactService.createFeeSharePartnerUsers(contactList,mapOldContacts);        
        ContactService.trackMarketingPreferences(contactList, mapOldContacts, unitOfWork);
        //VSTS# 787191 Deactivating the ACR on old (immediate) account
        ContactService.deactivateACRonAccChange(contactList, mapOldContacts, unitOfWork);
        
        if (ContactHelper.contactInactivationCheck){
            ContactHelper.contactInactivationCheck = false;
            ContactService.contactActivateAndInactivationCheck(contactList,mapOldContacts,unitOfWork);
        }
        
        //TFS ## 332952
        //ContactService.UpdateContactAlias(contactList,mapOldContacts,unitOfWork);
    }
    
    public override void onAfterUpdateInprogress(Map<Id,SObject> existingRecords) {
        if(!Test.isRunningTest()){
            CIFTriggerFactory.executeCreateHandler(Contact.sObjectType,'OUT');
        }
    }
    
    public override void onBeforeUpdateInprogress(Map<Id,SObject> existingRecords) {}
    
    public override void onBeforeDelete() {
        // TFS 311881 - Send delete message on contact deletion
         if(!Test.isRunningTest()){
            CIFTriggerFactory.executeCreateHandler(Contact.sObjectType, 'OUT');
        }
        ContactService.mergeContactsBeforeContactDelete(contactList);
        
    }
    
    public override void onAfterUnDelete() {}
    
    public override void onAfterDelete() {
        ContactService.mergeContactsAfterContactDelete(contactList);
        if(!Test.isRunningTest()){
        	CIFTriggerFactory.executeCreateHandler(Contact.sObjectType,'OUT');
        }
        
    }
    
    public override void onValidate() {}
    
    public class Constructor implements SObjectDomain.IConstructable {
        public SObjectDomain construct(List<SObject> sObjectList) {
            return new ContactHandler(sObjectList);
        }
    }*/
}