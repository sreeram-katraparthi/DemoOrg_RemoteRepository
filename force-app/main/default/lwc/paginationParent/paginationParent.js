import { LightningElement } from 'lwc';

export default class PaginationParent extends LightningElement {
    page = 1;
    msg = "You are in home page.";
    
    handprev(event){
        if(this.page > 1){
            this.page = this.page - 1;
            console.log('event in prev'+event.prevMsg);
            console.log('this.msg in prev'+this.msg);
            
            this.msg = event.prevMsg.msg;
        }

    }
    handnext(event){
        this.page = this.page + 1;
        console.log('event in next'+event.nxtMsg);
        console.log('this.msg in next'+this.msg);
        this.msg = event.nxtMsg.msg;
    }
}