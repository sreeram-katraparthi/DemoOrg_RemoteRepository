trigger AccountContactsTrigger on Account (Before insert, After Insert, Before Update, After Update, Before Delete,After Delete, After Undelete) {    
    //Create Contact from Account
    if(trigger.isAfter && trigger.isInsert){
        List<Contact> contactsToInsertList = new List<Contact>();
        for(Account acc : Trigger.new){
            Contact con = new Contact();
            con.LastName = acc.Name;
            con.MailingCity = acc.BillingCity;
            con.MailingStreet = acc.BillingStreet;
            con.MailingState = acc.BillingState;
            con.MailingCountry = acc.BillingCountry;
            con.MailingPostalCode = acc.BillingPostalCode;
            con.AccountId = acc.Id;
            contactsToInsertList.add(con);
        }
        if(contactsToInsertList.size() > 0){
            insert contactsToInsertList;
        }
    }    
        
    if(trigger.isInsert && trigger.isBefore){
        System.debug('Trigger.new : '+trigger.new);
        for(Account acc : Trigger.new){
            //Check annual Revenue
            if(acc.AnnualRevenue < 1000){
                acc.addError('Annual Revenu Should be greater than 1000');
            }
            //Logic to Populate Shipping address from Billing address
            if(acc.ShippingStreet == null && acc.BillingStreet != null )
                acc.ShippingStreet = acc.BillingStreet;
            if(acc.ShippingCity == null && acc.BillingCity != null)
                acc.ShippingCity = acc.BillingCity;
            if(acc.ShippingState == null && acc.BillingState != null)
                acc.ShippingState = acc.BillingState;
            if(acc.ShippingCountry == null  && acc.BillingCountry != null)
                acc.ShippingCountry = acc.BillingCountry;
            if(acc.ShippingPostalCode == null && acc.BillingPostalCode != null)
                acc.ShippingPostalCode = acc.BillingPostalCode;
        }
    }
    
    //Logic to restrict account name update
    if(Trigger.isUpdate && Trigger.isBefore){
        System.debug('IN before update Trigger.New    :   '+Trigger.New);
        System.debug('In Before update Trigger.old    :   '+Trigger.old);
        System.debug('In before update Trigger.oldMap :   '+Trigger.oldMap);
        for(Account accNew : Trigger.new){
            if(accNew.Name != Trigger.oldMap.get(accNew.Id).name)
                accNew.addError('Account Name should not be updated.');
        }
    }
    //Logic to update contact's mailing address if an account's address has updated.
    if(Trigger.isUpdate && Trigger.isAfter){
        Set<Id> changedAccIds = new Set<Id>();
        for(Account accNew : Trigger.new){
            Account oldAcc = Trigger.oldMap.get(accNew.Id);
            if(accNew.BillingCity != oldAcc.BillingCity){
                changedAccIds.add(accNew.Id);
            }
        }
        List<Account> toUpdateContacts = [select Id,Name,BillingCity,(select Id,Name,MailingCity from contacts) from Account where Id IN :changedAccIds];
        List<Contact> consToUpdate = new List<Contact>();
        
        for(Account acc : toUpdateContacts){
            List<Contact> conFromAccount = acc.Contacts;
            for(Contact con : conFromAccount){
                con.MailingCity = acc.BillingCity;
                consToUpdate.add(con);
            }
        }
        update consToUpdate;
    } 
    
    //Don't let delete an active account.
    if(Trigger.isDelete && Trigger.isBefore){
        for(Account oldAcc : Trigger.old){
            if(oldAcc.Active__c == 'Yes'){
                oldAcc.addError('You can not delete an active account.');
            }
        }
    }
    //Send an email to user after deleting an account.
    if(Trigger.isDelete && Trigger.isAfter){
        List<Messaging.SingleEmailMessage> emailObjs = new List<Messaging.SingleEmailMessage>();
        for(Account delAccount : Trigger.old){
            Messaging.SingleEmailMessage emailObj = new Messaging.SingleEmailMessage();
            List<String> emailAddress = new List<String>();
            emailaddress.add(userInfo.getUserEmail());
            emailObj.setToAddresses(emailAddress);
            emailObj.setSubject('Account has been deleted successfully : '+delAccount.Name);
            emailObj.setPlainTextBody('Please refer subject.  Account has been deleted');
            emailObjs.add(emailObj);
        }
        Messaging.sendEmail(emailObjs);
    }
    //Send an email if an account has been restored
    if(Trigger.isUndelete && Trigger.isAfter){
        List<Messaging.SingleEmailMessage> emailObjs = new List<Messaging.SingleEmailMessage>();
        for(Account resAccount : Trigger.new){
            Messaging.SingleEmailMessage emailObj = new Messaging.SingleEmailMessage();
            List<String> emailAddress = new List<String>();
            emailaddress.add(userInfo.getUserEmail());
            emailObj.setToAddresses(emailAddress);
            emailObj.setSubject('Account has been restored successfully : '+resAccount.Name);
            emailObj.setPlainTextBody('Please refer subject.  Account has been restored.');
            emailObjs.add(emailObj);
        }
        Messaging.sendEmail(emailObjs);
    }
}