import { LightningElement, wire, api } from 'lwc';
import getData from '@salesforce/apex/CI_OpportunityListViewController.getOpportunities';

const COLS = [
    { label: 'Market', fieldName: 'market',type: 'string',hideDefaultActions: true},
    { label: 'BL', fieldName: 'businessline',type: 'string',hideDefaultActions: true},
    { label: 'Assignment Type', fieldName: 'assignmentType',type: 'string',hideDefaultActions: true},
    { label: 'Property', fieldName: 'property', type: 'string',hideDefaultActions: true},
    { label: 'Phase', fieldName: 'phase',type: 'string',hideDefaultActions: true},
    { label: 'Opp No.', fieldName: 'oppNumber',type: 'OppDetails',hideDefaultActions: true},
    { label: 'Close Date', fieldName: 'closeDate',sortable: true, type: 'date',hideDefaultActions: true},
    { label: 'Owner', fieldName: 'ownerDetails', type: 'OwnerDetails',hideDefaultActions: true },
    // { label: 'Action', fieldName: 'Inquire', type: 'url',hideDefaultActions: true,wrapText: false }
];

export default class OpportunityListView extends LightningElement {
    @api recordId;
    columns = COLS;
    result;
    storeresult;
    count;
    showInlineSpinner=true;
    showviewmore=false;
    defaultSortDirection = 'asc';
    sortDirection = 'asc';
    sortedBy;
    

    @wire(getData,{accountid:'$recordId', isGlobalView:false} ) 
    handleResponse({ error , data }){
        if(data){
            console.log('data ',data);
            
            var datatodispay=[];
            if(data.length>20)
            {
                for(var i=0;i<20;i++)
                {
                    datatodispay.push(data[i]);
                }
                this.result=datatodispay;
                this.count=data.length;
                this.showviewmore=true;
            }
            else
            {
                this.result=data;
            }
            this.storeresult=data;

            this.showInlineSpinner=false;
        }

    }
    
    handleClick()
    {
        this.showInlineSpinner=true;
        this.showviewmore=false;
        this.result=this.storeresult;
        this.showInlineSpinner=false;
    }
    sortBy(field, reverse, primer) 
    {
        const key = primer
        ? function(x) {
        return primer(x[field]);
        }
        : function(x) {
        return x[field];
        };
        
        return function(a, b) {
        a = key(a);
        b = key(b);
        return reverse * ((a > b) - (b > a));
        };
    }
        
    onHandleSort(event) 
    {
        const { fieldName: sortedBy, sortDirection } = event.detail;
        const cloneData = [...this.storeresult];
        
        cloneData.sort(this.sortBy(sortedBy, sortDirection === 'asc' ? 1 : -1));
        this.sortDirection = sortDirection;
        this.sortedBy = sortedBy;

        var datatodispay=[];
        if(cloneData.length>20)
        {
            for(var i=0;i<20;i++)
            {
                datatodispay.push(cloneData[i]);
            }
            this.result=datatodispay;
            this.count=cloneData.length;
            this.showviewmore=true;
        }
        else
        {
            this.result=cloneData;
        }
        this.storeresult=cloneData;
    }
    /*@track defaultSortDirection = 'asc';
    @track sortDirection = 'asc';
    @track sortedBy;
    sortBy(field, reverse, primer) {
        const key = primer
            ? function(x) {
                  return primer(x[field]);
              }
            : function(x) {
                  return x[field];
              };

        return function(a, b) {
            a = key(a);
            b = key(b);
            return reverse * ((a > b) - (b > a));
        };
    }
    onHandleSort(event) {
        const { fieldName: sortedBy, sortDirection } = event.detail;
        const cloneData = [...this.result];

        cloneData.sort(this.sortBy(sortedBy, sortDirection === 'asc' ? 1 : -1));
        this.result = cloneData;
        this.sortDirection = sortDirection;
        this.sortedBy = sortedBy;
    }*/
}