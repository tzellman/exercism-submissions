'use strict';

function luhnAdd(digits) {
    return digits.map(function (digit, index) {
        if (index % 2 === 1) {
            digit *= 2;
        }
        return digit >= 10 ? digit - 9 : digit;
    }).reverse();
}

function sum(digits) {
    return digits.reduce(function (sum, digit) {
        return sum + digit;
    }, 0);
}

var Luhn = function (value) {
    this.stringized = ('' + value).replace(/\s+/g, '');
    var digits      = this.stringized.split('').reverse().map(function (d) {
        return +d;
    });
    this.checkDigit = digits[0];
    this.addends    = luhnAdd(digits);
    this.checksum   = sum(this.addends);
    this.valid      = this.checksum % 10 === 0;
};

Luhn.create = function (value) {
    var luhn = new Luhn(value);
    if (luhn.valid) {
        return value;
    }
    // lazy - iterate until we have a valid number
    var i = -1, valid = false;
    while (!valid) {
        valid = new Luhn(luhn.stringized + ++i).valid;
    }
    return +('' + value + i);
};

module.exports = Luhn;
