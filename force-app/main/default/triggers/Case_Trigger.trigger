trigger Case_Trigger on Case (before update) {
    if(!Utility_Trigger_Names_Bypass.triggerNames.contains('Case_Trigger')){
        Case_Trigger_Handler.beforeUpdate(Trigger.New);
    }
}