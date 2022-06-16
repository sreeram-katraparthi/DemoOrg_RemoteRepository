import { LightningElement, track } from 'lwc';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import NAME_FIELD from '@salesforce/schema/Account.Name';
import INDUSTRY_FIELD from '@salesforce/schema/Account.Industry';
import PHONE_FIELD from '@salesforce/schema/Account.Phone';
import createAccount from '@salesforce/apex/createAcc.createAccount';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class LightningExampleTextareaVarious extends LightningElement {
    @track selectedValue;
    @track showRadios = true;
    @track
        options = [
            {'label': 'Ross', 'value': 'Ross', checked: false},
            {'label': 'Rachel', 'value': 'Rachel',checked: false},
            {'label': 'Chandler', 'value': 'Chandler', checked: false},
        ];    
    @track areDetailsVisible1 = false;
    @track areDetailsVisible2 = false;
    @track areDetailsVisible3 = false;
    
    @track name = NAME_FIELD;
    @track industry = INDUSTRY_FIELD;
    @track phone = PHONE_FIELD;

    rec = {
        Name : this.name,
        Industry : this.industry,
        Phone : this.phone
    }


    handleradiochange(event){         
        this.selectedValue = event.target.value;
        this.options.forEach(option => option.checked = option.value === this.selectedValue);
        if(this.selectedValue === 'Ross'){
            this.areDetailsVisible1 = true;
            this.areDetailsVisible2 = false;
            this.areDetailsVisible3 = false;
        }else if(this.selectedValue === 'Rachel'){
            this.areDetailsVisible1 = false;
            this.areDetailsVisible2 = true;
            this.areDetailsVisible3 = false;
        }else if(this.selectedValue === 'Chandler'){
            this.areDetailsVisible1 = false;
            this.areDetailsVisible2 = false;
            this.areDetailsVisible3 = true;
        }
        
    }

    
    handleNameChange(event) {
        this.rec.Name = event.target.value;
        console.log("name1", this.rec.Name);
    }
    
    handleIndChange(event) {
        this.rec.Industry = event.target.value;
        console.log("Industry", this.rec.Industry);
    }
    
    handlePhnChange(event) {
        this.rec.Phone = event.target.value;
        console.log("Phone", this.rec.Phone);
    }
    handleClick() {
        createAccount({ acc : this.rec })
            .then(result => {
                console.log('** result **'+result);
                console.log('** this.rec **'+this.rec);
                console.log('** object.Phone **'+Object.Phone);
                this.message = result;
                this.error = undefined;
                if(this.message !== undefined) {
                    this.rec.Name = '';
                    this.rec.Industry = '';
                    this.rec.Phone = '';
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Success',
                            message: 'Account created',
                            variant: 'success',
                        }),
                    );
                }
                
                console.log(JSON.stringify(result));
                console.log("result", this.message);
            })
            .catch(error => {
                this.message = undefined;
                this.error = error;
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error creating record',
                        message: error.body.message,
                        variant: 'error',
                    }),
                );
                console.log("error", JSON.stringify(this.error));
            });
    }

}