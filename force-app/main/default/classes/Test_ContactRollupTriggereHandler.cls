@isTest
public class Test_ContactRollupTriggereHandler {
    @isTest static void testContactRollup(){
        List<Account> toInsertAcc = new List<Account>();
        Account acc = new Account(Name='Test Trigger',
                              AnnualRevenue=1111,
                              BillingStreet='Test Street',
                              BillingCity='Test City',
                              BillingState='Test State',
                              BillingCountry='INDIA',
                              BillingPostalCode='12345678');
        toInsertAcc.add(acc);
        Account acc1 = new Account(Name='Test Trigger1',
                              AnnualRevenue=1112,
                              BillingStreet='Test Street',
                              BillingCity='Test City',
                              BillingState='Test State',
                              BillingCountry='INDIA',
                              BillingPostalCode='123456789');
        toInsertAcc.add(acc1);
    	insert toInsertAcc;
        
        List<Contact> toInsertCon = new List<Contact>();
        for(Integer i=1;i<5;i++){
            Contact con = new Contact(LastName='Test Contact '+i,AccountId = acc.Id);
            toInsertCon.add(con);
        }
        for(Integer j=10;j<15;j++){
            Contact con1 = new Contact(LastName='Test Contact '+j,AccountId = acc1.Id);
            toInsertCon.add(con1);
        }
        insert toInsertCon;
        
        /*List<Contact> toUpdateCon = new List<Contact>();
        Contact upCon = [select id,AccountId from Contact where Id = :toInsertCon[0].Id];
        upCon.AccountId = acc1.Id;
        toUpdateCon.add(upCon);
		update toUpdateCon;*/
        toInsertCon[0].AccountId = acc1.Id;		        
        update toInsertCon[0];
    }    
}