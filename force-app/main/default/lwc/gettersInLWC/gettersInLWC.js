import { LightningElement } from 'lwc';

export default class GettersInLWC extends LightningElement {
    get sum() {
        return 30
    }

    users = ['sreeram', 'devi']
    obj = {
        Name: 'Sreeram',
        Age: 35
    }

    get firstuser() {
        return this.users[0].toUpperCase()
    }

    get age() {
        return this.obj.Age
    }
}