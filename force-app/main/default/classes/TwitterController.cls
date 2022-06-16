//https://developer.salesforce.com/docs/component-library/documentation/lwc/lwc.data_edit_record
//https://mickwheelz.net/index.php/2018/10/03/continuous-integration-with-github-sfdx-and-circleci-easier-than-you-think/
//https://developer.salesforce.com/blogs/2019/02/working-with-aura-and-lightning-web-components-interoperability-and-migration.html
//http://sfdcmonkey.com/2019/04/01/lightning-datatable-lightning-web-component/
//https://trailhead.salesforce.com/en/content/learn/trails/communities?trailmix_creator_id=raulnabarret&trailmix_id=community-cloud-trailmix 
public class TwitterController {
	private ApexPages.StandardController TwitterController ;
	public String sBody{get;set;}
	public String tweets{get;set;}
	public String access_token {get;set;}
	public void Scontroller()
	{
		  
		String keyencoded = EncodingUtil.urlEncode('3MVG92u_V3UMpV.g266PNI7t8sUciOoP_ivxwuZ2vWtCr1KyVt_mZpa3Ut9z10PMaTLSaubZQzM8swrnhxcXC','UTF-8');
		String secretkeyencoded = EncodingUtil.urlEncode('8703768126036164056', 'UTF-8');
		String sFinal = keyencoded + ':' + secretkeyencoded;
		Blob headerValue = Blob.valueOf(sFinal);
		HttpRequest req = new HttpRequest();
		req.setEndpoint('https://my.exacttarget.com/oauth2/token');
		req.setMethod('POST');
		String authorizationHeader = 'Basic ' + EncodingUtil.base64Encode(headerValue);
		req.setHeader('Authorization', authorizationHeader);
		req.setBody('grant_type=client_credentials');
		Http http = new Http();
		HTTPResponse res = http.send(req);

		JSONParser parser = JSON.createParser(res.getBody());
		while(parser.nextToken() != null)
		{
			if(parser.getCurrentToken() == JSONToken.FIELD_NAME)
			{
				String fieldName = parser.getText();
				parser.nextToken();
				if(fieldName == 'access_token')
				{
					access_token = parser.getText();
				}

			}
		}


	}

	public String gettweetsss(){

		HttpRequest req2 = new HttpRequest();

			req2.setEndpoint('https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=twitterdev&count=12');
			req2.setMethod('GET');
			 
			//Call Bearer token Method
			String authorizationHeader = 'Bearer ' + access_token;
			req2.setHeader('Authorization', authorizationHeader);
			 
			Http http = new Http();
			HTTPResponse res = http.send(req2);
		   
			tweets = res.getBody();
			return tweets;  
	}
}