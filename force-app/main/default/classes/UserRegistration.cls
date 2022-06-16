/*https://salesforce.stackexchange.com/questions/9328/how-to-parse-the-json-object-in-salesforce*/

@RestResource(urlMapping='/UserReg/*')
global with sharing class UserRegistration {

@HttpPost       
    global static string regUser() {        
      String jsonString = RestContext.request.requestBody.toString();
      System.debug('** jsonString **'+jsonString);
      UserRegJSonParser accDetails = (UserRegJSonParser)JSON.deserialize(jsonstring, UserRegJSonParser.class); 
      UserRegJSonParser userr = new UserRegJSonParser(); 
      Account a = new Account(); 
      a.Name = accDetails.FirstName + accDetails.LastName;
      a.Email__c = accDetails.Email;
      a.BillingStreet = accDetails.address.StreetNumber + accDetails.address.StreetName + accDetails.address.Line1;
      insert a;
      return a.id;
    }  
    
}