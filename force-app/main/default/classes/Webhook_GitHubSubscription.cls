@RestResource(urlmapping='/api/webhooks/incoming/pushDetails/*')
global class Webhook_GitHubSubscription {
	@HttpPost 
    global static void handleNotification(){
        try{
            RestRequest request = RestContext.request;
            Blob reqbody = request.requestBody;
            system.debug('request body from Git : '+reqbody.toString());
            RestResponse response = RestContext.response;
            system.debug('Response from SF : '+response);
            jsonparser parser = JSON.createParser(reqbody.tostring());
            pusher ps;
            while(parser.nextToken() != null){
                if(parser.getText() == 'pusher'){
                    parser.nextToken();
                    ps = (pusher) parser.readvalueas(pusher.class);
                    system.debug('Pusher detaisl : '+ps); 
                }
            }
        }catch(Exception ex){
            System.debug('Exception happened : '+ex.getMessage());
        }
    }

    public class pusher{
        public string name;
        public string email;
   } 
}