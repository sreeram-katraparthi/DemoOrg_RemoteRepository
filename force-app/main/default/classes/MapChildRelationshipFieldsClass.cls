public class MapChildRelationshipFieldsClass {
	public static Map<String,List<String>> getChildRelationships(String sObjectName){
        Map<String,List<String>> mapSObjectRelationship;
        Map<String, List<String>> edpsyncmap;
        List<String> dirtyFields;
        
        if(mapSObjectRelationship==null){
            mapSObjectRelationship = new Map<String,List<String>>();
            // Get all child relationships for sobject
            Schema.DescribeSObjectResult R = Schema.getGlobalDescribe().get(sObjectName).getDescribe();
            // Build a map of sobject and related lookup fields
            for(Schema.ChildRelationship C : R.getChildRelationships()){ 
                system.debug('--'+C.getChildSObject()+'--'+C.getField());
                String obj = String.valueof(C.getChildSObject());
                String field = String.valueof(C.getField());
                //metadata validator and ignore those sobject
                
                if(edpsyncmap.get(obj)==null ){
                    if(!mapSObjectRelationship.containsKey(obj)){                        
                        mapSObjectRelationship.put(obj,new List<String>{field});
                    }
                    else{
                        mapSObjectRelationship.get(obj).add(field);
                    }   
                }else{
                    //special objects
                    mapSObjectRelationship.put(obj,edpsyncmap.get(obj));
                    system.debug('mapSObjectRelationship '+mapSObjectRelationship);
                }                
            }
        }
        
        return mapSObjectRelationship;  
    }
}