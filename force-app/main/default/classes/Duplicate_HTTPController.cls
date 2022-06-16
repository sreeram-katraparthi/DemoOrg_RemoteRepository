public class Duplicate_HTTPController {
    public static httpresponse getResult(string endpoint){
        http h = new http();
        httprequest req = new httprequest();
        req.setEndpoint(endpoint);
        req.setMethod('GET');
        return h.send(req);
    }
}