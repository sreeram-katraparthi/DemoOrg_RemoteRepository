import { LightningElement, api } from 'lwc';

export default class CourseItem extends LightningElement {
    @api Course;
    renderedCallback() {
        console.log('Hello this is in render');
        console.log(this.Course);
    }
}