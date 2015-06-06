'use strict';

module.exports = function (range) {
    var arr   = new Array(range + 1),
        index = 2,
        multiple;
    for (; index <= range; ++index) {
        if (arr[index] === undefined) {
            arr[index] = index; // track primes by setting the value to itself (the index)
        }
        multiple = index * index;
        while (multiple <= range) {
            arr[multiple] = 0; // sentinel that it is not prime
            multiple += index;
        }
    }

    // knowing the primes is easy - filter the ones where index === value
    this.primes = arr.filter(function (val, i) {
        return val === i;
    });
};