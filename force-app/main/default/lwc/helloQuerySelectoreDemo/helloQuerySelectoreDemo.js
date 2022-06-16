import { LightningElement } from 'lwc';

export default class HelloQuerySelectoreDemo extends LightningElement {

    userNames = ["Sreeram", "Devi", "Puri", "skumar"]
    fetchDetailHandler() {
        const elemnt = this.template.querySelector('h1')
        console.log(elemnt.innerText)
        elemnt.style.border = "1px solid red"

        const elements = this.template.querySelectorAll('.name')
        Array.from(elements).forEach(item => {
                console.log(item)
                item.setAttribute("title", item.innerText)
            })
            //lwc:dom
        const childElemnts = this.template.querySelector(".child")
        childElemnts.innerHTML = '<p>I am a Child Element </p>'
    }



}