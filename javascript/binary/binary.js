'use strict';

var Binary = function (input) {
    this.input = (input || '').trim();
};

Binary.prototype.toDecimal = function () {
    if (!/^[01]+$/.test(this.input)) {
        return 0;
    }
    return this.input.split('').reverse().reduce(function (accum, val, index) {
        return accum + (+val && Math.pow(2, index));
    }, 0);
};

module.exports = Binary;