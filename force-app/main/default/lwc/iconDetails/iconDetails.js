import { LightningElement, api , track} from 'lwc';

export default class IconDetails extends LightningElement {
    @api details;
    @track name='';
    @track photourl='';
    isClosed=false;
    HasReadAccess=false;
    HasAccess=false;
    value='';
    connectedCallback(){
        //console.log('connectedCallback details '+this.details);
        if(this.details){
            if(this.details.SmallPhotoUrl){
                this.photourl=this.details.SmallPhotoUrl;
                //console.log('this.photourl ',this.photourl);
            }
            if(this.details.Name){
                this.name=this.details.Name;
                //console.log('this.name ',this.name);
            }
            //check if the user has access and opportunity is closed
            if (this.details.HasReadAccess){
                this.HasReadAccess = (this.details.HasReadAccess === 'true');
            }
            if (this.details.id) {
                this.value = '/' + this.details.id;
            }
            if (this.details.isClosed) {
                this.isClosed = (this.details.isClosed === 'true');
            }
            if(!this.HasReadAccess && !this.isClosed) {
                this.HasAccess=false;
            }
            else {
                this.HasAccess=true;
            }

        }
    }
    
}