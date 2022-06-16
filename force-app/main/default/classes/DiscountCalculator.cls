public class DiscountCalculator {
    //Method helps to calcualte discount based on the price.
    public void applyDiscount(List<Book__c> books){
        for(Book__c book : books){
            book.Price__c *= 0.9;
        }
    }
}