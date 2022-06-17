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
            while(parser.nextToken() != null){
                if(parser.getText() == 'pusher'){
                    System.debug('in pusher next token : '+parser.nextToken());
                    
                }
            }
        }catch(Exception ex){
            System.debug('Exception happened : '+ex.getMessage());
        }
    }
}