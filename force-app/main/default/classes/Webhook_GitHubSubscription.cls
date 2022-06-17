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
        }catch(Exception ex){
            System.debug('Exception happened : '+ex.getMessage());
        }
    }
}