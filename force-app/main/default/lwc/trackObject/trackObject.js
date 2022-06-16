import { LightningElement, track } from 'lwc';
export default class TrackObject extends LightningElement {
    @track x = {
        a : "",
        b : ""
    };

    init() {
        this.x.a = "a";
        this.x.b = "b";
    }

    update() {
        this.x.a = "aa";
        this.x.b = "bb";
    }
}