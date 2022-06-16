import { LightningElement,api,wire,track} from 'lwc';
import { getRecord, getRecordUi, generateRecordInputForUpdate } from 'lightning/uiRecordApi';
import LEAD_OBJECT from '@salesforce/schema/Lead';
import STATUS_FIELD from '@salesforce/schema/Lead.status';
import OWNER_FIELD from '@salesforce/schema/Lead.OwnerId';
import USER_ID from '@salesforce/user/Id';
import { ShowToastEvent } from 'lightning/platformShowToastEvent'

export default class updateRecOnLoad extends LightningElement {

    @api recordId;
    leadObject = LEAD_OBJECT;


    @wire(getRecord, { recordId: '$recordId', fields: [STATUS_FIELD,OWNER_FIELD] })
    record;

    connectedCallback() {
        /*console.log('TEST 1: '+this.testIfSiteNull)
        this.accountName= this.record.data ? getFieldValue(this.record.data, NAME_FIELD) : '';
        this.accountSite= this.record.data ? getFieldValue(this.record.data, SITE_FIELD) : '';
        this.testIfSiteNull= this.accountSite!=='' && this.accountSite!==null ? true : false;
        console.log('init : Name '+this.accountName+'  Site '+this.accountSite);
        console.log('TEST 2: '+this.testIfSiteNull);
        const fields = {};
        fields[OWNER_FIELD.fieldApiName] = USER_ID;
        fields[FIRSTNAME_FIELD.fieldApiName] = this.template.querySelector("[data-field='FirstName']").value;
        fields[LASTNAME_FIELD.fieldApiName] = this.template.querySelector("[data-field='LastName']").value;*/
        const fields = {};
        fields[OWNER_FIELD.fieldApiName] = USER_ID;
        fields[STATUS_FIELD.fieldApiName] = 'Closed - Not Converted'; 
        console.log('** recordInput FIelds **'+fields);
        const recordInput = { fields };
        console.log('** recordInput **'+recordInput);

        /*const record = this.record;
        const leadObjectInfo = LEAD_OBJECT.objectapiname;
        const recordInput = generateRecordInputForUpdate(
            record,
            leadObjectInfo
        );*/

        updateRecord(recordInput)
        console.log('** after updateRecrod **');
                 /*.then(() => {
                    const value = true;       
                    const valueChangeEvent = new CustomEvent("valuechange", {value});
                    console.log('** on success ** valueChangeEvent **'+valueChangeEvent);
                    this.dispatchEvent(valueChangeEvent);
                    // Display fresh data in the form
                    //return refreshApex(this.contact);
                })
               .catch(error => {
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Error creating record',
                            message: error.body.message,
                            variant: 'error'
                        })
                    );
                });*/
            }

    
}