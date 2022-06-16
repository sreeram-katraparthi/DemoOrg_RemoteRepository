@RestResource(urlMapping='/UserDet/*')
global with sharing class UserDetails {

@HttpPost	
    global static Account userDet(String uId) {
     System.debug('** UserName ** '+uId);
     Account acc = [select Name, DOB__c,Gender__c,Email__c,Phone from Account where id =: uId limit 1];        
        return acc;
    }  		
}