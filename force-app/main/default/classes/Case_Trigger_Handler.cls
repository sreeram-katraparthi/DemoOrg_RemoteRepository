public class Case_Trigger_Handler {
    public static void beforeUpdate(List<Case> cases){
        system.debug('** beforeUpdate method from Case trigger handler ran **');
        for(Case cs : cases){
            cs.subject = 'Trigger Updated Me';
        }
    }
}