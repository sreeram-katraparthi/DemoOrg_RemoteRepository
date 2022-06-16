import { LightningElement, api, track } from 'lwc';
import { RecordFieldDataType } from 'lightning/uiRecordApi';

export default class RecEditForm extends LightningElement {
@api recordId;
@track res='';

handleChange(event){
    this.res = event.target.value;
}

handleSubmit(event){
    event.preventDefault();       // stop the form from submitting
    const fields = event.detail.fields;
    fields.Email = this.res;
    fields.LastName = 'test last name';
    fields.Company = 'test company';
    this.template.querySelector('lightning-record-edit-form').submit(fields);
 }
 handleSucess(event){
    const updatedRecord = event.detail.id;
    console.log('onsuccess: ', updatedRecord);
 }
 
    handleError(event) {
        var errors = event.detail.output.fieldErrors;
        console.log("response", JSON.stringify(errors));
    }
}