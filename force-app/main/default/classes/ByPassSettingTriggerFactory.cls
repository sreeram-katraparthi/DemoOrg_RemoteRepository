public class ByPassSettingTriggerFactory extends SObjectFactory {
    
    Private Boolean byPassAll;
    
    public ByPassSettingTriggerFactory(Boolean byPassAll) {
        this.byPassAll = byPassAll;
        sObjectType = ByPassSettingTriggers__c.sObjectType;
    }
    
    public ByPassSettingTriggerFactory() {
        this(false);
    }    
    
    public SObject buildRecordWithData() {        
        ByPassSettingTriggers__c obj = new ByPassSettingTriggers__c( Name = 'Test');
        return setRecordData(obj);
    }
    
    Public SObject setRecordData(ByPassSettingTriggers__c obj) {        
        if (byPassAll)
            SObjectHelper.setAllBooleanFields('ByPassSettingTriggers__c', (sObject) obj, true);        
        obj.SetupOwnerId=UserInfo.getUserId();
        return (SObject) obj;
    }
}