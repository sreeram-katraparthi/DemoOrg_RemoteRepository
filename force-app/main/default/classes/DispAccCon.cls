public class DispAccCon {
    public List<AccConWrapper> getAccCon(){
        List<Contact> cons = [select id,name,account.industry,account.website from contact limit 10];
        List<AccConWrapper> wrapListRecs = new List<AccConWrapper>();
        for(Contact wrap : cons){
            AccConWrapper wrapList = new AccConWrapper();
            wrapList.conName = wrap.name;
            wrapList.accIndustry = wrap.account.Industry;
            wrapList.accWebsite = wrap.account.website;
            wrapListRecs.add(wrapList);
        }
        system.debug('wrapListRecs'+wrapListRecs);
        return wrapListRecs;
        
    }
    public class AccConWrapper{
		public string conName;
        public string accIndustry;
        public string accWebsite;
    }

}