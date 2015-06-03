'use strict';

var MIN = 1;

module.exports.for = function (num) {
    var factors = [],
        factor  = MIN + 1;

    if (num <= MIN) return factors;

    while (num > MIN) {
        while (num % factor !== 0) ++factor;
        factors.push(factor);
        num /= factor;
    }
    return factors;
};