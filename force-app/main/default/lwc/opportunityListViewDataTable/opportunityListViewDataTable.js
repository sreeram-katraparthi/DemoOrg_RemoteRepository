import LightningDatatable from 'lightning/datatable';
import iconDetailColumn  from './iconDetailColumn.html';
import oppDetailColumn  from './oppDetailColumn.html';
export default class OpportunityListViewDataTable extends LightningDatatable {
    static customTypes = {
       OwnerDetails : {
            template : iconDetailColumn
        },
        OppDetails : {
            template : oppDetailColumn
        }
    };
}