@RestResource(urlMapping='/secureApexRest')
global with sharing class SecureApexRest {
    @HttpGet
    global static Contact doGet(){
        Id recordId = RestContext.request.params.get('id');
        system.debug('** recordId **'+recordId);
        Contact result;
        List<Contact> results;
        if (recordId == null){
            throw new FunctionalException('Id parameter is required');
        }
        try{
            results = [SELECT id, Name, Secret_Key__c FROM Contact WHERE Id = :recordId WITH SECURITY_ENFORCED];
            system.debug('** results **'+results);
        }
        catch(QueryException e){
        }
        if (!results.isEmpty()) {
            result = results[0];
        }
        return result;
    }
    public class FunctionalException extends Exception{}
    public class SecurityException extends Exception{}
}