@RestResource(urlmapping='/api/webhooks/incoming/pushDetails/*')
global class Webhook_GitHubSubscription {
	@HttpPost 
    global static void handleNotification(){
        try{
            RestRequest request = RestContext.request;
            RestResponse response = RestContext.response;
            system.debug('Responnse from Git : '+response);
        }catch(Exception ex){
            System.debug('Exception happened : '+ex.getMessage());
        }
    }
}