public class UserRegJSonParser{
	public String FirstName;	//Nanda
	public String LastName;	//Kumar 
    public string NewUser;
	public String Email;	//nandhuc91@gmail.com
    public date dob;
    public string mobile;
    public string Gender;
	public cls_address1 address;
    public class cls_address1 {
		public String StreetName;	//NehruStreet
		public String StreetNumber;	//7-183
		public String Line1;	//1st Mainroad,Perumbakkam
	}
	public static UserRegJSonParser parse(String json){
		return (UserRegJSonParser) System.JSON.deserialize(json, UserRegJSonParser.class);
	}
}