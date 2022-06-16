import { LightningElement } from 'lwc';

export default class MyFirstLWC extends LightningElement {
    name = 'This is Sreeram';
    phone = '';
    updateoutput(event){
        this.phone = event.target.value;
        console.log(this.phone);
    }
}