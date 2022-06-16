import { LightningElement } from 'lwc';

export default class PaginationButtons extends LightningElement {
    handlePrevious(){
        const prevEvent = new CustomEvent('previous', {prevMsg : {msg : 'Moved to Previous Screen'}});
        this.dispatchEvent(prevEvent);
    }
    handleNext(){
        const nextEvent = new CustomEvent('next', {nxtMsg : {msg : 'Moved to Next Screen'}});
        this.dispatchEvent(nextEvent);
    }
}