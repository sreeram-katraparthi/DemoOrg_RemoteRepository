public class JsonParserForAddressUpdateRequest {
	public string name;
    public string userId;
    public string street;
    public String city;
    public string state;
    public string country;    
	public String zipCode;
    /*public OrderProduct ordProd;
    public class OrderProduct {
		public String ProductCode;
        public integer ListPrice;
        public integer unitPrice;        
		public integer Quantity;
	}*/
	public static JsonParserForAddressUpdateRequest parse(String json){
		return (JsonParserForAddressUpdateRequest) System.JSON.deserialize(json, JsonParserForAddressUpdateRequest.class);
	}
}