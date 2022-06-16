public class FindContactsByName {
    @AuraEnabled
    public static List<Contact> findAll() {
        return [SELECT id FROM Contact LIMIT 50];
    }

    @AuraEnabled
    public static List<Contact> findByName(String searchKey) {
        String name = '%' + searchKey + '%';
        return [SELECT id FROM Contact WHERE name LIKE :name LIMIT 50];
    }

    @AuraEnabled
    public static Contact findById(String contactId) {
        return [SELECT id,  title, mobilephone, Account.Name
                    FROM Contact WHERE Id = :contactId];
    }

}