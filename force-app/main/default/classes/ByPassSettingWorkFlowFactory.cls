public class ByPassSettingWorkFlowFactory extends SObjectFactory{
Private Boolean byPassAll;
    
    public ByPassSettingWorkFlowFactory(Boolean byPassAll) {
        this.byPassAll = byPassAll;
        sObjectType = ByPassSettingWorkflows__c.sObjectType;
    }
    
    public ByPassSettingWorkFlowFactory() {
        this(false);
    }
    
    public SObject buildRecordWithData() {        
        ByPassSettingWorkflows__c  byPassProcess = new ByPassSettingWorkflows__c( Name = 'Test');
        return setRecordData(byPassProcess);
    }
    
    Public SObject setRecordData(ByPassSettingWorkflows__c byPassProcess) {
        if (byPassAll){
             SObjectHelper.setAllBooleanFields('ByPassSettingWorkflows__c', (sObject) byPassProcess, true);   
        }
                
        byPassProcess.SetupOwnerId=UserInfo.getUserId();        
        return (SObject) byPassProcess;
    }
}