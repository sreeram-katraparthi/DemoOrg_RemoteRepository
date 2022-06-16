public without sharing class CI_OpportunityListViewController {
    /*static map<string,string> RT_LABEL_MAP;
    public CI_OpportunityListViewController() {

    }*/
    @AuraEnabled(cacheable=true)
    public static List<ListViewWrapper> getOpportunities(id accountid, boolean isGlobalView, string dateFilter){
        List<ListViewWrapper> dataWrapper = new List<ListViewWrapper>();
        /*set<id> ids= new set<id>();
        if(isGlobalView){
            //collect all the child account ids for the global account
        }
        ids.add(Accountid);
        Map<id,Opportunity> records = getOpportunities(ids);
        List<OpportunityStage> lstclosedopptyStages=[SELECT Id, ApiName FROM OpportunityStage WHERE IsClosed = true];
        Map<string,OpportunityStage> oppstageclosemap=new Map<string,OpportunityStage>();
        for(OpportunityStage oppstage:lstclosedopptyStages)
        {
            oppstageclosemap.put(oppstage.ApiName,oppstage);
        }
        for(Opportunity opp: records.values()){
            dataWrapper.add(new ListViewWrapper(opp,oppstageclosemap) );
        }*/
        return dataWrapper;
    }
        /*public static Map<id,Opportunity> getOpportunities(set<id> accountIds){

            return new Map<id,Opportunity>(
            [SELECT Id, Owner_Market__c,RecordTypeId,RecordType.DeveloperName,Service__c,
            Scope__c,Phase__c,OwnerId,CBRE_Preferred_Property_Type_c__c,CloseDate,
            Target_Property_Property_Type_frm__c,Product_Type__c,Opportunity_No__c,
            Asset_Type__c,Proposed_Land_Use__c,Owner.SmallPhotoUrl,owner.FirstName,
            UserRecordAccess.HasReadAccess,stagename,
            owner.LastName FROM Opportunity 
            WHERE Accountid IN : accountIds AND CloseDate >= LAST_N_YEARS:2 AND Confidential_Opportunity__c = false 
            ORDER BY CloseDate desc]);
            
        }
    public static Date getDateFilter(string filter){
        //todo: use this function to return closedate filter
        //example : CloseDate >= LAST_N_YEARS:2 returns all the oops creted after 2018 Jan 1.
        return null;
    }
    public static string getMarketValue(Opportunity opp){
        return opp.Owner_Market__c;
    }
    public static string getBusinessLineValue(Opportunity opp){
        if(null == RT_LABEL_MAP ){
            populate_RT_LABEL();
        }
        if(RT_LABEL_MAP.containsKey(opp.RecordType.DeveloperName)){
            return RT_LABEL_MAP.get(opp.RecordType.DeveloperName);
        }
        
        return 'Other';
    }
    private static void populate_RT_LABEL(){
        RT_LABEL_MAP = new Map<string,string>();
        for(Record_Type_Business_Line_Mapping__mdt mapping: [SELECT DeveloperName,Business_Line_Label__c
        FROM Record_Type_Business_Line_Mapping__mdt]){
            RT_LABEL_MAP.put(mapping.DeveloperName,mapping.Business_Line_Label__c);
        }
     }
    public static string getAssignmentTypeValue(opportunity opp){
        if(opp.RecordType.DeveloperName == 'APAC_Property_Management'){
            return opp.Scope__c;
        }
        return opp.Service__c;
    }
    public static string getPropertyValue(opportunity opp){
        string propertyValue='';
        switch on opp.RecordType.DeveloperName {
            when 'APAC_Global_Workplace_Solutions','APAC_Debt_Structured_Finance','APAC_Valuations_Consulting_Services'{//APAC Advisory/Consulting Services
                if(String.isNotBlank(opp.Target_Property_Property_Type_frm__c)){
                    propertyValue = opp.Target_Property_Property_Type_frm__c;
                }
                propertyValue = opp.CBRE_Preferred_Property_Type_c__c;
            }
            when 'APAC_AS_EFM','APAC_Investors_Buyers','APAC_A_T_Investor_Leasing',
            'APAC_Landlord_Deal','APAC_Landlord_Listing','APAC Property Management'{
                //APAC AS/EFM,APAC Investors/Buyers,APAC Landlord and Sale Pursuits,APAC Landlord Deal,APAC Landlord Listing
                propertyValue = opp.Target_Property_Property_Type_frm__c;
            }
            when 'APAC_Occupier','APAC_Property_Purchase_Buy_Side'{//APAC Occupier,/APAC Property Sales - Buy Side
                propertyValue = opp.CBRE_Preferred_Property_Type_c__c;
            }
            when 'APAC_Project_Management'{//APAC Project Management
                propertyValue = opp.Asset_Type__c;
            }
            when 'APAC_Property_Sales'{//APAC Property Sales - Sell Side
                if(String.isNotBlank(opp.Target_Property_Property_Type_frm__c)){
                    propertyValue = opp.Target_Property_Property_Type_frm__c;
                }
                propertyValue = opp.Proposed_Land_Use__c;
            }
            when 'Asset_Services'{//Asset Services
                propertyValue = opp.Product_Type__c;
            }
        }

        return propertyValue;
    }
    public static string getPhaseValue(opportunity opp){
        return opp.Phase__c;
    }
    public static map<string,string> getOwnerValue(opportunity opp,Map<string,OpportunityStage> oppstageclosemap){
        map<string,string> userDetails= new map<string,string>();
        boolean isclosed=false;
        userDetails.put('id',opp.ownerId);
        userDetails.put('Name',opp.owner.FirstName+', '+opp.Owner.LastName);
        userDetails.put('SmallPhotoUrl',opp.owner.SmallPhotoUrl);
        userDetails.put('HasReadAccess',string.valueof(opp.UserRecordAccess.HasReadAccess));
        OpportunityStage oppstagetype=oppstageclosemap.get(opp.stagename);
        if(oppstagetype!=null)
        {
            userDetails.put('isClosed','true');
        }
        else 
        {
            userDetails.put('isClosed','false');
        }
        return userDetails;
    }
    public static map<string,string> getOppoNumber(opportunity opp){
        map<string,string> oppDetails= new map<string,string>();
        oppDetails.put('id',opp.Id);
        oppDetails.put('oppNumber',opp.Opportunity_No__c);
        oppDetails.put('HasReadAccess',string.valueof(opp.UserRecordAccess.HasReadAccess));
        return oppDetails;
    }
    public static Date getCloseDate(opportunity opp){
        return opp.closeDate;
    }*/

   
    public class ListViewWrapper{
        @AuraEnabled
        public string market;
        @AuraEnabled
        public string businessline;
        @AuraEnabled
        public string assignmentType;
        @AuraEnabled
        public string property;
        @AuraEnabled
        public string phase;
        @AuraEnabled
        public map<string,string> oppNumber;
        @AuraEnabled
        public date closeDate;
        @AuraEnabled
        public map<string,string> ownerDetails;
        /*public ListViewWrapper(opportunity opp,Map<string,OpportunityStage> oppstageclosemap){
            this.market=getMarketValue(opp);
            this.businessline=getBusinessLineValue(opp);
            this.assignmentType=getAssignmentTypeValue(opp);
            this.property=getPropertyValue(opp);
            this.phase=getPhaseValue(opp);
            this.closeDate=getCloseDate(opp);
            this.oppNumber=getOppoNumber(opp);
            this.ownerDetails=getOwnerValue(opp,oppstageclosemap);
        }*/
    }
    
   
}