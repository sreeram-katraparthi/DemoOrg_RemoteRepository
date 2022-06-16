public with sharing class Utility_PB_Trigger_Start {
	@InvocableMethod(label= 'StartTrigger' Description= 'Method allows us to remove bypass on trigger' category='Case')
    public static void startTrigger(List<string> triggerNames){
        Utility_Trigger_Names_Bypass.removeBypass(triggerNames[0]);
    }
}