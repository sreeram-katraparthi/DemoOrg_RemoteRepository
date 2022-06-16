import { LightningElement, wire, api } from 'lwc';
import getSummaryData from '@salesforce/apex/CI_OpportunitySummaryViewController.getActiveYoY';

export default class OpportunitySummaryView extends LightningElement {
    @api recordId;
    activeresult;
    wonresult;
    lostresult;
    //call apex 
    @wire(getSummaryData,{ accountid : '$recordId' } )
    handleResponse({ error , data }){
        if(data && data.length==3){
            console.log('data ',data);
            this.activeresult=data[0];
            this.wonresult=data[1];
            this.lostresult=data[2];
        }
        if(error){
            console.log('summary view error ',error);
        }

    }
    
}