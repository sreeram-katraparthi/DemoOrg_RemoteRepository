//https://trailhead.salesforce.com/content/learn/modules/apex_patterns_dsl
public with sharing class Utility_Trigger_Names_Bypass {
	public static set<string> triggerNames = new set<string>();
    
    public static void bypassTrigger(String triggerName){
        triggerNames.add(triggerName);
    }
    
    public static void removeBypass(string triggerName){
        triggerNames.add(triggerName);
    }
}