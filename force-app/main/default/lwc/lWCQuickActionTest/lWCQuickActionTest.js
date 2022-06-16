import { LightningElement, api, wire } from "lwc";
import fetchDog from '@salesforce/apex/DogAPIController.fetchRandomDog';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class HeadlessSimple extends LightningElement {
    isExecuting = false;

    @api async invoke() {
        let event = new ShowToastEvent({
            title: 'I am a headless action!',
            message: 'Hi there! Starting...',
        });
        this.dispatchEvent(event);
        this.boolShowSpinner = true;
        this.boolShowImage = false;
        console.log('** before fetch dog **');
        fetchDog({}).then(response => {
            console.log('response: ' +JSON.parse(response).message);
            this.strUrl = JSON.parse(response).message;
            this.boolShowImage = true;
            this.boolShowSpinner = false;
        }).catch(error => {
            console.log('Error: ' +error.body.message);
        });    
        console.log('** after fetch dog **');
        await this.sleep(2000);

        event = new ShowToastEvent({
            title: 'I am a headless action!',
            message: 'All done!',
        });
        this.dispatchEvent(event);
    }     

    sleep(ms) {
        return new Promise((resolve) => setTimeout(resolve, ms));
    }
}