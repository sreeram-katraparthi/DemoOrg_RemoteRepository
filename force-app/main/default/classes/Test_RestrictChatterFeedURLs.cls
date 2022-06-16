@isTest
public class Test_RestrictChatterFeedURLs {
    static testMethod void testValidPost(){
        opportunity opp = new Opportunity();
        opp.name = 'test opp';
        opp.stagename = 'Credit Approved';
        opp.closedate = system.today();
        insert opp;
        
        Test.startTest();
        FeedItem f = new FeedItem(Body = 'feeditem post test http://www.citigroup.net',parentID = userInfo.getUserId());
        insert f;
        FeedItem f1 = new FeedItem(Body = 'feeditem post test http://www.citigroup.net google.com',parentID = userInfo.getUserId()); 
        try{
            insert f1;
        }catch(Exception e){}
        FeedComment fc = new FeedComment(CommentBody='feedcomment Test Comment  test.com',FeedItemId = f.Id);
        try{
            insert fc;
        }catch(Exception e){}
        Test.stopTest();
		system.assertEquals(NULL, f1.Id);        
        System.assertEquals(NULL, fc.Id);
    }    
}