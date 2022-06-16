trigger HelloWorldTrigger on Book__c (before insert, before update) {
    List<Book__c> books = Trigger.new;
    system.debug(books);
    MyHelloWorld mhw = new MyHelloWorld();
    system.debug('is Insert operation : '+trigger.isInsert);
    system.debug('is Before operation : '+trigger.isBefore);
    system.debug('is it an update operatino? : '+trigger.isUpdate);
    if(trigger.isBefore){
        mhw.applyDiscount(books);
    }    
}