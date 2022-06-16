/*
*      @author         Sreeram K
*      @date           02/21/2018
*      @description    This Class is used to show pick list values and respective packages for the country in SWID_Package component functionality.

*      @date           03/05/2018
*	   @description    Added fields in query	
Modification Log:
*      ------------------------------------------------------------------------------------
*      Developer                       Date                Description
*      ------------------------------------------------------------------------------------
*      Sreeram K               		02/21/2018          Original Version   

*/
public class SWID_CountryPicklistController {
    /*
Method Name:    getCountries
Description:    This method helps in getting pick list values of the countries
*/
    @AuraEnabled
    public static List<String> getCountries(sObject objObject, string fld) {
        system.debug('objObject --->' + objObject);
        system.debug('fld --->' + fld); 
        List < String > allOpts = new list < String > ();
        
        // Get the object type of the SObject.
        Schema.sObjectType objType = objObject.getSObjectType();
        
        // Describe the SObject using its object type.
        Schema.DescribeSObjectResult objDescribe = objType.getDescribe();
        
        // Get a map of fields for the SObject
        map < String, Schema.SObjectField > fieldMap = objDescribe.fields.getMap();
        
        // Get the list of picklist values for this field.
        list < Schema.PicklistEntry > values =
            fieldMap.get(fld).getDescribe().getPickListValues();
        
        // Add these values to the selectoption list.
        for (Schema.PicklistEntry a: values) {
            allOpts.add(a.getValue());
        }
        allOpts.sort();
        
        return allOpts;
    }
    
    /*
Method Name:    getCountryPackages
Description:    This method helps in getting List of Package details from the SWID_PackageRelase__c object.
*/
    @AuraEnabled
    public static List<SWID_CountryPackagesWrapper> getCountryPackages(string strCountry){
        System.debug('@@@ value of country'+strCountry);
        List<SWID_CountryPackagesWrapper> countryPackages = new List<SWID_CountryPackagesWrapper>();
        
        List<SWID_PackageRelease__c> countrypacks = [select id,name,Release_State__c,Release_Status__c,Routing_Country__c,
                                                     Arrived_On__c,Released_On__c,Deleted_On__c,Ignored_On__c,
                                                     SWID_Package__c,SWID_Package__r.published_On__c,IsSkipLocalRelease__c,
                                                     SWID_Package__r.name,SWID_Package__r.Package_Description__c,
                                                     SWID_Package__r.System_Class__c,SWID_Package__r.UI_Language__c,Test_Distribution__c,
                                                     SWID_Package__r.Target_Environment__c,Ignored_By__c,Deleted_By__c,Released_By__c
                                                     from SWID_PackageRelease__c
                                                     where Routing_Country__c =: strCountry order by Arrived_On__c desc];
        for(SWID_PackageRelease__c c : countryPacks){
            SWID_CountryPackagesWrapper pack = new SWID_CountryPackagesWrapper();
            pack.prid = c.id;
            pack.publishedOn = c.SWID_Package__r.published_On__c;
            pack.Packages = c.SWID_Package__r.name;            
            pack.releaseStatus = c.Release_Status__c; // child values
            pack.releaseState = c.Release_State__c; // 4 values
            pack.country = c.Routing_Country__c;
            pack.ReleasedOn = c.Released_On__c;
            pack.IgnoredOn = c.Ignored_On__c;
            pack.DeletedOn = c.Deleted_On__c;            
            pack.ArrivedDate = c.Arrived_On__c;
            pack.skipLocRel = c.IsSkipLocalRelease__c;                
            pack.sysCls = c.SWID_Package__r.System_Class__c;
            pack.UILang = c.SWID_Package__r.UI_Language__c;
            pack.packageId = c.SWID_Package__r.id;
            pack.targetEnv = c.SWID_Package__r.Target_Environment__c;
            pack.releasedBy = c.Released_By__c;
            pack.deletedBy = c.Deleted_By__c;
            pack.ignoredBy = c.Ignored_By__c;
            pack.testDistribution = Integer.valueOf(c.Test_Distribution__c);
            if(String.isNotBlank(c.SWID_Package__r.Package_Description__c)){
                String strDec = c.SWID_Package__r.Package_Description__c;
                if(strDec.length()>50){
                    String newStrDec = strDec.subString(0,50);
                    pack.description = newStrDec+'...';                    
                }else{
                    pack.description = c.SWID_Package__r.Package_Description__c;
                }
                
            }
            pack.DescriptionUntrim = c.SWID_Package__r.Package_Description__c;
            countryPackages.add(pack);
        }
        //System.debug('in country packs'+countryPackages.size());
        
        return countryPackages;
    }
    @AuraEnabled
    public static boolean changeStatus(string recId,string stat){
        system.debug('** stat **'+stat+'** recId **'+recId);
        SWID_PackageRelease__c statusToUpdate = [select Release_State__c,Release_Status__c,Released_By__c,Released_On__c
                                                 from SWID_PackageRelease__c where id =: recId limit 1];
        if(stat == 'TEST' || stat == 'PENDING'){
            statusToUpdate.Release_State__c = 'IN DISTRIBUTION';
            statusToUpdate.Release_Status__c = 'IN DISTRIBUTION';
            statusToUpdate.Released_By__c = UserInfo.getName();
            statusToUpdate.Released_On__c = system.TODAY();
        }
        System.debug('** statusToUpdate **'+statusToUpdate);
        update statusToUpdate; 
        return true;
        
    }
    
