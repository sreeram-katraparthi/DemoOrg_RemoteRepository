public class TokensParser { 
    public List<Tokens> tokens{get; set;}
    public String sendKey{get; set;}
    public class Tokens {
        public String tokenRequestId{get; set;}
        public String token{get; set;}
        public String subscriberKey{get; set;}
    } 
}