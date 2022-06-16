@isTest
private class SWID_CountryPicklistControlleTest{
    @isTest
    static void TestCountryPicklist(){
        
        SWID_CountryPackagesWrapper packages = new SWID_CountryPackagesWrapper(); 
        
        SWID_Package__c pack = new SWID_Package__c();
        pack.name = 'test pack';
        pack.Published_On__c = date.today();
        pack.Package_Description__c = 'test descriptio';
        insert pack;        
        
		SWID_PackageRelease__c country = new SWID_PackageRelease__c();        
        country.name = 'test country';
        country.Routing_Country__c = 'Germany';
        country.Arrived_On__c = date.today();
        country.Ignored_On__c = date.today();
        country.Released_On__c = date.today();
        country.Deleted_On__c = date.today();
        country.SWID_Package__c = pack.id;
        country.Release_State__c = 'Ready';
        country.Release_Status__c = 'Pending';
        insert country;
        
        List<String> result=SWID_CountryPicklistController.getCountries(country, 'Routing_Country__c');
        List<SWID_CountryPackagesWrapper> results=SWID_CountryPicklistController.getCountryPackages('Germany');
        System.assertEquals(null, result);
    }
}