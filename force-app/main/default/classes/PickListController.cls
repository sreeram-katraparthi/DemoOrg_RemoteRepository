public class PickListController {
 /*@AuraEnabled
 public static List < String > getselectOptions(sObject objObject, string fld) {
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
  system.debug('allOpts ---->' + allOpts);
  allOpts.sort();
  return allOpts;
 }
 @AuraEnabled
    public static List<SWID_CountryPackagesWrapper> getCountryPackages(){
        List<SWID_CountryPackagesWrapper> countryPackages = new List<SWID_CountryPackagesWrapper>();
        List<SWID_Country__c> countrypacks = [select id,name,Release_Status__c,Released_State__c,Routing_Country__c,SWID_Package__r.name,SWID_Package__r.Created_On__c from SWID_Country__c];
        for(SWID_Country__c c : countryPacks){
            SWID_CountryPackagesWrapper pack = new SWID_CountryPackagesWrapper();
            pack.CreatedOn = c.SWID_Package__r.Created_On__c;
            pack.packageName = c.SWID_Package__r.name;
            pack.status = c.Release_Status__c;
            pack.state = c.Released_State__c;
            pack.country = c.Routing_Country__c;
            countryPackages.add(pack);
        }
        return countryPackages;
    }*/   
}