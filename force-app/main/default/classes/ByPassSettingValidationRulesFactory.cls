public class ByPassSettingValidationRulesFactory extends SObjectFactory{
    
    Private Boolean byPassAll;
    
    public ByPassSettingValidationRulesFactory(Boolean byPassAll) {
        this.byPassAll = byPassAll;
        sObjectType = ByPassSettingValidationRules__c.sObjectType;
    }   
    
    public ByPassSettingValidationRulesFactory() {
        this(false);
    }
    
    public SObject buildRecordWithData() {
        
        ByPassSettingValidationRules__c byPassValidation = new ByPassSettingValidationRules__c( Name = 'Test');
        return setRecordData(byPassValidation);
    }
    
    Public SObject setRecordData(ByPassSettingValidationRules__c byPassValidation) {
        
        if (byPassAll)
            SObjectHelper.setAllBooleanFields('ByPassSettingValidationRules__c', (sObject) byPassValidation, true);
        
        byPassValidation.SetupOwnerId=UserInfo.getUserId();
        return (SObject) byPassValidation;
    }
}