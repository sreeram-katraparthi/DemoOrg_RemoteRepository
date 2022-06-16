import { LightningElement, track } from 'lwc';
import USER_ID from '@salesforce/user/Id';
//https://rajvakati.com/2019/02/11/get-current-user-details-in-lightning-web-components/
export default class UserDetails extends LightningElement {
    @track name='test user';
    @track email='test email';
    @track uId = USER_ID;
}