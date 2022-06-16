public class TestUsersGenerator {    
    
    /*public static void CreateOccupierBrokerageBrokerUser(String userName) {        
        System.runAs (new User(Id = Userinfo.getUserId())) {
            User u = (User) new OccupierBrokerageBrokerUser(userName).buildAndInsertRecord();    
            TestUsersGenerator.AssignPermissionSet(u);
        }        
    }
    
    public static void CreateIndiaUser(String userName) {        
        System.runAs (new User(Id = Userinfo.getUserId())) {
            User u = (User) new IndiaUser(userName).buildAndInsertRecord();    
            TestUsersGenerator.AssignPermissionSet(u);
        }        
    }*/
    
    public static void CreateEmeaUser(String userName) {        
        System.runAs (new User(Id = Userinfo.getUserId())) {
            User u = (User) new EMEAUser(userName).buildAndInsertRecord();    
            TestUsersGenerator.AssignPermissionSet(u);
        }        
    }
    /*public static void CreateAPACLeaderUser(string userName){
        System.runAs (new User(Id = Userinfo.getUserId())) {
            User u = (User) new APACLeaderUser(userName).buildAndInsertRecord();
        }
    }
    

   public static void JPManagerUser(string userName){
        System.runAs (new User(Id = Userinfo.getUserId())) {
            User u = (User) new JPManagerUser(userName).buildAndInsertRecord();
            TestUsersGenerator.AssignPermissionSet(u);
        }
    }
    
    
      public static void CreateAmerUser(String userName) {        
        System.runAs (new User(Id = Userinfo.getUserId())) {
            User u = (User) new AMERUser(userName).buildAndInsertRecord();    
            TestUsersGenerator.AssignPermissionSet(u);
        }        
    }
    public static void CreateEMEAMultimarketBrokerUser(string userName){
        
    }*/
    //old method - Need to refactor    
    public static User AssignPermissionSet(User u) {
        String hashString = '1000' + String.valueOf(Datetime.now().formatGMT('yyyy-MM-dd HH:mm:ss.SSS'));
        Blob hash = Crypto.generateDigest('MD5', Blob.valueOf(hashString));
        String hexDigest = EncodingUtil.convertToHex(hash);
        //Created as criteria based sharing rules don't work in test classes
        //Need to run as different user to avoid mixed DML error message
        User thisUser = [select Id from User where Id = :UserInfo.getUserId()];
        System.runAs (thisUser) {
            PermissionSet ps = new PermissionSet(Name='testps1'+hexDigest, Label='testps1'+hexDigest);
            insert ps;
            List<ObjectPermissions> op = new List<ObjectPermissions>();
            op.add(new ObjectPermissions(ParentId=ps.Id,
                                         SobjectType='Opportunity',
                                         PermissionsRead=true,
                                         PermissionsEdit=true,
                                         PermissionsDelete=true,
                                         PermissionsModifyAllRecords=true,
                                         PermissionsViewAllRecords=true));
            
            op.add(new ObjectPermissions(ParentId=ps.Id,
                                         SobjectType='Account',
                                         PermissionsRead=true,
                                         PermissionsEdit=true,
                                         PermissionsDelete=true,
                                         PermissionsModifyAllRecords=true,
                                         PermissionsViewAllRecords=true));
            
            op.add(new ObjectPermissions(ParentId=ps.Id,
                                         SobjectType='Contact',
                                         PermissionsRead=true,
                                         PermissionsEdit=true,
                                         PermissionsDelete=true,
                                         PermissionsModifyAllRecords=true,
                                         PermissionsViewAllRecords=true));
            
            /*op.add(new ObjectPermissions(ParentId=ps.Id,
                                         SobjectType='Activity__c',
                                         PermissionsRead=true,
                                         PermissionsEdit=true,
                                         PermissionsDelete=true,
                                         PermissionsModifyAllRecords=true,
                                         PermissionsViewAllRecords=true));*/
            
           /* op.add(new ObjectPermissions(ParentId=ps.Id,
                                         SobjectType='SPOC__c',
                                         PermissionsRead=true,
                                         PermissionsEdit=true,
                                         PermissionsDelete=true,
                                         PermissionsModifyAllRecords=true,
                                         PermissionsViewAllRecords=true));            
            
            op.add(new ObjectPermissions(ParentId=ps.Id,
                                         SobjectType='Offer__c',
                                         PermissionsRead=true,
                                         PermissionsEdit=true,
                                         PermissionsDelete=true,
                                         PermissionsModifyAllRecords=true,
                                         PermissionsViewAllRecords=true));   
            
            op.add(new ObjectPermissions(ParentId=ps.Id,
                                         SobjectType='Private_Tag__c',
                                         PermissionsRead=true,
                                         PermissionsEdit=true,
                                         PermissionsDelete=true,
                                         PermissionsModifyAllRecords=true,
                                         PermissionsViewAllRecords=true));   
            
            /*op.add(new ObjectPermissions(ParentId=ps.Id,
                                         SobjectType='Private_Tag__Share',
                                         PermissionsRead=true,
                                         PermissionsEdit=true,
                                         PermissionsDelete=true,
                                         PermissionsModifyAllRecords=true,
                                         PermissionsViewAllRecords=true));*/
            
            insert op;            
            insert new PermissionSetAssignment(PermissionSetId = ps.Id, AssigneeId = u.Id);
        }
        return u;
    }
}