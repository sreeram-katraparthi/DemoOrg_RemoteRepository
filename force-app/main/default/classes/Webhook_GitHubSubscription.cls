@RestResource(urlmapping='/api/webhooks/incoming/pushDetails/*')
global class Webhook_GitHubSubscription {
	@HttpPost 
    global static void handleNotification(){
        try{
            RestRequest request = RestContext.request;
            Blob reqbody = request.requestBody();
            system.debug('Response from Git : '+reqbody);
            RestResponse response = RestContext.response;
            system.debug('Response from Git : '+response);
        }catch(Exception ex){
            System.debug('Exception happened : '+ex.getMessage());
        }
    }
}