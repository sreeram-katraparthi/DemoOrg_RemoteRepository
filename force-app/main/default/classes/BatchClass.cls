global class BatchClass implements Database.Batchable<sObject>, Database.Stateful {
    global List<String> exception_List;
    global Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator('select id,UpsellOpportunity__c from Account');
    }
    
    global void Execute(Database.BatchableContext bc, List<Account> scope){
        List<Account> AcctsToUpdate = new List<Account>();
        integer SUCCESSCOUNT = 0;
        integer FAILCOUNT = 0;
        string ERRORMSG = '';
        for(Account acc : scope){
            if(acc.UpsellOpportunity__c == null){
                acc.UpsellOpportunity__c = 'test update';
                AcctsToUpdate.add(acc);
            }            
        }
        System.debug('** AcctsToUpdate.size() **'+AcctsToUpdate.size());
        Database.SaveResult[] SaveResultList = Database.update(AcctsToUpdate,false);
        for(integer i =0; i<AcctsToUpdate.size();i++){
            If(!SaveResultList[i].isSuccess()){
                System.debug('** ERRORMSG **'+ERRORMSG);
                ERRORMSG += AcctsToUpdate.get(i).id + '\n'+'Error: "';        
                for(Database.Error err: SaveResultList[i].getErrors()){  
                    ERRORMSG += err.getmessage()+'"\n\n';
                } 
            }
            system.debug('** ERRORMSG **'+ERRORMSG);
            if(ERRORMSG != '')
                exception_List.add(ERRORMSG);
        } 
    }
    global void finish(Database.BatchableContext bc){
        system.debug('in final method');
        AsyncApexJob a = [Select Id, Status,ExtendedStatus,NumberOfErrors, JobItemsProcessed,TotalJobItems, CreatedBy.Email from AsyncApexJob where Id =:BC.getJobId()];
        
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[] {'sreeram7899@gmail.com'};
            mail.setToAddresses(toAddresses);
        mail.setSubject('Match Merge Batch ' + a.Status);
        mail.setPlainTextBody('records processed ' + a.TotalJobItems +   'with '+ a.NumberOfErrors + ' failures.' + exception_List);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        system.debug('** after sending email **');
    }
}