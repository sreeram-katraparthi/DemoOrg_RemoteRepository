import { LightningElement } from 'lwc';

export default class TemplateLooping extends LightningElement {
    carArray = ['Audi', 'BMW', 'Bently', 'Benz', 'Ferrari']

    ceoList = [{
            id: 1,
            Company: 'Google',
            Name: 'Sunder'
        },
        {
            id: 2,
            Company: 'Apple Inc',
            Name: 'Tim Cook'
        },
        {
            id: 3,
            Company: 'Facebook',
            Name: 'Mark ZuckerBerg'
        },
        {
            id: 4,
            Company: 'Amazon',
            Name: 'Jeff Bezos'
        },
    ]
}