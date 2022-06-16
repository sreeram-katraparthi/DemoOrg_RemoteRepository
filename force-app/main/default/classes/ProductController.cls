/*JSON String
 {
  "current_page": 1,
  "data": [
    {
      "ProductName": "Stout2",
      "Quantity": 100,
      "Type": "Stout",
      "id": 6,
      "createdAt": "2021-04-04T23:22:18.000000Z",
      "updatedAt": "2021-04-04T23:22:18.000000Z"
    },
    {
      "ProductName": "Stout1",
      "Quantity": 100,
      "Type": "Stout",
      "id": 5,
      "createdAt": "2021-04-04T23:22:14.000000Z",
      "updatedAt": "2021-04-04T23:22:14.000000Z"
    },
    {
      "ProductName": "Lager2",
      "Quantity": 100,
      "Type": "Lager",
      "id": 4,
      "createdAt": "2021-04-04T23:22:00.000000Z",
      "updatedAt": "2021-04-04T23:22:00.000000Z"
    },
    {
      "ProductName": "Lager1",
      "Quantity": 100,
      "Type": "Lager",
      "id": 3,
      "createdAt": "2021-04-04T23:21:56.000000Z",
      "updatedAt": "2021-04-04T23:21:56.000000Z"
    },
    {
      "ProductName": "Porter2",
      "Quantity": 10,
      "Type": "Porter",
      "id": 2,
      "createdAt": "2021-04-04T23:19:21.000000Z",
      "updatedAt": "2021-04-04T23:21:33.000000Z"
    },
    {
      "ProductName": "Porter1",
      "Quantity": 10,
      "Type": "Porter",
      "id": 1,
      "createdAt": "2021-04-04T23:18:36.000000Z",
      "updatedAt": "2021-04-04T23:21:25.000000Z"
    }
  ],
  "first_page_url": "https:\/\/testapi.io\/api\/dummyapi\/resource\/product?page=1",
  "from": 1,
  "last_page": 1,
  "last_page_url": "https:\/\/testapi.io\/api\/dummyapi\/resource\/product?page=1",
  "next_page_url": null,
  "path": "https:\/\/testapi.io\/api\/dummyapi\/resource\/product",
  "per_page": 50,
  "prev_page_url": null,
  "to": 6,
  "total": 6
}
*/
public class ProductController {
    Public static Map<integer,list<map<string,string>>> getProductInfoFromApi(){
        httpresponse response = HTTPController.getResult('callout:ExternalProductAPI/Product');
        if(response.getStatusCode() == 200){
            return ProductJsonParser.getParsedJsonResult(Json.createParser(response.getBody()));
        }else{
            return null;
        }      
    }
}