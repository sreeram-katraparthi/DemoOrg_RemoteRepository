import { LightningElement, api, track } from 'lwc';

export default class DisqualifyLead extends LightningElement {

    @api recordId;
    @track reason = '';

    handleChange(event){
        this.reason = event.target.value;
    }

    handleSubmit(event) {
        console.log('onsubmit: '+ JSON.stringify(event.detail.fields));
        event.preventDefault();
        
        const fields = event.detail.fields;
        fields.Status = 'Disqualified';
        //fields.Lead_Status_Picklist__c = 'Disqualified';
        //fields.RecordTypeId = '01280000000Q2PeAAK';
        //fields.Reason_for_Disqualify__c = this.reason;
        console.log('** json stringify fields **'+JSON.stringify(fields));
        console.log('** json stringify fields **'+this.template.querySelector('lightning-record-edit-form'));
        this.template.querySelector('lightning-record-edit-form').submit(fields);
        
    }

    closeAuraQA(event){ 
        const value = true;       
        const valueChangeEvent = new CustomEvent("valuechange", {value});
        console.log('** on success ** valueChangeEvent **'+valueChangeEvent);
        this.dispatchEvent(valueChangeEvent);
    }

    handleReset(event) {
        const inputFields = this.template.querySelectorAll(
            'lightning-input-field'
        );
        if (inputFields) {
            inputFields.forEach(field => {
                field.reset();
            });
        }
     }
}