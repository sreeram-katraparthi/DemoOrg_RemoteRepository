Trigger calculate on Item__c(after insert){
    Map<Id, Shipping_Invoice__c> updateMap = new Map<Id, Shipping_Invoice__c>();
    
    List<Item__c> itemList = Trigger.new;
    System.debug('itemList size : '+itemList.size());
    Set<Id> invoiceIdSet = new Set<Id>();
    
    for(Item__c item : itemList){
        invoiceIdSet.add(item.Shipping_Invoice__c);
    }
    System.debug('invoiceIdSet size : '+invoiceIdSet.size());
    List<Shipping_Invoice__c> allInvoices = [Select Id, subtotal__c, 
                          totalweight__c, grandtotal__c, 
                          ShippingDiscount__c, Shipping__c, tax__c from Shipping_Invoice__c where Id IN :invoiceIdSet];
    Map<Id, Shipping_Invoice__c> InvoiceMap = new Map<Id, Shipping_Invoice__c>();
    
    for(Shipping_Invoice__c invoice : allInvoices){
        InvoiceMap.put(invoice.Id, invoice);
    }
    System.debug(' at 20 Invoice allInvoices : '+allInvoices);
    System.debug(' at 20 Invoice Map : '+InvoiceMap);
    for(Item__c item : itemList){
        Shipping_Invoice__c invoice;
        invoice = InvoiceMap.get(item.Shipping_invoice__c);
        System.debug('From Item Map Invocie Subtotal : '+invoice.Subtotal__c);
        System.debug('From Item Map Invoice totalWeight : '+invoice.TotalWeight__c);
        invoice.Subtotal__c += (item.Price__c * item.Quantity__c);
        invoice.totalweight__c += (item.weight__c * item.Quantity__c);
        System.debug('at 28 Invoice Map : '+InvoiceMap);
    }
    System.debug('at 30 Invoice allInvoices : '+allInvoices);
    for(Shipping_Invoice__c invoice : allInvoices){        
        System.debug('after Item Map Invocie Subtotal : '+invoice.Subtotal__c);
        System.debug('after Item Map Invoice totalWeight : '+invoice.TotalWeight__c);
        invoice.Tax__c = invoice.Subtotal__c * 0.925;
        invoice.ShippingDiscount__c = 0;
        invoice.Shipping__c = (invoice.totalWeight__c * .75);
        invoice.GrandTotal__c = invoice.SubTotal__c + invoice.tax__c + invoice.Shipping__c;
        System.debug('at 38 invoice Map : '+InvoiceMap);
        updateMap.put(invoice.id, invoice);
    }
    
    update updateMap.values();
}