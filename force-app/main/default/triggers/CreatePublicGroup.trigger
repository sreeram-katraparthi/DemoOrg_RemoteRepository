trigger CreatePublicGroup on Account (after insert, after update) {
    
    List<string> accNames = new List<String>();
    for(account acc : trigger.new){
        accNames.add(acc.Name);
    }    
    List<group> groups = [select id from group where name IN : accNames];
    List<group> toInsert = new List<Group>();
    /*if(groups.isEmpty()){
        for(account acc : trigger.new){
            group pg = new group();
            pg.name = acc.Name;
            toInsert.add(pg);
        }
        insert toInsert;
    }else{
        Trigger.new[0].addError('Public group already exist with the same name');
    }*/
    
    if(trigger.isupdate && trigger.isafter){
        List<Account> accList = new List<Account>();
        for(Account a : trigger.old){
            system.debug('in after trgger'+a);
            Account acc = a.clone(false,false,false,false);
            if(acc.Rating == 'Hot'){
                system.debug('rating'+acc.rating);
                acc.Primary_Account__c = a.Id;
                acc.Rating = 'Cold';
                acc.Phone='1234567890';
            }
            accList.add(acc);
        }
        insert accList;
        system.debug(accList);
    }
}