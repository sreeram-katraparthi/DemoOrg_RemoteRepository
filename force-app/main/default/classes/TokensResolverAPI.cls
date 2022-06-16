public class TokensResolverAPI {
	public List<cls_resolvedTokens> resolvedTokens;
    public class cls_resolvedTokens {
        public String token;	//abc123thn567
		public String tokenValue;	//user1@exacttarget.com
		public List<cls_attributes> attributes;
    }
    public class cls_attributes{
        public String name;	//FirstName
		public String value;
    }
}