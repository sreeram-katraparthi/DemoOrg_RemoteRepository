@RestResource(urlMapping='/UserAuth/*')
global with sharing class UserAuthentication {

@HttpPost   
  global static boolean checkUser(String UserName) {
     System.debug('** UserName ** '+UserName); 
     List<Account> users = new List<Account>();    
     //users = [Select Name from Account where Name = :UserName];
     if(users.size() == 0 ) {
        return false;
     }
        return true;
  }
}