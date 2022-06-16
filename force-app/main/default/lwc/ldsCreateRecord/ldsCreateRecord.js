import { LightningElement, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { createRecord } from 'lightning/uiRecordApi';
import { reduceErrors } from 'c/ldsUtils';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import NAME_FIELD from '@salesforce/schema/Account.Name';
import TYPE_FIELD from '@salesforce/schema/Account.Type';
export default class LdsCreateRecord extends LightningElement {
    @track accountId;

    name = '';
    type = '';

    handleNameChange(event) {
        console.log('** in handle change event **  '+event);
        console.log('** in handle change this.accountId **  '+this.accountId);
        console.log('** in handle change event.target.value **  '+event);
        this.accountId = undefined;
        const name = event.target.name;
        if(name === "Name"){
            this.name = event.target.value;
        }else if(name === "Type"){
            this.type = event.target.value;
        }
    }

    createAccount() {
        const fields = {};
        console.log('** NAME_FIELD.fieldApiName **  '+NAME_FIELD.fieldApiName);
        fields[NAME_FIELD.fieldApiName] = this.name;
        fields[TYPE_FIELD.fieldApiName] = this.type;
        const recordInput = { apiName: ACCOUNT_OBJECT.objectApiName, fields };
        createRecord(recordInput)
            .then(account => {
                this.accountId = account.id;
                console.log('** this.dispatchEvent **  '+this.dispatchEvent);
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Account created',
                        variant: 'success'
                    })
                );
            })
            .catch(error => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error creating record',
                        message: reduceErrors(error).join(', '),
                        variant: 'error'
                    })
                );
            });
    }
}