    @AuraEnabled
    public static boolean changeStatusOfPackage(List<Id> lstOfrecId,Boolean onlyIgnCheck){
        List<SWID_PackageRelease__c> lstOfPackRel = new List<SWID_PackageRelease__c>();
        List<SWID_PackageRelease__c> lstToUpdaPackRel = new List<SWID_PackageRelease__c>();       
       
        String usrName = UserInfo.getName();
        system.debug('@@@ lstOfrecId.size:::'+lstOfrecId.size());
        system.debug('@@@ lstOfrecId.size:::'+lstOfrecId);
        system.debug('@@@ onlyIgnCheck:::'+onlyIgnCheck);
        if(lstOfrecId != null){
            lstOfPackRel = [select Release_State__c,Release_Status__c,Released_On__c,Released_By__c,
                            Deleted_By__c,Deleted_On__c,Ignored_By__c,Ignored_On__c
                            from SWID_PackageRelease__c
								where id =: lstOfrecId limit 5000];
            if(lstOfPackRel != null && lstOfPackRel.size()>0){
				for(SWID_PackageRelease__c obj :lstOfPackRel){
					if(onlyIgnCheck == true && obj.Release_Status__c == 'PENDING'){
						obj.Release_State__c = 'IGNORED';
						obj.Release_Status__c = 'IGNORED';                        
                        obj.Ignored_By__c = usrName;
                        obj.Ignored_On__c = system.today();
					}else if((obj.Release_Status__c == 'PENDING' || obj.Release_Status__c == 'TEST') && onlyIgnCheck == false){
						obj.Release_State__c = 'IN DISTRIBUTION';
						obj.Release_Status__c = 'IN DISTRIBUTION';
                        obj.Released_By__c = usrName;
                        obj.Released_On__c = system.today();
					}else if(obj.Release_Status__c == 'IN DISTRIBUTION'){
						obj.Release_State__c = 'DELETED';
						obj.Release_Status__c = 'DELETED';
                        obj.Deleted_By__c = usrName;
                        obj.Deleted_On__c = system.today();
					}else if(obj.Release_Status__c == 'DELETED'){
						obj.Release_State__c = 'IN DISTRIBUTION';
						obj.Release_Status__c = 'IN DISTRIBUTION';                     
                        obj.Released_By__c = usrName;
                        obj.Released_On__c = system.today();
					}else if(obj.Release_Status__c == 'IGNORED'){
						obj.Release_State__c = 'READY';
						obj.Release_Status__c = 'PENDING';
					}
					lstToUpdaPackRel.add(obj);
				}
				if(lstToUpdaPackRel != null && lstToUpdaPackRel.size()>0){
					update lstToUpdaPackRel;
				}
				return true;
            }else{
				return false;
			}
			
        }else{
            return false;
        }    
    }
    
    @AuraEnabled
    public static List < sObject > fetchLookUpValues() {//String searchKeyWord, String ObjectName
        //system.debug('ObjectName-->' + ObjectName);
        //String searchKey = searchKeyWord + '%';
        system.debug('** in lookup search method **');
        List < sObject > returnList = new List < sObject > ();
      
        // Create a Dynamic SOQL Query For Fetch Record List with LIMIT 5   
        //String sQuery =  'select id, Name from ' +ObjectName + ' where Name LIKE: searchKey order by createdDate DESC limit 5';
        String sQuery = 'select id, Country__c, RUDI__c from Order__c limit 10';
        List < sObject > lstOfRecords = Database.query(sQuery);
        
        for (sObject obj: lstOfRecords) {
            returnList.add(obj);
        }
        System.debug('** searched list **'+returnList);
        return returnList;
    }
    
}