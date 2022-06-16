public class Duplicate_ProductJsonParser {
    public static Map<Integer,Map<String,String>> getParsedJsonResult(jsonparser parser){
        Map<Integer,Map<String,String>> prodMap = new Map<Integer,Map<String,String>>();
        Map<String,String> individualValue = new Map<String,String>();
        
        try{
            boolean addkey = false;
            boolean addRootKey = false;
            String key;
            
            while(parser.nextToken() != null){ 
                addKey = false;
                addRootKey = false;
                key = parser.getText();
                if((key == ProductConstanstsController.PRODNAME) || (key == ProductConstanstsController.QUANTITY) || (key == ProductConstanstsController.TYPE)){
                    addKey = true;
                }else if(key == ProductConstanstsController.ID){
                    addRootKey = true;
                }
                parser.nextToken();
                if(addKey == true){
                    individualValue.put(key,parser.getText());
                }
                if(addRootKey == true){
                    prodMap.put(parser.getIntegerValue(),individualValue);
                    individualValue = new Map<String,String>();
                }
            }
            return prodMap;
        }
        catch(Exception ex){
            system.debug(ex.getMessage());
            return prodMap;
        }
    }
}