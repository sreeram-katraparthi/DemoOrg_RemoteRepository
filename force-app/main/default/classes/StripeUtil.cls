global class StripeUtil {
	global static String cleanJson(String json) {
		json = json.replaceAll('"object":', '"stripeObject":');
		json = json.replaceAll('"date":', '"stripeDate":');
		json = json.replaceAll('"end":', '"endDate":');
		json = json.replaceAll('"data":', '"stripeData":');
		json = json.replaceAll('"currency":', '"stripeCurrency":');
		json = json.replaceAll('"type":', '"stripeType":');

		json = json.replaceAll('"customer":\\s?"cus_', '"customer_id": "cus_');
		json = json.replaceAll('"invoice":\\s?"in_', '"invoice_id": "in_');
		
		return json;
	}
}