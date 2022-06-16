import { LightningElement, track } from 'lwc';

export default class helloBinding extends LightningElement {
    @track greeting = 'Convert Name to Upper Case';
    @track fname = '';
    @track lname = '';

    handleChange(event) {
        const name = event.target.name;
        if(name === 'firstName'){
            this.fname = event.target.value;
        }else if(name === 'lastName'){
            this.lname = event.target.value;
        }
    }

    get uppercasedFullName(){
        const name = this.fname + ' ' + this.lname;
        return name.toUpperCase();
    }
}