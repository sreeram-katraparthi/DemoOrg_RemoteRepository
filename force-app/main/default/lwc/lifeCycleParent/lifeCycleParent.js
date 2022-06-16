import { LightningElement } from 'lwc';

export default class LifeCycleParent extends LightningElement {
    constructor() {
        super()
        console.log('Parent constructor called')
    }
    connectedCallback() {
        console.log('Connected Callback Called')
    }
    renderedCallback() {
        console.log('Rendered Callback Called')
    }
    name
    changeHandler(event) {
        this.name = event.target.value
    }
    showChild = false
    handleClick() {
        this.showChild = !this.showChild
    }
}