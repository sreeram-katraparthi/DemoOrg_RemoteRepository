trigger AccountAddressTrigger on Account (before insert, before update) {
Account acc = [select name from account where id='0016F00003JNnTD'];
    for(Account acct : Trigger.new){
        if(acct.Description == '9573943029'){
        system.debug('test=='+acct.phone);
            acct.type= 'Prospect';
        }
    }
}