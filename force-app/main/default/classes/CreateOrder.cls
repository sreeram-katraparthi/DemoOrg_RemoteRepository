@RestResource(urlMapping='/NewOrder/*')
global with sharing class CreateOrder {

	@HttpPost
    global static Order newOrder(){
        String jsonString = RestContext.request.requestBody.toString();
        System.debug('** jsonString **'+jsonString);
        JsonParserForOrderCreation orderDetails = (JsonParserForOrderCreation)JSON.deserialize(jsonstring, JsonParserForOrderCreation.class);
        System.debug('** orderDetails.UserId **'+orderDetails.UserId);
        System.debug('** orderDetails.ordProd.basePrice **'+orderDetails.ordProd.ProductCode);
        JsonParserForOrderCreation newOrd = new JsonParserForOrderCreation();        
        
        Order ord = new Order(); 
        ord.Name = orderDetails.orderName;
        ord.AccountId = orderDetails.UserId;        
        ord.EffectiveDate = date.today();        
        ord.Status = 'Draft';
        ord.Pricebook2Id = '01s6F000008W8T3';
        insert ord;  
        
        OrderItem op = new OrderItem();
        op.OrderId = ord.id;
        op.Quantity = orderDetails.ordProd.Quantity;
        op.UnitPrice= orderDetails.ordProd.unitPrice;
        op.PricebookEntryId = '01u6F000009OouE';
        insert op; 
        System.debug('** order item id **'+op.id);
        
        List<Order> ordId = [select OrderNumber from Order where id=: ord.id limit 1];
        System.debug('userId***'+ordId[0]);
        return ordId[0];
    }   
}