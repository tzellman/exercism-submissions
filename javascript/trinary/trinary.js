'use strict';

var Trinary = function (input) {
    this.input = (input || '').trim();
};

Trinary.prototype.toDecimal = function () {
    return /^[012]+$/.test(this.input) ?
        this.input.split('').reverse().reduce(function (accum, val, index) {
            return accum + (+val * Math.pow(3, index));
        }, 0) : 0;
};

module.exports = Trinary;