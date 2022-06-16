public class MyHelloWorld {
   public void applyDiscount(List<Book__c> books) {
      system.debug('books from trigger'+books);
      for (Book__c b :books){
          system.debug('Price is : '+b.Price__c);
         b.Price__c *= 0.9;
          system.debug('after discount price is : '+b.Price__c);
      }
   }
}