import { LightningElement } from 'lwc';

export default class HelloWorldFeb17 extends LightningElement {
    greeting = "Hello Everyone, Welcome to LWC World"

    obj = {
        Name: 'Sreeram',
        City: 'Kakinada'
    }

    addcity(event) {
        this.obj = {...this.obj, 'City': event.target.value, Qualification: 'MCA' }
    }

}