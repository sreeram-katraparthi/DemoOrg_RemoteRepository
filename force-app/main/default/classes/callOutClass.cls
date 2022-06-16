public class callOutClass {
    public HTTPResponse makeCall(){
        system.debug('** in callout class **');
        http h = new http();
        HTTPRequest req = new HTTPRequest();
        string url = 'https://th-apex-http-callout.herokuapp.com/animals';
        req.setEndpoint(url);
        //Blob headerValue = Blob.valueOf(username + ':' + password);
        //String authorizationHeader = 'BASIC ' + EncodingUtil.base64Encode(headerValue);
        //r.setHeader('Authorization', authorizationHeader);
        req.setMethod('GET');
        system.debug('** before callout **');
        HTTPResponse resp = h.send(req); 
        System.debug('** resp **'+resp);
        return resp;
    }
}