import { LightningElement, api } from 'lwc';

export default class P2cParentComponent extends LightningElement {
    carousalData = [{
            src: "https://www.lightningdesignsystem.com/assets/images/carousel/carousel-01.jpg",
            header: "First Card",
            description: "First card description from parent."
        },
        {
            src: "https://www.lightningdesignsystem.com/assets/images/carousel/carousel-02.jpg",
            header: "Second Card",
            description: "Second card description from parent."
        },
        {
            src: "https://www.lightningdesignsystem.com/assets/images/carousel/carousel-03.jpg",
            header: "Third Card",
            description: "Third card description from parent."
        }
    ]

    percentage = 10
    changeProgress(event) {
        this.percentage = event.target.value
    }

    handleClick() {
        this.template.querySelector('c-p2c-slider-component').resetSlider()
    }
}