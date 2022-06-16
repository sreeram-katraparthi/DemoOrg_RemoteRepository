trigger RtypesonChildObj on Merchandise__c (before insert, after insert) {
        TestRecordTypeDeveloperName rt = new TestRecordTypeDeveloperName();
        rt.getRecrodTypeDeveloperNameFromTrigger(trigger.new);
}