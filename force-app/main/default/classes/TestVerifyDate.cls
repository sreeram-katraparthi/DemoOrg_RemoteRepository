@isTest
private class TestVerifyDate {
    @isTest static void checkDatesTestTrue(){
        Date date1 = Date.today();
        Date date2 = date1.addDays(29);
        Date t = VerifyDate.CheckDates(date1, date2);
        System.assertEquals(t, date2);        
    }
    @isTest static void dateOver(){
        Date date1 = Date.today();
        Date date2 = date1.addDays(31);
        Date t = VerifyDate.CheckDates(date1, date2);
        System.assertEquals(t, date1);        
    }
}