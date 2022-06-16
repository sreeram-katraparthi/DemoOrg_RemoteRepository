import { LightningElement } from 'lwc';
const COLS = [
    { label: 'column1', fieldName: 'market',type: 'CustomCell',editable: true}
];

export default class TestInlineEdit extends LightningElement {
    columns = COLS;
    mdata =[{Id:1234,column1:1}];
}