trigger OppCountOnAcc on Opportunity (after insert,after update,after delete, after undelete) {
    System.debug('isBefore : '+Trigger.isBefore);
	System.debug('Trigger.new : '+Trigger.new);
    System.debug('Trigger.old : '+Trigger.old);
    System.debug('Trigger.newMap : '+Trigger.newMap);
    System.debug('Trigger.oldMap : '+Trigger.oldMap);
    System.debug('===============================================');
    System.debug('isAfter : '+Trigger.isAfter);
    System.debug('Trigger.new : '+Trigger.new);
    System.debug('Trigger.old : '+Trigger.old);
    System.debug('Trigger.newMap : '+Trigger.newMap);
    System.debug('Trigger.oldMap : '+Trigger.oldMap);
}