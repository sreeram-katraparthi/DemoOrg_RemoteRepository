public class contacthelper {
	/*public static void updateContactSourceofMailingAddress(List<Contact> contactList,Map<Id,Contact> mapOldContacts) {  
        profile loggedInUserProfile  = ProfileSelector.getProfileById(userinfo.getProfileId());
        User loggedInUser = UserSelector.getLoggedInUser(userinfo.getUserId(),false);
       	if(Test.isRunningTest()){
            loggedInUser = UserSelector.getLoggedInUser(userinfo.getUserId(),true);
        }
        List<PermissionsetAssignment> userPermissionsets = PermissionSetAssignmentSelector.getUserPermissionSets(false);
        system.debug('mapOldContacts::::'+mapOldContacts);
        //VSTS #872157 Case : 37339 Enabling for APAC users and replacing Site with Locations.
        if(loggedInUser.Geographical_Role__c == 'EMEA' || loggedInUser.Geographical_Role__c == 'APAC'){
            if(mapOldContacts != null){
                for(Contact newConRec : contactList){
                    if((loggedInUserProfile.name.contains('Data Admin') || 
                       (loggedInUser.Geographical_Role__c == 'APAC' || loggedInUser.CountryCode == 'DE') || 
                       userPermissionsets.size()>0) && 
                        (newConRec.mailingstreet != mapOldContacts.get(newConRec.Id).mailingstreet ||
                         newConRec.mailingcity != mapOldContacts.get(newConRec.Id).mailingcity ||
                         newConRec.mailingstate != mapOldContacts.get(newConRec.Id).mailingstate ||
                         newConRec.mailingcountry != mapOldContacts.get(newConRec.Id).mailingcountry || 
                         newConRec.mailingpostalcode != mapOldContacts.get(newConRec.Id).mailingpostalcode
                    )){
                        newConRec.Source_of_Mailing_Address__c = 'Manual Update';
                    }else {
                        if(newConRec.Source_of_Mailing_Address__c != mapOldContacts.get(newConRec.Id).Source_of_Mailing_Address__c ||
                           newConRec.AccountId != mapOldContacts.get(newConRec.Id).AccountId ||
                           newConRec.Location__c != mapOldContacts.get(newConRec.Id).Location__c){
                            if(newConRec.Location__c !=null && newConRec.Source_of_Mailing_Address__c != mapOldContacts.get(newConRec.Id).Source_of_Mailing_Address__c){
                                newConRec.Source_of_Mailing_Address__c = newConRec.Source_of_Mailing_Address__c;
                            }else if(newConRec.Location__c !=null && newConRec.Source_of_Mailing_Address__c == mapOldContacts.get(newConRec.Id).Source_of_Mailing_Address__c){
                                newConRec.Source_of_Mailing_Address__c = 'Location address';
                            }else if(newConRec.Location__c ==null){
                                newConRec.Source_of_Mailing_Address__c = 'Account Address';
                            }
                        }
                    }
                }
            }
        }
    }

    public static void updateContactAddress(List<Contact> contactList) {
        User loggedInUser = UserSelector.getLoggedInUser(userinfo.getUserId(),true);
        if(loggedInUser.Geographical_Role__c == 'EMEA' || loggedInUser.Geographical_Role__c == 'APAC'){
            Set<Id> accountIdsList = new Set<Id>();
            Set<Id> locationIds = new Set<Id>();
            for(Contact con : contactList) {
                if(con.Location__c != null){
                    locationIds.add(con.Location__c);
                }
                if(con.AccountId != null){
                    accountIdsList.add(con.AccountId);
                }
            }
            Map<Id,Account> accMap = new Map<Id,Account>();
            Map<Id,Location__c> locMap = new Map<Id,Location__c>();
            accMap = AccountSelector.selectById(accountIdsList,true);
            //VSTS #872157 Case : 37339 copy location address to contact.
            locMap = LocationSelector.getLocationsById(locationIds,true);
            for(Contact con : contactList) {
                if(con.Source_of_Mailing_Address__c != 'Manual Update'){
                    if(con.Source_of_Mailing_Address__c == 'Account Address')
                    {
                        if(accMap.containsKey(con.AccountId) && (accMap.get(con.AccountId).shippingstreet != null || accMap.get(con.AccountId).shippingcity != null || accMap.get(con.AccountId).shippingstate !=null || accMap.get(con.AccountId).shippingcountry !=null || accMap.get(con.AccountId).shippingPostalCode !=null))
                        {
                            con.MailingStreet = accMap.get(con.AccountId).shippingstreet;
                            con.MailingCity = accMap.get(con.AccountId).shippingcity;
                            con.MailingState = accMap.get(con.AccountId).shippingstate;
                            con.MailingCountry = accMap.get(con.AccountId).shippingcountry;
                            con.MailingPostalCode = accMap.get(con.AccountId).shippingPostalCode;
                        }
                        else if(accMap.containsKey(con.AccountId)){
                            con.MailingStreet = accMap.get(con.AccountId).Billingstreet;
                            con.MailingCity = accMap.get(con.AccountId).Billingcity;
                            con.MailingState = accMap.get(con.AccountId).Billingstate;
                            con.MailingCountry = accMap.get(con.AccountId).BillingCountry;
                            con.MailingPostalCode = accMap.get(con.AccountId).BillingPostalCode;
                        } 
                    }
                    //VSTS #872157 Case : 37339 copy location address to contact.
                    else if(con.Source_of_Mailing_Address__c == 'Location address'){
                        if(con.Location__c != null){
                            if(locMap.containsKey(con.Location__c) && (locMap.get(con.Location__c).Local_Street__c != null || locMap.get(con.Location__c).Local_City__c != null || locMap.get(con.Location__c).Local_State_Province__c !=null || locMap.get(con.Location__c).Local_Country__c !=null || locMap.get(con.Location__c).Local_Zip_Postal_Code__c !=null))
                            {
                                con.MailingStreet = locMap.get(con.Location__c).Local_Street__c;
                                con.MailingCity = locMap.get(con.Location__c).Local_City__c;
                                con.MailingState = locMap.get(con.Location__c).Local_State_Province__c;
                                con.MailingCountry = locMap.get(con.Location__c).Local_Country__c;
                                con.MailingPostalCode = locMap.get(con.Location__c).Local_Zip_Postal_Code__c;
                            }
                            else if(locMap.containsKey(con.Location__c)){
                                con.MailingStreet = locMap.get(con.Location__c).Billing_Street__c;
                                con.MailingCity = locMap.get(con.Location__c).Billing_City__c;
                                con.MailingState = locMap.get(con.Location__c).Billing_State_Province__c;
                                con.MailingCountry = locMap.get(con.Location__c).Billing_Country__c;
                                con.MailingPostalCode = locMap.get(con.Location__c).Billing_Zip_Postal_Code__c;
                            }
                        }
                        else{
                            //con.addError(System.Label.ContactSiteNotSpecified);
                            con.addError(System.Label.ContactLocationNotSpecified);
                        }
                    }
                }
                
            }
        }
    } */
}