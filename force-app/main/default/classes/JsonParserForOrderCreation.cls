public class JsonParserForOrderCreation {
	public string orderName;
    public String UserId;
    public Integer currencyCode;    
	public String OrderNumber;
    public OrderProduct ordProd;
    public class OrderProduct {
		public String ProductCode;
        public integer ListPrice;
        public integer unitPrice;        
		public integer Quantity;
	}
	public static JsonParserForOrderCreation parse(String json){
		return (JsonParserForOrderCreation) System.JSON.deserialize(json, JsonParserForOrderCreation.class);
	}
}