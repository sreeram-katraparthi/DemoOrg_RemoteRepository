import { LightningElement, api } from 'lwc';
import { getYoY } from 'c/ciMiscSharedJavaScript';
const   styleClass='slds-text-body--regular slds-m-left--medium verticalCenter yoy_metric';
export default class CiTallyComp extends LightningElement {
    isPositive;
    isNutral;
    count;
    _data;
    myStyleClass;
    yoy;
    @api
    set details(value){
        console.log('setter called ',value);
        this._data=value;
        if(value){
            this.populateYoY(value);
            this.populateCount(value);
        }
        
    }
    get details(){
        return this._data;
    }
    populateYoY(value) {
        console.log('populateYoY called');
        //if(value){
            this.yoy = getYoY(value);
            if(this.yoy > 0){
                this.yoy = '+ '+ this.yoy+'% ';
                this.myStyleClass= styleClass + ' yoy_metric_positive';
            }else if(this.yoy < 0){
                this.yoy = '- '+ Math.abs(this.yoy)+'% ';
                this.myStyleClass= styleClass + ' yoy_metric_negative';
            }else{
                this.yoy = ' '+ this.yoy+'% ';
                this.myStyleClass= styleClass + ' yoy_metric_nutral';
            }
            console.log('yoy '+ this.yoy);
            console.log('yoy value was set');
        //}
    }
    populateCount(value) {
        console.log('populateYoY called');
        let current_year= new Date().getFullYear();
        if(value[current_year])
        {
            this.count = value[current_year];
        }
        else
        {
            this.count = 0;
        }
    }
}