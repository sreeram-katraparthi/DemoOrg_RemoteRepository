public abstract class UserFactory extends SObjectFactory {
    
    public UserFactory() {
        sObjectType = User.sObjectType;
    }
    
    public SObject buildRecordWithData() {        
        User obj = new User();
        return setRecordData(obj);        
    }

    //to be implemented by extending class 
    abstract SObject setRecordData(User usr);
}