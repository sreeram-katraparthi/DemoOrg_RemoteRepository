/*
*      @author         Sreeram K
*      @date           02/21/2018
*      @description    This wrapper class is used to display country and respective packages.

*      Modification Log:
*      ------------------------------------------------------------------------------------
*      Developer                       Date                Description
*      ------------------------------------------------------------------------------------
*      Sreeram K               		02/21/2018          Original Version   

*/
public class SWID_CountryPackagesWrapper {
    // @AuraEnabled public List<Package__c> packageRcd { get; set; }
    
    @AuraEnabled public boolean isSelected{get;set;}
    @AuraEnabled public string Packages{get;set;}
    @AuraEnabled public string Description{get;set;}
    @AuraEnabled public string packageId{get;set;}
    @AuraEnabled public string releaseState{get;set;}
    @AuraEnabled public string releaseStatus{get;set;}
    @AuraEnabled public Datetime ArrivedDate{get;set;}
    @AuraEnabled public Datetime ReleasedOn{get;set;}
    @AuraEnabled public Datetime IgnoredOn{get;set;}
    @AuraEnabled public Datetime DeletedOn{get;set;}
    @AuraEnabled public Datetime PublisheddOn{get;set;}
    @AuraEnabled public string prid{get;set;}
    @AuraEnabled public id packid{get;set;}
    @AuraEnabled public boolean skipLocRel{get;set;}
    @AuraEnabled public string UILang{get;set;}
    @AuraEnabled public string sysCls{get;set;}
    @AuraEnabled public string country{get;set;}
    @AuraEnabled public string targetEnv{get;set;}
    @AuraEnabled public string config{get;set;}
    @AuraEnabled public string DescriptionUntrim{get;set;}
    @AuraEnabled public datetime publishedOn{get;set;}    
    @AuraEnabled public String releasedBy{get;set;}
    @AuraEnabled public String deletedBy{get;set;}
    @AuraEnabled public String ignoredBy{get;set;}
    @AuraEnabled public Integer testDistribution{get;set;}
    @AuraEnabled public string RUDIs{get;set;}
    
    /*
    Method Name:SWID_CountryPackagesWrapper
    Description: Constructor of the class
    */
    
    public SWID_CountryPackagesWrapper(){
        
        isSelected = false; 
        Packages = '';
        Description = '';
        releaseState = '';
        skipLocRel=false;
        
        
    }
    
}