import { LightningElement , track , api } from 'lwc';

export default class CustomCell extends LightningElement {
    @api details;
    @track value='abc';
    onChange(){
        console.log('onchange handler called');
        this.dispatchEvent(new CustomEvent("cellchange", {
            detail: {
                draftValues: {'1234':'mahi'}
            }
        }));
    }
}