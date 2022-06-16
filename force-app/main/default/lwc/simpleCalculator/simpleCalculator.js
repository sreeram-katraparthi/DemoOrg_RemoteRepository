import { LightningElement, track } from 'lwc';

export default class SimpleCalculator extends LightningElement {
  _firstNumber;
  _secondNumber;
  _operatorUsed;
  
  @track currentResult;

  /**
   * This method will be called when either first number or second number is changed
   * Accordingly it will set the firstNumber or secondNumber property in javascript
   * @param {} event 
   */
  onNumberChange(event) {
    //Getting input field name
    const inputFieldName = event.target.name;
    if (inputFieldName === "firstName") {
      //value of first number has changed, modifying the property value
      this.firstNumber = event.target.value;
    } else if(inputFieldName === "secondName") {
      //value of second number has changed, modifying the property value
      this.secondNumber = event.target.value;
    }
  } 

  /**
   * This method will be called when add button is clicked
   */
  onAdd() {
    this.currentResult = parseInt(this.firstNumber, 10) + parseInt(this.secondNumber, 10);
    this.operatorUsed = '+';
    //Check if both numbers are okay and operable 
  }
  /**
   * This method will be called when subtract button is clicked
   */
  onSub() {
    this.currentResult = parseInt(this.firstNumber, 10) - parseInt(this.secondNumber, 10);
    this.operatorUsed = '-';
    //Check if both numbers are okay and operable 
  }
  /**
   * This method will be called when multiply button is clicked
   */
  onMultiply() {
    this.currentResult = parseInt(this.firstNumber, 10) * parseInt(this.secondNumber, 10);
    this.operatorUsed = '*';
    //Check if both numbers are okay and operable 
  }
  /**
   * This method will be called when divide button is clicked
   */
  onDivide() {
    this.currentResult = parseInt(this.firstNumber, 10) / parseInt(this.secondNumber, 10);
    this.operatorUsed = '%';
    //Check if both numbers are okay and operable 
  }

  /**
   * Property getter
   * This method will automatically be automatically called when currentResult value
   * is changed. This getter method can be easily accessed in template using {result}
   */
  get result() {
    
    if(this.currentResult === 0 || this.currentResult){
      return `Result of ${this.firstNumber} ${this.operatorUsed} ${this.secondNumber} is ${this.currentResult}`;
    } 
      return '';    
  }
}