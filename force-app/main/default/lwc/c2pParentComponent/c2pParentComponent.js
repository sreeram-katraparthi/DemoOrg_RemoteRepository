import { LightningElement } from 'lwc';

export default class C2pParentComponent extends LightningElement {
    showModal = false
    message
    handleClick() {
        this.showModal = true
    }
    closeModal(event) {
        this.showModal = false
        this.message = event.detail.msg
    }
}