import { LightningElement } from 'lwc';

export default class QuizApp extends LightningElement {
    selected = {}
    score = 0
    isSubmitted = false
    quizItems = [{
            id: 'Q1',
            question: 'Which one of the following is not a template loop?',
            options: {
                a: 'for:each',
                b: 'iterator',
                c: 'map loop'
            },
            answer: 'c'
        },
        {
            id: 'Q2',
            question: 'Which of the following is an invalid in LWC Component folder?',
            options: {
                a: '.svg',
                b: '.apex',
                c: '.js'
            },
            answer: 'b'
        },
        {
            id: 'Q3',
            question: 'Which one of the follwoing is not a directive?',
            options: {
                a: 'for:each',
                b: 'if:true',
                c: '@track'
            },
            answer: 'c'
        }
    ]

    checkOption(event) {
        console.log('Event Name : ', event.target.name)
        console.log('Event Value : ', event.target.value)
        const { name, value } = event.target
        this.selected = {...this.selected, [name]: value }
        console.log(this.selected)
    }

    get allSelected() {
        return !(Object.keys(this.selected).length === this.quizItems.length)
    }

    get isFullScore() {
        return `slds-text-heading_large ${this.quizItems.length === this.score ? 'slds-text-color_success' : 'slds-text-color_error' }`
    }

    submitQuiz(event) {
        event.preventDefault()
        let scores = this.quizItems.filter(item => this.selected[item.id] === item.answer)
        this.score = scores.length
        this.isSubmitted = true
        console.log('You have scored : ', this.score)
    }
    resetQuiz(event) {
        this.selected = {}
        this.score = 0
        this.isSubmitted = false
    }
}