public with sharing class DogAPIController {
    @AuraEnabled(cacheable=true)
    public static String fetchRandomDog() {
        system.debug('** in fetchRandomDog Method **');
        Http http = new Http();
        HttpRequest request = new HttpRequest();
         
        // Provide the Named Credentials
        request.setEndpoint('callout:Dog_API');
        request.setMethod('GET');        
        HttpResponse response = http.send(request);        
        system.debug('** response status code **'+response.getStatusCode());
        if (response.getStatusCode() == 200) {
            return response.getBody();
        }
        return null;
    }
}