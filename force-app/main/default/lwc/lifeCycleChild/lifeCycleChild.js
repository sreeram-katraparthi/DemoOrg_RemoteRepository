import { LightningElement } from 'lwc';

export default class LifeCycleChild extends LightningElement {
    constructor() {
        super()
        console.log('Child constructor called')
    }
    connectedCallback() {
        console.log(' CHild Connected Callback Called')
    }
    renderedCallback() {
        console.log('Child Rendered Callback Called')
    }
}