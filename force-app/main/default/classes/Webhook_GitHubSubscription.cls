@RestResource(urlmapping='/api/webhooks/incoming/pushDetails/*')
global class Webhook_GitHubSubscription {
	@HttpPost 
    global static void handleNotification(){
        try{
            RestRequest request = RestContext.request;
            Blob reqbody = request.requestBody;
            system.debug('request body from Git : '+reqbody.toString());
            RestResponse response = RestContext.response;
            jsonparser parser = JSON.createParser(reqbody.tostring());
            pusher ps;
            while(parser.nextToken() != null){
                if(parser.getText() == 'pusher'){
                    parser.nextToken();
                    ps = (pusher) parser.readvalueas(pusher.class);
                    system.debug('Pusher details : '+ps); 
                }
            }
            response.statusCode = 200;
            response.responseBody = Blob.valueOf(JSON.serialize(new SFDCResponse('SUCCESS','Processed Successfully'))); 
        }catch(Exception ex){
            System.debug('Exception happened : '+ex.getMessage());
        }
    }

    public class pusher{
        public string name;
        public string email;
   } 

   public class SFDCResponse{
       string response;
       string message;
       public SFDCResponse(string response,string message){
           response = response;
           message = message;
       }
   }
}