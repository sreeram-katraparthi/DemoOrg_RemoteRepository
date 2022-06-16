public class SObjectHelper {
    
    public static sObject setAllBooleanFields (String objectName, SObject obj ,Boolean value) {
        
        Map <String, Schema.SObjectField> fieldMap = Schema.getGlobalDescribe().get(objectName).getDescribe().fields.getMap();        
        for (Schema.SObjectField fld : fieldMap.values()) {
            if (fld.getDescribe().getType().name()=='BOOLEAN' && fld.getDescribe().isCustom()==true) {
                obj.put(fld.getDescribe().getname(), value);
            }
            
        }
        return obj;
    }
    
 /*  
* Method name  : getSObjectFieldsInQuery
* Description  : This method is used to build the SOQL query string dynamically. 
* Return Type  : SOQL Query in string
* Parameter    : SObjectAPIName
*/ 
    public static string getSObjectFieldsInQuery(String sObjectName){
        Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
        Map<String, Schema.SObjectField> fieldMap = schemaMap.get(sObjectName).getDescribe().fields.getMap();
        List<String> fieldNames = new List<String>(fieldMap.keySet());
        String query = 'SELECT ' + String.join(fieldNames, ',') + ' FROM ' + sObjectName;
        return query; 
    }
}