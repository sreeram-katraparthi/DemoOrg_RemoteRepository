/*
@RestResource(urlMapping = '/accountDetails/*')
global class AccDetailsForDecryption {
    @HttpPost           
    global static JSONResponseSerialization  accDetails() {          
        JSONResponseSerialization jsonRresponse;
        try{
            List<String> TokenList=new List<String>(); //To store the list of tokens.
            List<String> SubscribersList = new List<String>();
            List<String> acctIds = new List<String>();
            String jsonString = RestContext.request.requestBody.toString(); //To convert the rest request into string.
            //Parser for the json string.
            TokensParser accIds = (TokensParser)JSON.deserialize(jsonString, TokensParser.class);
            jsonRresponse = new JSONResponseSerialization();          
            jsonRresponse.unresolvedTokens = new List<JSONResponseSerialization.cls_unresolvedTokens>();
            jsonRresponse.resolvedTokens = new List<JSONResponseSerialization.cls_resolvedTokens>();
            
            Map<Id,TokensParser.Tokens> SubscriberTockenMap = new Map<Id,TokensParser.Tokens>(); 
            List<string> resolvetokenIdList = new List<String>();
            for (integer i=0;i<accIds.Tokens.size();i++){               
                Boolean isId = true;
                Id anId;
                String myIdPrefix;
                String prefix;
                if(accIds.Tokens[i].subscriberKey != null){                    
                    try {
                        anId = accIds.Tokens[i].subscriberKey; 
                        myIdPrefix = String.valueOf(anId).substring(0,3);
                        Schema.DescribeSObjectResult r = Schema.Contact.sObjectType.getDescribe();
                        prefix = r.getKeyPrefix();
                    }                     
                    catch (StringException e) {
                        isId = false;
                    }                   
                    if(isId && myIdPrefix == prefix){
                        //tokenRequestIdList.add(accIds.Tokens[i].tokenRequestId);
                        SubscribersList.add(accIds.Tokens[i].subscriberKey);
                        //TokenList.add(accIds.Tokens[i].token);
                        SubscriberTockenMap.put(accIds.Tokens[i].subscriberKey,accIds.Tokens[i]);
                    }
                    else{
                        JSONResponseSerialization.cls_unresolvedTokens unres = new JSONResponseSerialization.cls_unresolvedTokens();
                        unres.tokenRequestId = accIds.Tokens[i].tokenRequestId;
                        unres.message = 'Invalid token; token does not exist.';
                        jsonRresponse.unresolvedTokens.add(unres);
                    }
                }
            }
            list<Schema.FieldSetMember> accfields = SObjectType.Account.FieldSets.SFMCFields.getFields();
            String query = 'SELECT ';
            
            String addquery = '(SELECT ';
            list<Schema.FieldSetMember> addfields;            
            
            String casquery = '(SELECT ';
            list<Schema.FieldSetMember> casfields;            
            
            String ordquery = '(SELECT ';
            list<Schema.FieldSetMember> ordfields;
            
            String PAAddAttquery = '(SELECT ';
            list<Schema.FieldSetMember> PAAddAttFields;
            
            for(Schema.FieldSetMember f : accfields) {
                query += f.getFieldPath() + ', '; 
            }
            
            for(account aId : [select id from account where personcontactid =: SubscribersList]){
                acctIds.add(aId.id);
            }
            System.debug('** acctIds **'+acctIds);
            
            if(SObjectType.Additional_Address__c.FieldSets.AddAddressSFMCFields.getFields().size() > 0 
                || SObjectType.case.FieldSets.caseSFMCFields.getFields().size() > 0
                || SObjectType.order.FieldSets.OrderSFMCFields.getFields().size() > 0 
                || SObjectType.PersonAccountAdditionalAttributes__c.FieldSets.PAAddAttSFMCFields.getFields().size() > 0){
        
                addfields = SObjectType.Additional_Address__c.FieldSets.AddAddressSFMCFields.getFields();
                casfields = SObjectType.case.FieldSets.caseSFMCFields.getFields(); 
                ordfields = SObjectType.order.FieldSets.OrderSFMCFields.getFields(); 
                PAAddAttFields = SObjectType.PersonAccountAdditionalAttributes__c.FieldSets.PAAddAttSFMCFields.getFields(); 
         
                if(SObjectType.Additional_Address__c.FieldSets.AddAddressSFMCFields.getFields().size() > 0){
                    for(Schema.FieldSetMember f : addfields) {
                        addquery += f.getFieldPath() + ', ';
                    }
                    addquery += ' Id from Additional_Addresses__r),';
                }else{
                    addquery = '';
                }
                    
                if(SObjectType.case.FieldSets.caseSFMCFields.getFields().size() > 0){
                    for(Schema.FieldSetMember f : casfields) {
                        casquery += f.getFieldPath() + ', ';
                    }
                    casquery += ' Id from cases),';
                }else{
                    //casquery += '';                    
                    casquery = '';
                }
                if(SObjectType.order.FieldSets.OrderSFMCFields.getFields().size() > 0){
                    for(Schema.FieldSetMember f : ordfields) {
                        ordquery += f.getFieldPath() + ', ';
                    }
                    ordquery += ' Id from orders),';                
                }else{
                    ordquery = '';
                }
                if(SObjectType.PersonAccountAdditionalAttributes__c.FieldSets.PAAddAttSFMCFields.getFields().size() > 0){
                    for(Schema.FieldSetMember f : PAAddAttFields) {
                        PAAddAttquery += f.getFieldPath() + ', ';
                    }
                    PAAddAttquery += ' Id from Person_Account_Flexible_Attributes__r),';                
                }else{
                    PAAddAttquery = '';
                }
                query += 'Id,Name,' + addquery + casquery + ordquery +  PAAddAttquery +  'personcontactId,BillingAddress from Account where Id =: acctIds';
            }
            else{
                query += 'Id,Name,personcontactId,BillingAddress from Account where Id =: acctIds';
            } 
            System.debug('** query **'+query);
            List<account> actsList = Database.query(query);
            
            for(Account acc : actsList){
                System.debug('** acc **'+acc);
                JSONResponseSerialization.cls_resolvedTokens josnnn = new JSONResponseSerialization.cls_resolvedTokens(); 
                josnnn.tokenRequestId = SubscriberTockenMap.get(acc.personcontactId).tokenRequestId;
                //josnnn.token = SubscriberTockenMap.get(acc.ID).token;
                josnnn.tokenValue = acc.Personemail;
                josnnn.attributes = new List<JSONResponseSerialization.cls_attributes>();
                for(integer f=0;f<accfields.size();f++){
                    JSONResponseSerialization.cls_attributes att = new JSONResponseSerialization.cls_attributes();
                    att.name = accfields[f].getlabel();
                    att.value = String.valueof(acc.get(accfields[f].getFieldPath()));
                    josnnn.attributes.add(att);
                }
                if(acc.Additional_Addresses__r != null && acc.Additional_Addresses__r.size() > 0){
                    for(Additional_Address__c address : acc.Additional_Addresses__r){
                        System.debug('** address **'+address);
                        for(integer j=0;j<addfields.size();j++){
                            JSONResponseSerialization.cls_attributes addresses = new JSONResponseSerialization.cls_attributes();
                            addresses.name = addfields[j].getlabel();
                            addresses.value = String.valueof(address.get(addfields[j].getFieldPath()));
                            josnnn.attributes.add(addresses);
                        }
                    }
                }
                if(acc.cases != null && acc.cases.size() > 0){
                    for(case cas : acc.cases){
                        System.debug('** cas **'+cas);
                        for(integer k=0;k<casfields.size();k++){
                            JSONResponseSerialization.cls_attributes cases = new JSONResponseSerialization.cls_attributes();
                            cases.name = casfields[k].getlabel();
                            cases.value = String.valueof(cas.get(casfields[k].getFieldPath()));
                            josnnn.attributes.add(cases);
                        }
                    }
                }
                if(acc.orders != null && acc.orders.size() > 0){
                    for(order ord : acc.orders){
                        System.debug('** ord **'+ord);
                        for(integer l=0;l<ordfields.size();l++){
                            JSONResponseSerialization.cls_attributes orders = new JSONResponseSerialization.cls_attributes();
                            orders.name = ordfields[l].getlabel();
                            orders.value = String.valueof(ord.get(ordfields[l].getFieldPath()));
                            josnnn.attributes.add(orders);
                        }
                    }
                }
                if(acc.Person_Account_Flexible_Attributes__r != null && acc.Person_Account_Flexible_Attributes__r.size() > 0){
                    system.debug('** acc.Person_Account_Flexible_Attributes__r.size() ** '+acc.Person_Account_Flexible_Attributes__r.size());
                    for(PersonAccountAdditionalAttributes__c paa : acc.Person_Account_Flexible_Attributes__r){
                        System.debug('** paa **'+paa);
                        for(integer m=0;m<PAAddAttFields.size();m++){
                            JSONResponseSerialization.cls_attributes paas = new JSONResponseSerialization.cls_attributes();
                            paas.name = PAAddAttFields[m].getlabel();
                            paas.value = String.valueof(paa.get(PAAddAttFields[m].getFieldPath()));
                            josnnn.attributes.add(paas);
                        }
                    }
                }
                jsonRresponse.resolvedTokens.add(josnnn);   
            }            
        }
        catch(exception e){
            System.debug('**exception **'+e);
        }                    
        return jsonRresponse;        
    }
}
======================================================================================================================================================

@RestResource(urlMapping = '/getTokenAPI/*')
global class SFMCMobileGetTokensAPI {
    @HttpPost
    global static MobileGetTokenAPIJSONResponse MobGetTokens() {
        MobileGetTokenAPIJSONResponse jsonRresponse;
        try{
            List<String> TokenList=new List<String>(); //To store the list of tokens.
            List<String> SubscribersList = new List<String>();            
            List<string> mobnoslist = new List<string>();
            Map<string,MobileTokensGetTokenAPIParser.Tokens> tokenrequestidmap = new map<string,MobileTokensGetTokenAPIParser.Tokens>();
            String jsonString = RestContext.request.requestBody.toString(); //To convert the rest request into string.
            //Parser for the json string.
            MobileTokensGetTokenAPIParser mobnos = (MobileTokensGetTokenAPIParser)JSON.deserialize(jsonString, MobileTokensGetTokenAPIParser.class);
            System.debug('** mobnos **'+mobnos);
            jsonRresponse = new MobileGetTokenAPIJSONResponse();
            jsonRresponse.tokens = new List<MobileGetTokenAPIJSONResponse.Tokens>();
            for(integer i=0;i<mobnos.tokenValues.size();i++){
                mobnoslist.add(mobnos.tokenValues[i].tokenValue);
                tokenrequestidmap.put(mobnos.tokenValues[i].tokenValue,mobnos.tokenValues[i]);
            }
            for(account acc : [select id,PersonMobilePhone from account where PersonMobilePhone =: mobnoslist]){
                System.debug('** acc **'+acc);
                MobileGetTokenAPIJSONResponse.Tokens josnnn = new MobileGetTokenAPIJSONResponse.Tokens();
                josnnn.tokenRequestId = tokenrequestidmap.get(acc.PersonMobilePhone).tokenRequestId;
                josnnn.token = acc.PersonMobilePhone;
                josnnn.subscriberKey = acc.id;
                jsonRresponse.tokens.add(josnnn);
            }
        }
        catch(Exception e){
            System.debug('** exception **'+e);
        }
        System.debug('** jsonRresponse **'+jsonRresponse);
        return jsonRresponse;
    }
}

===============================================================================================================================================================

@RestResource(urlMapping = '/MobileTokenResolver/*')
global class MobileTokenResolverAPI {
    @HttpPost           
    global static MobileTokensJSONSerialization  MobTokenResolver() {
        MobileTokensJSONSerialization jsonRresponse;
        try{            
            List<String> TokenList=new List<String>(); //To store the list of tokens.
            List<String> SubscribersList = new List<String>();
            String jsonString = RestContext.request.requestBody.toString(); //To convert the rest request into string.
            //Parser for the json string.
            TokensParser accIds = (TokensParser)JSON.deserialize(jsonString, TokensParser.class);            
            jsonRresponse = new MobileTokensJSONSerialization();          
            jsonRresponse.unresolvedTokens = new List<MobileTokensJSONSerialization.cls_unresolvedTokens>();
            jsonRresponse.resolvedTokens = new List<MobileTokensJSONSerialization.cls_resolvedTokens>();
            Map<Id,TokensParser.Tokens> SubscriberTockenMap = new Map<Id,TokensParser.Tokens>(); 
            List<string> resolvetokenIdList = new List<String>();
            for(integer i=0;i<accIds.Tokens.size();i++){               
                Boolean isId = true;
                Id anId;
                if(accIds.Tokens[i].subscriberKey != null){                    
                    try {
                        anId = accIds.Tokens[i].subscriberKey;
                    } catch (StringException e) {
                        isId = false;
                    }                   
                    if(isId){                    
                        //tokenRequestIdList.add(accIds.Tokens[i].tokenRequestId);
                        SubscribersList.add(accIds.Tokens[i].subscriberKey);                
                        //TokenList.add(accIds.Tokens[i].token);
                        SubscriberTockenMap.put(accIds.Tokens[i].subscriberKey,accIds.Tokens[i]);
                    }
                    else{
                        MobileTokensJSONSerialization.cls_unresolvedTokens unres = new MobileTokensJSONSerialization.cls_unresolvedTokens();
                        unres.tokenRequestId = accIds.Tokens[i].tokenRequestId;
                        unres.message = 'Invalid token; token does not exist.';
                        jsonRresponse.unresolvedTokens.add(unres);
                        System.debug('** jsonRresponse.unresolvedTokens **'+jsonRresponse);
                    }   
                }   
            }
            for(account acc : [select PersonMobilePhone from account where id =: SubscribersList]){
                MobileTokensJSONSerialization.cls_resolvedTokens josnnn = new MobileTokensJSONSerialization.cls_resolvedTokens();
                josnnn.tokenRequestId = SubscriberTockenMap.get(acc.ID).tokenRequestId;
                //josnnn.token = SubscriberTockenMap.get(acc.ID).token;
                josnnn.tokenValue = acc.PersonMobilePhone;
                jsonRresponse.resolvedTokens.add(josnnn); 
            }
        }catch(exception e){
            System.debug('**exception ** '+e);
        }
        System.debug('** jsonRresponse ** '+jsonRresponse);
        return jsonRresponse;
    }
}

=========================================================================================================================================================

/*@isTest 
private class Test_AccDetaislForDecryption{
    static testMethod void testAccountIds() {
        Account[] actArray= TestDataUtilityClass.createPersonAccounts(1);
        id accId = actArray[0].id;
        System.debug('** account id ** '+accId);
        
        //Contact[] conArray= TestDataUtilityClass.createContacts(1,accId);
        Contact[] conArray = [select id from contact where AccountId =: accId limit 1];
        id conId = conArray[0].id;
        System.debug('** contact id ** '+conId);
        
        Case[] casArray= TestDataUtilityClass.createCases(1,accId,conId);
        id casId = casArray[0].id;
        
        //Order[] ordArray = TestDataUtilityClass.createOrder(1,accId);
        //id ordId = ordArray[0].id;
        
        /*Account acc1 = new Account();
        acc1.name = 'Test Account 01';
        acc1.BillingCity = 'Bangalore';
        acc1.BillingCountry ='India';
        acc1.BillingPostalCode='545662';
        acc1.BillingStreet='Tk Road';*/
        
       /* String JSONMsg = '{'+
        '    \"tokens\": ['+
        '        {'+
        '            \"tokenRequestId\":\"abc123thn567\",'+
        '\"token\":\"012345678901234\",'+
        '            \"subscriberKey\":"'+accId+'"'+
        '        },'+
        '        {'+
        '            \"tokenRequestId\":\"abc098thn654\",'+
        '\"token\":\"012345678901235\",'+
        '            \"subscriberKey\":\"1111155555aAaAabBbBb\"'+
        '        }'+
        '    ],'+
        '    \"sendKey\": \"ExampleEmail_12345\"'+
        '}';

        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        
        req.requestURI = '/services/apexrest/accountDetails/*';  //Request URL
        req.httpMethod = 'POST';//HTTP Request Type
        req.requestBody = Blob.valueof(JSONMsg);
        
        RestContext.request = req;
        RestContext.response= res;
        
        Test.startTest();
            AccDetailsForDecryption.accDetails();
        Test.StopTest();   
    }
}

======================================================================================================================================================

/*
 {
  "tokenValues": [
    {
      "tokenRequestId": "abc123thn567",
      "tokenValue": "13172237777",
      "tokenType": "MobileNumber",
      "privateCode": "46356",
    },
    {
      "tokenRequestId": "abc098thn654",
      "tokenValue": "13175559911",
      "tokenType": "MobileNumber",
      "privateCode": "45356",
    }
  ]
}
 
 */

