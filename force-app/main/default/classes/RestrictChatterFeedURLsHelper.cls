public class RestrictChatterFeedURLsHelper {
    String invalidURL;
    
    public boolean restrictURLs(string url){
        //String myvar1 = '(?:(?:(?:[a-z0-9]{3,9}:(?://)?)(?:[-;:&=+$,w]+@)?[a-z0-9.-]+|(?:www.|[-;:&=+$??,w]+@)[a-z0-9.-]+)((?:/[+~%/.w-]*)?\\??(?:[-+=&;%@.w]*)#?w*)?)';
        String myvar1 = '(?:(?:(?:[a-z0-9]{3,9}:(?://)?)(?:[-;:&=+$,w]+@)?[a-z0-9.-]+|(?:www.|[-;:&=+$??,w]+@)[a-z0-9.-]+)((?:/[+~%/.w-]*)?\\??(?:[-+=&;%@.w]*)#?w*)?)|([.][a-zA-Z][a-zA-Z][a-zA-Z])';
        //String myvar1 = '^(http:\\/\\/www\\.|https:\\/\\/www\\.|http:\\/\\/|https:\\/\\/)?[a-z0-9]+([\\-\\.]{1}[a-z0-9]+)*\\.[a-z]{2,5}(:[0-9]{1,5})?(\\/.*)?$';
        string Location;
        string LocationURL;
        boolean isURLAllowed = true;
        
        system.debug('** url **'+url);
        Pattern MyPattern = Pattern.compile(myvar1);
        system.debug('** MyPattern **'+MyPattern);
        Matcher MyMatcher = MyPattern.matcher(url);
        system.debug('** MyMatcher **'+MyMatcher);
        map<string,string> mdtURLs = new Map<string,string>();
        
        for(ChatterFeedURLs__mdt urls :  [SELECT URL__c FROM ChatterFeedURLs__mdt]){
            mdtURLs.put(urls.URL__c,urls.URL__c);
        }
        while (MyMatcher.find()) { 
            System.debug(MyMatcher.group());
            Location = MyMatcher.group();
            LocationURL = Location.removeEnd('/');
            if(!mdtURLs.containsKey(LocationURL)){
                System.debug('mdtURLs.containsKey(Location)**'+mdtURLs.containsKey(LocationURL));
                isURLAllowed = false;
                invalidURL = LocationURL;
            }
        }
        return isURLAllowed;
    }
    
    public string getInvalidURL(){
        return invalidurl;
    }
}