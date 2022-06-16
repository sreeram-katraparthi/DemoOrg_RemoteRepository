public without sharing class CI_OpportunitySummaryViewController {
    public CI_OpportunitySummaryViewController() {
        
    }
    @AuraEnabled(cacheable=true)
    public static void getActiveYoY(id accountid){
    /*public static List<map<integer,integer>> getActiveYoY(id accountid){
        //todo: filter by account
        //todo: yoy calculation to be moved out of the method.//moved this to javascript
        
        List<map<integer,integer>> countbyYear= new List<map<integer,integer>>();
        
        //Date LAST_YEAR_STARING;//Previous year starting day
        //LAST_YEAR_STARING = Date.newInstance(current_year-1,1,1);//last year jan first

        Date LAST_YEAR_SAMEDAY;//previous year sameday.
        Date LAST_BEFORE_YEAR;//current year -2
        Date LAST_2_BEFORE_YEAR;//current year -3
        Date current_Date= Date.today();
        integer current_Year=current_Date.year();
        integer current_Month=current_Date.month();
        integer current_Day=current_Date.day();
        LAST_YEAR_SAMEDAY=date.newinstance(current_Year-1, current_Month, current_Day); //current_Date.addDays(-365);//last year sameday
        LAST_BEFORE_YEAR=date.newinstance(current_Year-2, current_Month, current_Day);
        LAST_2_BEFORE_YEAR=date.newinstance(current_Year-3, current_Month, current_Day);
        
        //string soqlQuery='SELECT CALENDAR_YEAR(CloseDate) cy,count(Id) cnt FROM Opportunity WHERE accountid =:accountid AND ( (CloseDate > :LAST_YEAR_SAMEDAY AND CloseDate<=TODAY) OR (createddate >:LAST_BEFORE_YEAR AND createddate <=:LAST_YEAR_SAMEDAY) ) group by CALENDAR_YEAR(CloseDate)';

        string soqlQuery='SELECT CALENDAR_YEAR(CloseDate) cy,count(Id) cnt FROM Opportunity WHERE accountid =:accountid AND ( (Createddate <= :LAST_YEAR_SAMEDAY AND CloseDate>= :LAST_YEAR_SAMEDAY)) group by CALENDAR_YEAR(CloseDate)';
        
        AggregateResult[] groupedResults =DataBase.Query(soqlQuery);
        map<Integer,integer> activecountbyYear= new map<Integer,integer>();
        activecountbyYear.put(current_Year,0);
        activecountbyYear.put(current_Year-1,0);
        for(AggregateResult ar: groupedResults){
            if(activecountbyYear.containsKey((integer)ar.get('cy'))){
                activecountbyYear.put((integer) ar.get('cy'),(integer)ar.get('cnt') );
            }
        }
        System.debug('activecountbyYear '+activecountbyYear);
        countbyYear.add(activecountbyYear);
        
        List<OpportunityStage> lstopptyStages=[SELECT Id, MasterLabel, ApiName, IsActive, IsClosed, IsWon FROM OpportunityStage where isactive=true];
        Map<string,OpportunityStage> oppstagemap=new Map<string,OpportunityStage>();
        for(OpportunityStage oppstage:lstopptyStages)
        {
            oppstagemap.put(oppstage.ApiName,oppstage);
        }
        map<Integer,integer> woncountbyYear= new map<Integer,integer>();
        map<Integer,integer> lostcountbyYear= new map<Integer,integer>();
        Integer countforyear=0;
        string soqlwonQuery='SELECT Id,Name,StageName,CloseDate FROM Opportunity WHERE accountid =:accountid AND ( (CloseDate > :LAST_2_BEFORE_YEAR AND CloseDate<=:LAST_BEFORE_YEAR) OR (CloseDate >:LAST_BEFORE_YEAR AND CloseDate <=:LAST_YEAR_SAMEDAY) ) ORDER BY CloseDate Asc';
        List<Opportunity> lstOppty=DataBase.Query(soqlwonQuery);
        system.debug('CHECK LIST SIZE: '+lstOppty.size());
        for(Opportunity opp: lstOppty )
        {
            Integer intkey=Integer.valueOf(opp.CloseDate.year());
            OpportunityStage oppstage=oppstagemap.get(opp.stagename);
            //Uncomment 57 and remove 58
            //if(oppstage!=null && ((oppstage.IsClosed && oppstage.IsWon)))
            if(oppstage!=null)
            {
                if(woncountbyYear.containskey(intkey))
                {
                    woncountbyYear.remove(intKey);
                    woncountbyYear.put(intkey,countforyear+1);
                }
                else
                {
                    countforyear=0;
                    woncountbyYear.put(intkey,countforyear+1);
                }
                
            }
            if(oppstage!=null && ((oppstage.IsClosed && !oppstage.IsWon)))
            {
                if(lostcountbyYear.containskey(intkey))
                {
                    lostcountbyYear.remove(intKey);
                    lostcountbyYear.put(intkey,countforyear+1);
                }
                else
                {
                    countforyear=0;
                    lostcountbyYear.put(intkey,countforyear+1);
                }
            }
        }
        countbyYear.add(woncountbyYear);
        countbyYear.add(lostcountbyYear);
        system.debug('Map Returned: '+countbyYear);
        
        return countbyYear;*/
    }
}