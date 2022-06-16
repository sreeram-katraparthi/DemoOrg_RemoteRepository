import LightningDatatable from 'lightning/datatable';
import CustomCell  from './customCell.html';
export default class OpportunityEditTable extends LightningDatatable {
    static customTypes = {
        CustomCell : {
             template : CustomCell
         }
     };
}