/*public class MobileTokensGetTokenAPIParser {
    public List<Tokens> tokenValues{get; set;}
    public class Tokens {
        public String tokenRequestId{get; set;}
        public String tokenValue{get; set;}
        public String tokenType{get; set;}
        public String privateCode{get; set;}
    } 
}


=========================================================================================================================================================

/*
 * {
    "resolvedTokens": [
        {
            "tokenRequestId":"abc123thn567",
            "tokenValue": "user1@exacttarget.com",
            "attributes": [
                {
                    "name": "FirstName",
                    "value": "Alice"
                },
                {
                    "name": "LastName",
                    "value": "Smith"
                }
            ]
        },
        {
            "tokenRequestId":"abc098thn654",
            "tokenValue ": "user2@gmail.com",
            "attributes": [
                {
                    "name": "FirstName",
                    "value": "John"
                },
                {
                    "name": "LastName",
                    "value": "Smith"
                }
            ]
        }
    ],
    "unresolvedTokens": [
        {
            "tokenRequestId":"abc098thn654",
            "message": "Invalid token; token does not exist." 
        }
    ]
}
 */
/*
global class JSONResponseSerialization{
    public List<cls_resolvedTokens> resolvedTokens {get;set;}   //cls_resolvedTokens[]
    public List<cls_unresolvedTokens> unresolvedTokens{get;set;}   //cls_unresolvedTokens[] 
    public class cls_resolvedTokens {
        //public String token{get;set;} //abc123thn567
        public String tokenRequestId{get;set;}
        public String tokenValue{get;set;}  //user1@exacttarget.com
        public List<cls_attributes> attributes{get;set;}    //cls_attributes[]
    }
    public class cls_attributes {
        public String name{get;set;}    //FirstName
        public String value{get;set;}   //Alice
        
    }    
    
    public class cls_unresolvedTokens {
        public String tokenRequestId{get;set;}
        public String message{get;set;}
    }
    public static JSONResponseSerialization parse(String json){
        return (JSONResponseSerialization) System.JSON.deserialize(json, JSONResponseSerialization.class);
    }
}



=============================================================================================================================================================

public class SFMCAuthentication {
    public void doGet(){
        String username= RestContext.request.params.get('username');
        String password= RestContext.request.params.get('password');      
        //String grant_type= RestContext.request.params.get('grant_type');
        HTTP h = new HTTP();
        HTTPRequest r = new HTTPRequest();
        string url = 'https://rochedc--prototyp13.cs86.my.salesforce.com/services/apexrest/globalapiservice';
        r.setEndpoint(url);
        Blob headerValue = Blob.valueOf(username + ':' + password);
        String authorizationHeader = 'BASIC ' + EncodingUtil.base64Encode(headerValue);
        r.setHeader('Authorization', authorizationHeader);
        r.setMethod('GET');
        HTTPResponse resp = h.send(r); 
        System.debug('** resp **'+resp);
    }    
}


====================================================================================================================================================================

/*
 * {
    "tokens": [
        {
            "tokenRequestId":"abc123thn567",
            "token":"t1234@example.com",
            "subscriberKey":"12345abcde67890fghij"
        },
        {
            "tokenRequestId":"abc098thn654",
            "token":"t5678@example.com",
            "subscriberKey":"1111155555aAaAabBbBb"
        }
    ],
    "sendKey": "ExampleEmail_12345"
}*/

 
/*
public class TokensParser { 
    public List<Tokens> tokens{get; set;}
    public String sendKey{get; set;}
    public class Tokens {
        public String tokenRequestId{get; set;}
        public String token{get; set;}
        public String subscriberKey{get; set;}
    }        
    public static TokensParser parse(String json) {
        return (TokensParser) System.JSON.deserialize(json, TokensParser.class);        
    }
}
==========================================================================================================================================================
*/


