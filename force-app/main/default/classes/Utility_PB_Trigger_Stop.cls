public with sharing class Utility_PB_Trigger_Stop {
    @InvocableMethod(label= 'StopTrigger' Description= 'Method allows us to bypass trigger' category='Case')
    public static void stopTrigger(List<string> triggerNames){
        Utility_Trigger_Names_Bypass.bypassTrigger(triggerNames[0]);
    }
}