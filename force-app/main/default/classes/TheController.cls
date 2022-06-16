public class TheController {
    
    public Account newAccount{get;set;}
    String AccountId;
    list<Account> addedAccounts;
    
    public TheController(){
        newAccount = new Account();
        addedAccounts = new list<Account>();
    }
    
    public void setAccountId(String val)
    {
        this.AccountId=val;
    }
    public String getAccountId()
    {
        return this.AccountId;
    }
    
    public List<Account> getViewAccounts(){
        List<account> lstAccount = [select id, name, industry, type, phone from account where createdById =:userinfo.getuserId() order By CreatedDate desc];
        return lstAccount;
    }
    
    public void addAccount(){
        
        try {
            addedAccounts.add(newAccount.clone());
            insert newAccount.clone();
        } catch (Exception e) {
            ApexPages.addMessages(e);
        }
        
    }
    
    public List<account> getAddedAccountsList(){
        return addedAccounts;
    }
    
    public void EditAccount(){
        
    }
    public void DeleteAccount(){
    }
}