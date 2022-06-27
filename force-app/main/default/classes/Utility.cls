/**
 * Singleton:
 * The Singleton pattern attempts to solve the issue of repeatedly using an object instance, 
 * but only wishing to instantiate it once within a single transaction context.
 **/
public class Utility {
    
    private static Utility objInstance = null;
    public Integer acctCount;
    
    public Utility() {
        System.debug('** in constructor **');
        acctCount = [ SELECT COUNT() FROM Account ];
    }
    
    public static Utility getInstance() {
        System.debug('** before null check objInstance : **'+objInstance);
        if ( objInstance == null ){
            System.debug('** objInstance : **'+objInstance);
            objInstance = new Utility();
        }    
        return objInstance;
    }
    
}