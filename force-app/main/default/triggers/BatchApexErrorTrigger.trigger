trigger BatchApexErrorTrigger on BatchApexErrorEvent (after insert) {
    List<BatchLeadConvertErrors__c> erroRecs = new list<BatchLeadConvertErrors__c>();
    for(BatchApexErrorEvent error : trigger.new){
        BatchLeadConvertErrors__c  errorRec = new BatchLeadConvertErrors__c();
        errorRec.AsyncApexJobId__c = error.AsyncApexJobId;
        errorRec.Records__c = error.JobScope;
        errorRec.StackTrace__c = error.StackTrace;
        erroRecs.add(errorRec);
    }
	insert erroRecs;
}