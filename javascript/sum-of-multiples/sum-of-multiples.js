'use strict';

var DEFAULT_MULTIPLES = [3, 5];

function SumOfMultiples(multiples) {
    var self       = this instanceof SumOfMultiples ? this : Object.create(SumOfMultiples.prototype);
    self.multiples = multiples || DEFAULT_MULTIPLES;
    return self;
}

SumOfMultiples.prototype.to = function (upTo) {
    var passed = [], i;

    function isMultiple(num, mult) {
        return num % mult === 0;
    }

    for (i = 0; i < upTo; ++i) {
        if (this.multiples.some(isMultiple.bind(null, i))) {
            passed.push(i);
        }
    }
    return passed.reduce(function (sum, num) {
        return sum + num;
    }, 0);
};

module.exports = SumOfMultiples;
