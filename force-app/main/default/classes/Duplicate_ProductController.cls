public class Duplicate_ProductController {
    public static void getProductInfoFromAPI(){
        try{
            httpresponse response = Duplicate_HTTPController.getResult('callout:ExternalProductAPI/Product');
            if(response.getStatusCode() == 200){
                Map<Integer,Map<String,String>> prodInfoMap = Duplicate_ProductJsonParser.getParsedJsonResult(json.createParser(response.getBody()));
                system.debug('ProdMap : '+prodInfoMap);
                List<ProductWrapper> prodList = new List<ProductWrapper>();
                for(Integer key : prodInfoMap.keySet()){
                    ProductWrapper prod = new ProductWrapper();
                    prod.ProductName = ProdInfoMap.get(key).get('ProductName');
                    prod.Quantity = prodInfoMap.get(key).get('Quantity');
                    prod.Type = prodInfoMap.get(key).get('Type');
                    prod.externalId = key;
                    prodList.add(prod);
                }
                system.debug('ProdWrapper List : '+prodList);
            }
        }
        catch(Exception ex){
         	   system.debug(ex.getMessage());
        }        
    }
}