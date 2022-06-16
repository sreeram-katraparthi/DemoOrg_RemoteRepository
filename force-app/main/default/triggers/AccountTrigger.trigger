trigger AccountTrigger on Account (before insert, after Insert,before update,after update) {
    //Trigger.isInsert
    //Trigger.isBefore 
    //Trigger.isUpdate 
    //Trigger.isAfter
    //Trigger.new 
    if(Trigger.isInsert && Trigger.isBefore){
        System.debug('Trigger.New : '+Trigger.New);
        for(Account acc : Trigger.New){           
            if(acc.ShippingStreet == null && acc.BillingStreet != null)
            	acc.ShippingStreet = acc.BillingStreet;
            if(acc.ShippingCity == null && acc.BillingCity != null)
            	acc.ShippingCity = acc.BillingCity;
            if(acc.ShippingState == null && acc.BillingState != null)
            	acc.ShippingState = acc.BillingState;
            if(acc.ShippingCountry == null && acc.BillingCountry != null)
            	acc.ShippingCountry = acc.BillingCountry;
            if(acc.ShippingPostalCode == null && acc.BillingPostalCode != null)
            	acc.ShippingPostalCode = acc.BillingPostalCode;
             if(acc.AnnualRevenue < 1000){
                acc.addError('Please provide annual revenue > 1000 for the account.');
            }
        }
        System.debug('After assignment Trigger.New : '+Trigger.New);
    }
    if(Trigger.isInsert && Trigger.isAfter){
        List<Contact> conList = new List<Contact>();
        for(Account acc : Trigger.New){
            Contact con = new Contact();
            con.AccountId = acc.Id;
            con.LastName = acc.Name;
            con.MailingStreet = acc.BillingStreet;
            con.MailingCity = acc.BillingCity;
            con.MailingState = acc.BillingState;
            con.MailingCountry = acc.BillingCountry;
            con.MailingPostalCode = acc.BillingPostalCode;
            conList.add(con);
        }
        if(conList.size() > 0){            
        	insert conList;
        }
    }
    if(Trigger.isUpdate && Trigger.isBefore){
        System.debug('in before update Trigger.new: '+Trigger.new);
        System.debug('in before update Trigger.old : '+Trigger.old);
        System.debug('in before update Trigger.oldMap : '+Trigger.oldMap);
        for(Account acc : Trigger.New){
            if(acc.Name != Trigger.oldMap.get(acc.Id).Name){
                acc.addError('You can not change the name!! from : '+acc.Name+' To : '+Trigger.oldMap.get(acc.Id).Name);
            }
        }
    }
    if(Trigger.isUpdate && Trigger.isAfter){
        System.debug('after Updating address Trigger.new : '+Trigger.New);
        System.debug('after Updating address Trigger.old : '+Trigger.old);
        System.debug('after Updating address Trigger.oldMap : '+Trigger.oldMap);
        Set<Id> updatedAccIds = new Set<Id>();
        for(Account acc : Trigger.New){
            System.debug('From new acc.BillingCity : '+acc.BillingCity);
            System.debug('From oldMap acc.BillingCity : '+Trigger.oldMap.get(acc.Id).BillingCity);
            if(acc.BillingCity != Trigger.oldMap.get(acc.Id).BillingCity){
                updatedAccIds.add(acc.Id);
            }
            List<Account> updatedAccountsList = [SELECT Id,BillingCity,(SELECT Id,MailingCity from Contacts) from Account where Id IN :updatedAccIds];
            List<Contact> toUpdateContactsList = new List<Contact>();
            for(Account act : updatedAccountsList){
                List<Contact> conList = act.Contacts;
                for(Contact con : conList){
                    con.MailingCity = act.BillingCity;
                    toUpdateContactsList.add(con);
                }
            }
            update toUpdateContactsList;
        }        
    } 
    if(Trigger.isdelete && Trigger.isBefore){
        System.debug('after Delete || Trigger.New : '+Trigger.new);
        System.debug('after Delete || Trigger.NewMap : '+Trigger.newMap);
        System.debug('after Delete || Trigger.old : '+Trigger.old);
        System.debug('after Delete || Trigger.oldMap : '+Trigger.oldMap);
    }
}