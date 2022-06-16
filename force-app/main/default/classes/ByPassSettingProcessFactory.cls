public class ByPassSettingProcessFactory extends SObjectFactory {
    
    Private Boolean byPassAll;
    
    public ByPassSettingProcessFactory(Boolean byPassAll) {
        this.byPassAll = byPassAll;
        sObjectType = ByPassSettingProcess__c.sObjectType;
    }
    
    public ByPassSettingProcessFactory() {
        this(false);
    }
    
    public SObject buildRecordWithData() {        
        ByPassSettingProcess__c byPassProcess = new ByPassSettingProcess__c( Name = 'Test');
        return setRecordData(byPassProcess);
    }
    
    Public SObject setRecordData(ByPassSettingProcess__c byPassProcess) {
        if (byPassAll)
            SObjectHelper.setAllBooleanFields('ByPassSettingProcess__c', (sObject) byPassProcess, true);        
        byPassProcess.SetupOwnerId=UserInfo.getUserId();        
        return (SObject) byPassProcess;
    }
}