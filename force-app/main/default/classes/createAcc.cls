//https://drive.google.com/drive/folders/1XvDaqRmhgO88NSHiw3UQxT-N_njDNDn9?usp=sharing

public with sharing class createAcc {
    @AuraEnabled
    public static Account createAccount(Account acc) {
        system.debug('acc'+acc);
        
        insert acc;
        return acc;
    }
}