@RestResource(urlMapping = '/accountDetails/*')
global class AccDetailsForDecryption {
    @HttpPost           
    global static JSONResponseSerialization  accDetails() {          
        JSONResponseSerialization jsonRresponse;
        try{
            List<String> TokenList=new List<String>(); //To store the list of tokens.
            List<String> SubscribersList = new List<String>();
            List<String> invalidSubscriberList = new List<string>();
            List<String> tokenRequestIdList = new List<String>();
            List<String> invalidtokenRequestIdList = new List<String>();
            String jsonString = RestContext.request.requestBody.toString(); //To convert the rest request into string.
            //Parser for the json string.
            TokensParser accIds = (TokensParser)JSON.deserialize(jsonString, TokensParser.class);
            jsonRresponse = new JSONResponseSerialization();          
            jsonRresponse.unresolvedTokens = new List<JSONResponseSerialization.cls_unresolvedTokens>();
            jsonRresponse.resolvedTokens = new List<JSONResponseSerialization.cls_resolvedTokens>();
            
            Map<Id,TokensParser.Tokens> SubscriberTockenMap = new Map<Id,TokensParser.Tokens>(); 
            List<string> resolvetokenIdList = new List<String>();
            for (integer i=0;i<accIds.Tokens.size();i++){               
                Boolean isId = true;
                Id anId;
                if(accIds.Tokens[i].subscriberKey != null){                    
                    try {
                        anId = accIds.Tokens[i].subscriberKey;
                    } catch (StringException e) {
                        isId = false;
                    }                   
                    if(isId){                    
                        //tokenRequestIdList.add(accIds.Tokens[i].tokenRequestId);
                        SubscribersList.add(accIds.Tokens[i].subscriberKey);                
                        //TokenList.add(accIds.Tokens[i].token);
                        SubscriberTockenMap.put(accIds.Tokens[i].subscriberKey,accIds.Tokens[i]);
                    }
                    else{
                        JSONResponseSerialization.cls_unresolvedTokens unres = new JSONResponseSerialization.cls_unresolvedTokens();
                        unres.tokenRequestId = accIds.Tokens[i].tokenRequestId;
                        unres.message = 'Invalid token; token does not exist.';
                        jsonRresponse.unresolvedTokens.add(unres);
                        System.debug('** jsonRresponse.unresolvedTokens **'+jsonRresponse);
                    }
                }
            }
            list<Schema.FieldSetMember> fields = SObjectType.Account.FieldSets.SFMCFields.getFields();
            System.debug('** fields **'+fields);
            String query = 'SELECT ';
            for(Schema.FieldSetMember f : fields) {
                query += f.getFieldPath() + ', ';
            }
             
            string firstname= fields[0].getlabel();
            string lastname= fields[1].getlabel();
            query += 'Id,Email__c,BillingAddress from Account where id =: SubscribersList';
            List<account> actsList = Database.query(query);
            for( Account acc: actsList){
                JSONResponseSerialization.cls_resolvedTokens josnnn = new JSONResponseSerialization.cls_resolvedTokens();                
                josnnn.tokenRequestId = SubscriberTockenMap.get(acc.ID).tokenRequestId;
                //josnnn.token = SubscriberTockenMap.get(acc.ID).token;
                josnnn.tokenValue = acc.Email__c;  
                josnnn.attributes = new List<JSONResponseSerialization.cls_attributes>();
                JSONResponseSerialization.cls_attributes att1 = new JSONResponseSerialization.cls_attributes();
                att1.value=acc.Name;
                att1.Name=firstname;
                       
                JSONResponseSerialization.cls_attributes att2 = new JSONResponseSerialization.cls_attributes();
                att2.value=acc.Name;
                att2.Name=lastname;
                        
                josnnn.attributes.add(att1);
                josnnn.attributes.add(att2);
                jsonRresponse.resolvedTokens.add(josnnn);                                               
            }            
        }
        catch(exception e){
            System.debug('**exception **'+e);
        }                    
        return jsonRresponse;        
    }
    public void addFieldAttributes(){
        list<Schema.FieldSetMember> fields = SObjectType.Account.FieldSets.SFMCFields.getFields();
        //string firstname = fields[0].getlabel();
        //string lastname = fields[1].getlabel();
        map<string,string> accountfields = new Map<string,string>();
        for(integer i=0;i<fields.size();i++){
            accountfields.put(fields[i].getlabel(),fields[i].getlabel());
        }        
        System.debug('** accountfields **'+accountfields);
        
        String query = 'SELECT ';
            for(Schema.FieldSetMember f : fields) {
                query += f.getFieldPath() + ', ';
            }
             
            string firstname= fields[0].getlabel();
            string lastname= fields[1].getlabel();
            query += 'Id,Email__c,BillingAddress from Account where id =: SubscribersList';
            List<account> actsList = Database.query(query);
        for(account acc : actsList){
            JSONResponseSerialization.cls_resolvedTokens josnnn = new JSONResponseSerialization.cls_resolvedTokens();                
                //josnnn.tokenRequestId = SubscriberTockenMap.get(acc.ID).tokenRequestId;
                josnnn.tokenValue = acc.Email__c;  
                josnnn.attributes = new List<JSONResponseSerialization.cls_attributes>();
                JSONResponseSerialization.cls_attributes att1 = new JSONResponseSerialization.cls_attributes();
                att1.value=acc.Name;
                att1.Name=firstname;
                       
                JSONResponseSerialization.cls_attributes att2 = new JSONResponseSerialization.cls_attributes();
                att2.value=acc.Name;
                att2.Name=lastname;
            List<JSONResponseSerialization.cls_attributes> att = new List<JSONResponseSerialization.cls_attributes>();
            for(integer i=0;i<fields.size();i++){
                att[i].value = acc.Name;
                att[i].Name = fields[i].getlabel();
            }
                        
                josnnn.attributes.add(att1);
                josnnn.attributes.add(att2);
                //jsonRresponse.resolvedTokens.add(josnnn);              
            }
    }
}