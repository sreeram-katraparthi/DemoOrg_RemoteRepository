public class HTTPController {
    public static httpresponse getResult(string endpoint){
        try{
            http httpGet = new http();
            httprequest request = new httprequest();
            request.setEndpoint(endpoint);
            request.setMethod('GET');
            return httpget.send(request);
        }
        catch(Exception e){
            system.debug(e.getMessage());
            return null;
        }
    }
}