import { LightningElement, api } from 'lwc';

export default class OppDetails extends LightningElement {
    @api details;
    label='';
    value='';
    HasReadAccess=false;
    connectedCallback() {
        if (this.details) {
            //console.log('details ', this.details);
            if (this.details.oppNumber) {
                //this.label = this.details.oppNumber;
                //Below code will remove the SF- and trailing zeroes from the Opp Number
                this.label = parseInt(this.details.oppNumber.split('SF-')[1]).toString();
            }
            if (this.details.id) {
                this.value = '/' + this.details.id;
            }
            if (this.details.HasReadAccess) {
                this.HasReadAccess = (this.details.HasReadAccess === 'true');
                //console.log('this.HasReadAccess', this.HasReadAccess);
            }
        }
    }

}