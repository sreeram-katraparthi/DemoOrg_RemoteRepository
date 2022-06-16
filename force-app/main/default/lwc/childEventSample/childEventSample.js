import { LightningElement, api } from 'lwc';

export default class ChildEventSample extends LightningElement {
    @api nxtMsg;
    @api prvMsg;
    previousHandler(event){
        console.log('** inside child previousHandler');
        this.prvMsg = "Previous Page";
        const prvEvent = new CustomEvent('previous', {details : this.prvMsg});
        this.dispatchEvent(prvEvent);
        console.log('** aftr previous event dispatch **'+prvEvent);
    }
    nextHandler(event){
        console.log('** inside child nextHandler');
        this.nxtMsg = "Next Page";
        const nxtEvent = new CustomEvent('next', {details : this.nxtMsg});
        this.dispatchEvent(nxtEvent);
        console.log('** aftr next event dispatch **'+nxtEvent);
    }
}