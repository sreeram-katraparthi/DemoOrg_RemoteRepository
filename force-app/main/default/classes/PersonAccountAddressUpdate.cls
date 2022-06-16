/*To align with the existing application code, we need to insert details in the update_request__c object.
 * Based on the approval status and record type, the address will be updated in the additional_address__c object.
 * POC purpose, this code will insert new address in the additional_address__c object.
*/
@RestResource(urlMapping='/UserAddressUpdate/*')
global with sharing class PersonAccountAddressUpdate {

@HttpPost	    
    global static string personAccAddressUpdate() {        
      String jsonString = RestContext.request.requestBody.toString();
      System.debug('** jsonString **'+jsonString);
      JsonParserForAddressUpdateRequest addDetails = (JsonParserForAddressUpdateRequest)JSON.deserialize(jsonstring, JsonParserForAddressUpdateRequest.class);
      //JsonParserForAddressUpdateRequest userr = new JsonParserForAddressUpdateRequest(); 
      Additional_Address__c aa = new Additional_Address__c(); 
      aa.Name = addDetails.name;
      aa.AccountName__c = addDetails.userId;
      aa.Street__c = addDetails.street;
      aa.City__c = addDetails.city;
      aa.Country__c = addDetails.country;
      aa.State__c = addDetails.state;
      aa.Province_Code__c = addDetails.zipCode;
      insert aa;
      return aa.id;
    }  
    
}