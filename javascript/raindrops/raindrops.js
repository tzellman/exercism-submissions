'use strict';

// I'm reusing the code from my prime-factors solution
var primeFactors = require('../prime-factors/prime-factors').for;

var Raindrops = function () {
};

var MAP = {
    3: 'Pling',
    5: 'Plang',
    7: 'Plong'
};

Raindrops.prototype.convert = function (num) {
    var factors = primeFactors(num);
    return Object.keys(MAP).reduce(function (result, key) {
            return result + (factors.indexOf(+key) >= 0 ? MAP[key] : '');
        }, '') || (num + '');
};

module.exports = Raindrops;