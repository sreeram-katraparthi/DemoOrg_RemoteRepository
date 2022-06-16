public class ChatterURLRestriction {//RestrictChatterFeedURLsHelper
    
    String invalidURL;
    
    /*public Set<String> domains
    {
        get
        {
            if (domains == null)
            {
                domains = new Set<String>();
                for (ChatterFeedURLs__mdt domain : [SELECT URL__c,AllowedURL__c FROM ChatterFeedURLs__mdt])
                {
                    domains.add(domain.URL__c);
                }
            }
            return domains;
        }
        private set;
    }*/
    
    public boolean restrictURLs(string url){
        //String myvar1 = '(?:(?:(?:[a-z0-9]{3,9}:(?://)?)(?:[-;:&=+$,w]+@)?[a-z0-9.-]+|(?:www.|[-;:&=+$??,w]+@)[a-z0-9.-]+)((?:/[+~%/.w-]*)?\\??(?:[-+=&;%@.w]*)#?w*)?)|([.][a-zA-Z][a-zA-Z][a-zA-Z])';
        String myvar = '((?:[a-z0-9]{3,9}:(?://)?)(?:[-;:&=+$,w]+@)?[a-zA-Z0-9.-/]+|(?:www.|[-;:&=+$??,w]+@)[a-z0-9.-]+)|([.][a-zA-Z][a-zA-Z][a-zA-Z])';
        string Location;
        string LocationURL;
        boolean isURLAllowed = true;
        
        Pattern MyPattern = Pattern.compile(myvar);
        Matcher MyMatcher = MyPattern.matcher(url);
        map<string,string> mdtURLs = new Map<string,string>();
        
        for(ChatterFeedURLs__mdt urls :  [SELECT URL__c FROM ChatterFeedURLs__mdt]){
            mdtURLs.put(urls.URL__c,urls.URL__c);
        }       
        
        while (MyMatcher.find()) {
            Location = MyMatcher.group();
            System.debug('** Location **'+Location);
            LocationURL = Location.removeEnd('/');
            System.debug('** LocationURL **'+LocationURL);
            if(!mdtURLs.containsKey(LocationURL) || !mdtURLs.containsKey(Location)) {
                isURLAllowed = false;
                invalidURL = LocationURL;
            }
            /*if(!matchesAnyDomain(Location)){
                isURLAllowed = false;
                invalidURL = Location;
            }*/
        }
        return isURLAllowed;
    }
    
    public string getInvalidURL(){
        return invalidurl;
    } 
    
   /*public boolean matchesAnyDomain(string domain){
        system.debug('** domain **'+domain);
        for(string dom : domains){
            if (dom.containsIgnoreCase(domain)) return true;
        }
        return false;
    }*/
}