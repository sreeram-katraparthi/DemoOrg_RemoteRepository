@RestResource(urlMapping='/globalapiservice')
global class GlobalAPI {
    @HttpGet
    global static string doGet(){
        return 'Hello';
    }
    
    @HttpPost
    global static void doPost() {
        
        String client_secret = RestContext.request.params.get('client_secret');
        String client_id = RestContext.request.params.get('client_id');
        String username =  EncodingUtil.urlDecode(RestContext.request.params.get('username'),'UTF-8');
        string pwd =  EncodingUtil.urlDecode(RestContext.request.params.get('password'),'UTF-8');
        
        system.debug('Params >>> ' + RestContext.request.params);
        
        String body = RestContext.request.requestBody.toString();
        
        String tokenBody = 'grant_type=password';
        tokenBody += '&client_id='+client_id;
        tokenBody += '&client_secret='+client_secret;
        tokenBody += '&username='+username;
        tokenBody += '&password='+pwd;
        
        System.debug('Token Body >>>> '+tokenBody);
        
        String access_token = getToken(tokenBody);
        
        RestResponse res = RestContext.response;
        
        String resBody = sendReq(access_token,body);
        
        if(String.isNotBlank(resBody)){
            res.responseBody = Blob.valueOf(resBody);
            res.headers.put('Content-Type', 'application/json');
            res.statusCode = 200;
        }
        else
            res.statusCode = 401;
        
        
        
        system.debug('Actual response >>> ' + res);
        
    }
    
    public static String getToken(String tokenBody){
        HTTP h = new HTTP();
        HTTPRequest r = new HTTPRequest();
        string url = 'https://rochedc--prototyp13.cs86.my.salesforce.com/services/oauth2/token';
        r.setEndpoint(url);
        r.setBody(tokenBody);
        r.setMethod('POST');
        r.setHeader('Content-Type','application/x-www-form-urlencoded');
        HTTPResponse resp = h.send(r);
        system.debug('Token Response >>>>'+resp.getBody());
        if(resp.getStatusCode() == 200){
            AccessToken at = (AccessToken) System.JSON.deserialize(resp.getBody(), AccessToken.class);
            return at.access_token;
        }
        else           
            return null;
    }
    
    public Static String sendReq(String access_token, String body){
        HTTP h = new HTTP();
        HTTPRequest r = new HTTPRequest();
        string url = 'https://rochedc--prototyp13.cs86.my.salesforce.com/services/apexrest/accountDetails';
        r.setEndpoint(url);
        r.setBody(body);
        r.setMethod('POST');
        r.setHeader('Content-Type','application/json');
        r.setHeader('Authorization','OAuth '+access_token);
        HTTPResponse resp = h.send(r);
        if(resp.getStatusCode()==200)
            return resp.getBody();
        else
            return null;
    }
    
    public class AccessToken {
        public String access_token;
        public String instance_url;
        public String id;
        public String token_type;
        public String issued_at;
        public String signature;
    }
}