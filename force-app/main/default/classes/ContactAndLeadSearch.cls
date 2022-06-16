public class ContactAndLeadSearch{
 public static List<List< SObject>> searchContactsAndLeads(String Smith){
 List<List<SObject>> searchList = [FIND 'Smith' IN ALL FIELDS 
                                      RETURNING Lead(LastName), Contact(LastName) ];
 
 return searchList ;
 }

}