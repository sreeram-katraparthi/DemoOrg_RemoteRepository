/*
 * {
    "resolvedTokens": [
        {
            "tokenRequestId":"abc123thn567",
            "tokenValue": "user1@exacttarget.com",
            "attributes": [
                {
                    "name": "FirstName",
                    "value": "Alice"
                },
                {
                    "name": "LastName",
                    "value": "Smith"
                }
            ]
        },
        {
            "tokenRequestId":"abc098thn654",
            "tokenValue ": "user2@gmail.com",
            "attributes": [
                {
                    "name": "FirstName",
                    "value": "John"
                },
                {
                    "name": "LastName",
                    "value": "Smith"
                }
            ]
        }
    ],
    "unresolvedTokens": [
        {
            "tokenRequestId":"abc098thn654",
            "message": "Invalid token; token does not exist." 
        }
	]
}
 */

global class JSONResponseSerialization{
    public List<cls_resolvedTokens> resolvedTokens {get;set;}   //cls_resolvedTokens[]
    public List<cls_unresolvedTokens> unresolvedTokens{get;set;}   //cls_unresolvedTokens[]	
	public class cls_resolvedTokens {
		//public String token{get;set;}	//abc123thn567
        public String tokenRequestId{get;set;}
		public String tokenValue{get;set;}	//user1@exacttarget.com
		public List<cls_attributes> attributes{get;set;}    //cls_attributes[]
	}
	public class cls_attributes {
	    public String name{get;set;}	//FirstName
		public String value{get;set;}	//Alice
		
	}    
	
	public class cls_unresolvedTokens {
        public String tokenRequestId{get;set;}
		public String message{get;set;}
	}
	public static JSONResponseSerialization parse(String json){
		return (JSONResponseSerialization) System.JSON.deserialize(json, JSONResponseSerialization.class);
	}
}