trigger ContactTrigger on Contact (after delete, after insert, after update, before delete, before insert, before update, after undelete) {
    system.debug(logginglevel.ERROR, 'OIPerf|start|ContactTrigger|' + (Trigger.isBefore ? 'before|' : 'after|') + (Trigger.isInsert ? 'insert|' : (Trigger.isUpdate ? 'update|' : 'delete|'))
                 + 'cpu|' + Limits.getCpuTime() + '|time|' + datetime.now().getTime());
    
    if (ByPassSettingTriggers__c.getInstance().ContactTrigger__c) {
        System.Debug('Contact Trigger ByPassed.');
        return;
    }
    // Creates Domain class instance and calls apprpoprite overideable methods according to Trigger state
    SObjectDomain.triggerHandler(Contact.class);
    /*If(!Test.isRunningTest()){
    //Moved rollup call to main trigger (added after undelete event)
    dlrs.RollupService.triggerHandler();
    }*/
    
    system.debug(logginglevel.ERROR, 'OIPerf|end|ContactTrigger|' + (Trigger.isBefore ? 'before|' : 'after|') + (Trigger.isInsert ? 'insert|' : (Trigger.isUpdate ? 'update|' : 'delete|'))
                 + 'cpu|' + Limits.getCpuTime() + '|time|' + datetime.now().getTime());    
}