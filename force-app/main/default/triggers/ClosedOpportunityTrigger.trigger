trigger ClosedOpportunityTrigger on Opportunity (before insert) {
	List<Task> taskListToInsert = new List<Task>();
    for(Opportunity opp: Trigger.new){
        if(opp.Stagename == 'Closed Won'){
            Task t = new Task();
            t.Subject = 'Follow Up Test Task';
            t.whatId = opp.Id;
            taskListToInsert.add(t);
        }
    }
    if(taskListToInsert.size() > 0){
        insert taskListToInsert;
    }
}