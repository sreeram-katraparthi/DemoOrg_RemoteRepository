import { LightningElement, track } from 'lwc';
console.log('hi');
export default class HelloWorld extends LightningElement {
    @track greeting='world';

    changeHandler(event){
        this.greeting=event.target.value;
    }
}