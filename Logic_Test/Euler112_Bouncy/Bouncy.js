'use strict'

//Rober19 - 

let proportion = 0;
let bouncies = 0;
let limit = 99;
let number = 1;

while (true) {
  if (isBouncy(number)) {
    bouncies++;
  }
  let proportion = (bouncies / number) * 100;
  if (proportion == limit) {
    console.log(`El número mínimo para el cual la proporción\nde números bouncy es exactamente el ${limit}% es el ${number}`);
    break;
  }
  number++;
}

function isBouncy(number) {
  return !(isIncreasing(number) || isDecreasing(number));
}

function isIncreasing(number) {
  let digits = str_split(number);

  for (let i = 1; i < digits.length; i++) {
    if (digits[i] < digits[i - 1]) {
      return false;
    }
  }
  return true;
}

function isDecreasing(number) {
  let digits = str_split(number);

  for (let i = 1; i < digits.length; i++) {
    if (digits[i] > digits[i - 1]) {
      return false;
    }
  }

  return true;
}

function str_split(num) {
  let output = [];
  let sNumber = num.toString();

  for (var i = 0, len = sNumber.length; i < len; i += 1) {
    output.push(+sNumber.charAt(i));
  }
  return output;
}
