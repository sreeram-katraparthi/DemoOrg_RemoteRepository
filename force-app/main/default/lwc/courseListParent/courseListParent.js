import { LightningElement } from 'lwc';

export default class CourseListParent extends LightningElement {
    courses = [
        {
            Id : 1,
            Name : 'SFDC Classic',
            Duration : '15 Days',
            Email : 'test@test.com',
            Phone : '9642887788'
        },
        {
            Id : 2,
            Name : 'SFDC Lightning',
            Duration : '15 Days',
            Email : 'test@test.com',
            Phone : '9642887788'
        },
        {
            Id : 3,
            Name : 'SFDC LWC',
            Duration : '15 Days',
            Email : 'test@test.com',
            Phone : '9642887788'
        },
        {
            Id : 4,
            Name : 'SFDC Integration',
            Duration : '15 Days',
            Email : 'test@test.com',
            Phone : '9642887788'
        },
        {
            Id : 5,
            Name : 'SFDC Data Migration',
            Duration : '15 Days',
            Email : 'test@test.com',
            Phone : '9642887788'
        },
    ];
}