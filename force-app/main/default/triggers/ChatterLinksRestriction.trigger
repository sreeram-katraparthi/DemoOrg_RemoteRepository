trigger ChatterLinksRestriction on FeedItem (before insert,before update) {
    string commentBody;
    boolean invalidURL;
    RestrictChatterFeedURLsHelper helper = new RestrictChatterFeedURLsHelper();
    if(Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)){
        for(feedItem feedBody : trigger.new){
            commentBody = feedBody.Body;
        }
        if(commentbody != null){
            invalidURL = helper.restrictURLs(commentBody);
        }
        if(!invalidURL){
            string invURL = helper.getInvalidURL();
            trigger.new[0].addError('No immediate character is allowed after "." or please make sure to enter CITI allowed URL.: '+invURL);
        }
    }
}