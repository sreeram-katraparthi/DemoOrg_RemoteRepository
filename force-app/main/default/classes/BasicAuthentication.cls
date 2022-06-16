public class BasicAuthentication {
    public void authenticateSFMC(){
    	string username = 'sfmcsfdcuser@roche.com.pt13';
        string password = 'roche#1234';
        string url = 'https://sfdc-sfmc-auth.com';
        //string url = 'https://sfdc-sfmc-auth.com?grant_type=client_credentials&client_id=3MVG92u_V3UMpV.g266PNI7t8sUciOoP_ivxwuZ2vWtCr1KyVt_mZpa3Ut9z10PMaTLSaubZQzM8swrnhxcXC&client_secret='+
                          // '8703768126036164056&username=sfmcsfdcuser@roche.com.pt13&password=roche#1234';
        HTTP h = new HTTP();
        HTTPRequest r = new HTTPRequest();        
        system.debug('** request **'+r);        
        string headerValue = username + ':' + password;
        String authorizationHeader = 'Basic ' + EncodingUtil.urlEncode(headerValue, 'UTF-8');
        r.setEndpoint(url);        
        r.setHeader('Authorization', authorizationHeader);
        r.setMethod('GET'); 
        r.setHeader('grant_type', 'client_credentials');
        HTTPResponse resp = h.send(r);
        System.debug('HTTPResponse resp'+resp);
    }
}