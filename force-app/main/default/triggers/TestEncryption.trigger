trigger TestEncryption on Account (before insert,before update) {
    
    for(account acc : trigger.new){
        system.debug('acc.phone'+acc.phone);
        if(acc.phone == '123456'){
            system.debug('in before insert');
        }
    }
}