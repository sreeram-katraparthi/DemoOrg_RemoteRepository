import { LightningElement } from 'lwc';

export default class ParentEventSample extends LightningElement {
    page = 1;
    pageMsg = 'Redirected to '+this.page;

    handlePrevious(event){
        console.log('** in parent handlePrevious **'+event.details);
        if(this.page > 1){
            this.page = this.page - 1;
            this.pageMsg = this.pageMsg + event.details;
        }
    }
    handleNext(event){
        console.log('** in parent handleNext **'+event.details);
        this.page = this.page + 1;
        this.pageMsg = this.pageMsg + event.details;
    }
}