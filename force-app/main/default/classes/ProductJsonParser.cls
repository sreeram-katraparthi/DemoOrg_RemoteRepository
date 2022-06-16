public class ProductJsonParser {
    public static Map<integer,list<map<string,string>>> getParsedJsonResult(JsonParser parser){
        Map<integer,list<map<string,string>>> ProdList = new Map<integer,list<map<string,string>>>();
        Map<String,String> individualValue = new Map<String,String>();
        List<Map<String,String>> IndividualList = new List<Map<String,String>>();
        try{
            String key;
            boolean keyAdd = false;
            boolean rootKeyAdd = false;
            while(parser.nextToken() != null){
                keyAdd = false;
                rootKeyAdd = false;
                key = parser.getText();
                if((key=='ProductName') || (key=='Quantity') || (key=='Type')){
                    keyAdd = true;
                }else if(key=='id'){
                    rootKeyAdd = true;
                }
                parser.nextToken();
                if(keyAdd){
                    individualValue.put(key,parser.getText());
                    IndividualList.add(individualValue);
                }
                if(rootKeyAdd){
                    ProdList.put(parser.getIntegerValue(),IndividualList);
                    individualValue = new Map<String,String>();
                    IndividualList = new List<Map<String,String>>();
                }
        	}
            return ProdList;
        }
        catch(Exception e){
            system.debug(e.getMessage());
            return ProdList;
        }
        
    }
}