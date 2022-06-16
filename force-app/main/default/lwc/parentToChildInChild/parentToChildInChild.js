import { LightningElement, api } from 'lwc';

export default class ParentToChildInChild extends LightningElement {
    @api getIdFromParent;
    @api objectApiName;
}