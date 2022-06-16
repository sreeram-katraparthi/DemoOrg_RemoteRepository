import { LightningElement } from 'lwc';

export default class Training_Use_Case2 extends LightningElement {
    name = "Sreeram";
    email = "Sreeram7899@gmail.com";
    phone = "9642887788";
    showDetails = false;

    handleNameChange(event){
        this.name = event.target.value;
    }
    handleEmailChange(event){
        this.email = event.target.value;
    }
    handlePhoneChange(event){
        this.email = event.target.value;
    }
    handleSubmit(){
        this.showDetails = true;
    }
}