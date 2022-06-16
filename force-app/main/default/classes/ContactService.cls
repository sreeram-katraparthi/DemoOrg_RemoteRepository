public with sharing class ContactService {
    
/*public static void updateContactMaliningAddress(List<Contact> contactList, Map<Id,Contact> mapOldContacts){
ContactHelper.updateContactMaliningAddress(contactList, mapOldContacts);
} 
    public static void updateContactFields(List<Contact> contactList, Map<Id,Contact> mapOldContacts){
        ContactHelper.updateContactFields(contactList, mapOldContacts);
    }
    
    
    public static void updateDummyAccountOnContact(List<Contact> contactList){
        ContactHelper.updateDummyAccountOnContact(contactList);
    }
    
    public static void syncContactAlias(List<Contact> contactList,Map<Id,Contact> mapOldContacts, SObjectUnitOfWork unitOfWork){
        ContactHelper.syncContactAlias(contactList,mapOldContacts,unitOfWork);
    }
    
    public static void updateAccountFields(List<Contact> contactList, SObjectUnitOfWork unitOfWork){
        ContactHelper.updateAccountFields(contactList,unitOfWork);
    }
     
    public static void inActivePreviousContact(List<Contact> contactList,SObjectUnitOfWork unitOfWork){
        ContactHelper.inActivePreviousContact(contactList,unitOfWork);
    }
          
    public static void contactActivateAndInactivationCheck(List<Contact> contactList,Map<Id,Contact> mapOldContacts,SObjectUnitOfWork unitOfWork){
        ContactHelper.contactActivateAndInactivationCheck(contactList,mapOldContacts,unitOfWork);
    }
    
         
    public static void updateContactRelationshipsOfContacts(List<Contact> contactList, SObjectUnitOfWork unitOfWork){
        ContactHelper.updateContactRelationshipsOfContacts(contactList,unitOfWork);
    }
    
        
    public static void updatePreferencesOfContacts(List<Contact> contactList, Map<Id,Contact> mapOldContacts, SObjectUnitOfWork unitOfWork){
        Map<string,Object> inactiveContactMap = ContactHelper.retrieveInactiveContactIdsWithOptions(contactList,mapOldContacts);
        Map<String,APAC_Preference_Update_Values__c> preferenceUpdateValuesMap = new Map<String,APAC_Preference_Update_Values__c>(); 
        system.debug('=============inactiveContactMap============='+inactiveContactMap);
        
        preferenceUpdateValuesMap = APAC_Preference_Update_Values__c.getAll();
        system.debug('=============preferenceUpdateValuesMap============='+preferenceUpdateValuesMap);
        if(!inactiveContactMap.isEmpty() && !preferenceUpdateValuesMap.isEmpty()) {
            ContactHelper.updateInvestorPreferencesOfContacts(inactiveContactMap,preferenceUpdateValuesMap,unitOfWork);
            ContactHelper.updatePropertyPreferencesOfContacts(inactiveContactMap,preferenceUpdateValuesMap,unitOfWork); 
            ContactHelper.updateSubscriptionsOfContacts(inactiveContactMap,preferenceUpdateValuesMap,unitOfWork);
        }        
    }
    
    
    public static void mergeContactsBeforeContactDelete(List<Contact> contactList){
        ContactHelper.mergeContactsBeforeContactDelete(contactList);
    }
    
    
    public static void mergeContactsAfterContactDelete(List<Contact> contactList){
        ContactHelper.mergeContactsAfterContactDelete(contactList);
    }
    
    
    public static void createFeeSharePartnerUsers(List<Contact> contactList, Map<Id,Contact> mapOldContacts) {
        List<Contact> lstConts = new List<Contact>();
        lstConts = ContactHelper.retrieveFeeSharePartnerContacts(contactList,mapOldContacts);
        if (!lstConts.isEmpty()) {
            ContactHelper.createFeeSharePartnerUsers(lstConts);
        }
    }    
   
    public static void checkAccountNameNotNull(List<Contact> contactList){
        ContactHelper.checkAccountNameNotNull(contactList); 
        
    }
    
    public static void trackMarketingPreferences(List<Contact> contactList, Map<Id,Contact> mapOldContacts, SObjectUnitOfWork unitOfWork){
        ContactHelper.createCustomTracking(contactList, mapOldContacts, unitOfWork);
        
    }
    
    public static void copyMarketingPreferenceFields(List<Contact> contactList){
        ContactHelper.copyContactPreferenceFields(contactList);
    }
    
    
    
    public static void populateArgoSourceOnContact(List<Contact> contactList) {  
        ContactHelper.populateArgoSourceOnContact(contactList);
    }
    
    
    public static void MatchContactAccountByDomainName(List<Contact> contactList, SObjectUnitOfWork unitOfWork) {  
        ContactHelper.MatchContactAccountByDomainName(contactList,unitOfWork);
    } 
    
    
            public static void CreateContactRelationAfterSync(List<Contact> contactList, SObjectUnitOfWork unitOfWork) {  
        ContactHelper.CreateContactRelationAfterSync(contactList,unitOfWork);
    } 
    
    
    
    public static void UpdateContactAlias(List<Contact> contactList, Map<Id,Contact> mapOldContacts,SObjectUnitOfWork unitOfWork) {  
        ContactHelper.UpdateContactAlias(contactList,mapOldContacts,unitOfWork);
    }
    
    public static void updateContactAddress(List<Contact> contactList) {  
        ContactHelper.updateContactAddress(contactList);
    }
    
    public static void updateContactSourceofMailingAddress(List<Contact> contactList,Map<Id,Contact> mapOldContacts) {  
        ContactHelper.updateContactSourceofMailingAddress(contactList,mapOldContacts);
    }
    
    public static void updateLastContactedFields(Map<ID, Map<Integer,Set<String>>> dateContactUserMap,List<Contact> scopeContacts,Map<Integer, Set<String>> daysFieldMap){
        ContactHelper.updateLastContactedFields(dateContactUserMap,scopeContacts,daysFieldMap);
    }
    
    public static String updateEmailPreference(Set<Id> conIdSet, String actionType, String reason){
        try{
            List<Id> conIdList = new List<Id>();
            conIdList.addAll(conIdSet);
            
            Contact conRec = new Contact();
            conRec.Id = conIdList[0];
            if(actionType == 'optout'){
                conRec.Email_Options__c = 'Email Opt Out';
                conRec.APAC_Exclude_Reason__c = (reason == null || reason == '') ? 'Unsubscribe': reason; 
            }
            else{
                conRec.Email_Options__c = 'Email Opt In';
                conRec.APAC_Exclude_Reason__c = '';
            }
            update conRec;
            return 'SUCCESS';
        }
        catch(Exception e){
            Exception_Log__e expLog = new Exception_Log__e();
            expLog.Class_Name__c = 'ContactService';
            expLog.Method_Name__c = 'updateEmailPreference';
            expLog.Error_Message__c = e.getMessage();
            expLog.Stack_Trace__c =  e.getStackTraceString();
            EventBus.publish(expLog);
            
            return e.getMessage();
        }
        
    }
    
    //VSTS# 787191 Deactivating the ACR on old (immediate) account
    public static void deactivateACRonAccChange(List<Contact> contactList, Map<Id,Contact> mapOldContacts, SObjectUnitOfWork unitOfWork){
        // get contact whose acc changed
        List<Contact> conList = new List<Contact>();
        Map<Id, Id> contPrevAccIdMap = new Map<Id, Id>();
        Map<Id, Id> contAccIdMap = new Map<Id, Id>();
        Set<Id> accIdSet = new Set<Id>();
        Id clientConRTId = Schema.SObjectType.Contact.getRecordTypeInfosByDeveloperName().get('CBRE_Client_Contact').getRecordTypeId();
        for(Contact conRec : contactList){
            if(conRec.RecordTypeId == clientConRTId && !(conRec.Created_By_User_Region__c == 'APAC' || conRec.Created_By_User_Region__c == '' || conRec.Created_By_User_Region__c == null)
               && conRec.AccountId != mapOldContacts.get(conRec.Id).AccountId){
                   contPrevAccIdMap.put(conRec.Id, mapOldContacts.get(conRec.Id).AccountId);
                   contAccIdMap.put(conRec.Id, conRec.AccountId);
                   accIdSet.add(conRec.AccountId);
                   accIdSet.add(mapOldContacts.get(conRec.Id).AccountId);
               }
        }
        // update the the acr of the old accounts 
        List<AccountContactRelation> acrInactivateList = new List<AccountContactRelation>();
        if(!contPrevAccIdMap.isEmpty()) {
            List<AccountContactRelation> acrList = new List<AccountContactRelation>();
            acrList = AccountContactRelationSelector.getAllAccountContactRelation(accIdSet, contPrevAccIdMap.keySet(), true);
            for(AccountContactRelation acrRec : acrList){
                if(contPrevAccIdMap.containsKey(acrRec.contactId))
                    if(contPrevAccIdMap.get(acrRec.contactId) == acrRec.AccountId && acrRec.IsActive == true){
                        acrRec.IsActive = false;
                        acrInactivateList.add(acrRec);
                    }else if(contAccIdMap.get(acrRec.contactId) == acrRec.AccountId && acrRec.IsActive == false){
                        acrRec.IsActive = true;
                        acrInactivateList.add(acrRec);
                    }
            }
        }
        if(acrInactivateList.size() > 0){
        //	unitOfWork.registerDirty(acrInactivateList); 
            final string SOBJECTTYPE_ACR = 'AccountContactRelation';
            List<String> dirtyFields = New List<String>{'IsActive'};
			//Map<String, List<Schema.SobjectField>> mapOfSObjecTypeAndDirtyFields = New Map<String, List<Schema.SobjectField>>();
			//mapOfSObjecTypeAndDirtyFields = SObjectUnitOfWork.getSObjectFields(SOBJECTTYPE_ACR, dirtyFields);
            unitOfWork.registerDirty(acrInactivateList, SOBJECTTYPE_ACR, dirtyFields);
        }
        
    }
    
        
    Public static void resetLocationOnContact(List<Contact> listOfConts, Map<Id, Contact> mapOfOldConts){
        Set<Id> locIds = New Set<Id>();
        //Reset the Location(lookup) to blank if the Account Name is changed on the Opprtunity.
        for(Contact cont : listOfConts){
            if(!String.isBlank(cont.AccountId) && mapOfOldConts != null && cont.AccountId != mapOfOldConts.get(cont.Id).AccountId){
                cont.Location__c = NULL;
            }
            else if(!String.isBlank(cont.Location__c) && ((mapOfOldConts != null && cont.Location__c != mapOfOldConts.get(cont.Id).Location__c) || mapOfOldConts == null)){
                locIds.add(cont.Location__c);
            }  
        }
        if(locIds.size() > 0){
            Map<Id, Location__c> mapOfLocs = LocationSelector.getLocationsWithActs(locIds, FALSE);
            for(Contact cont2 : listOfConts){
                if(cont2.AccountId != mapOfLocs.get(cont2.Location__c).Account__c){
                    cont2.addError(System.Label.validateLocaionOnCont);
                }
             }
        }
    }*/
}