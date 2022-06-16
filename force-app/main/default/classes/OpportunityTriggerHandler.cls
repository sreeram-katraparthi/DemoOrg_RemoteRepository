public class OpportunityTriggerHandler {
    @future(callout=true)
    public static void sendRequest(){
        system.debug('** in trigger handler class **');
        callOutClass cos = new callOutClass();
        system.debug('** before calling  callout class **');
        HTTPResponse resp = cos.makeCall();
        system.debug('** after callout class **'+resp);
    }
}