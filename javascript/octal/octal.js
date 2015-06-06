'use strict';

var Octal = function (input) {
    this.input = (input || '').trim();
};

Octal.prototype.toDecimal = function () {
    return /^[0-7]+$/.test(this.input) ?
        this.input.split('').reverse().reduce(function (accum, val, index) {
            return accum + (+val * Math.pow(8, index));
        }, 0) : 0;
};

module.exports = Octal;