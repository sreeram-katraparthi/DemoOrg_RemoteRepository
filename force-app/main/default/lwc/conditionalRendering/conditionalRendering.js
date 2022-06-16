import { LightningElement } from 'lwc';

export default class ConditionalRendering extends LightningElement {
    isVisible = false
    name

    showMe() {
        this.isVisible = true
    }

    changeHandler(event) {
        this.name = event.target.value
    }

    get helloCheck() {
        return this.name === 'Hello'
    }
}