import { LightningElement } from 'lwc';

export default class Training_Use_Case1 extends LightningElement {
    myText = "This is Sreeram";

    handleChange(event){
        this.myText = event.target.value;
    }
}