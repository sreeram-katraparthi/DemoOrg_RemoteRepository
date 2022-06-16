import { LightningElement } from 'lwc';

export default class C2pModelComponent extends LightningElement {
    closeModal() {
        const closeEvent = new CustomEvent('closemodal', {
            //bubbles: true,
            detail: {
                msg: "Modal closed Successfully"
            }
        })
        this.dispatchEvent(closeEvent)
    }

    footerHandler() {
        console.log('footer handler clicked from child')
    }
}