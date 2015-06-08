'use strict';

// subclass the existing Series I already wrote
var Series = require('../series/series');

function LargestSeries(str) {
    Series.call(this, str);
}

LargestSeries.prototype.constructor    = LargestSeries;
LargestSeries.prototype                = Object.create(Series.prototype);
LargestSeries.prototype.largestProduct = function (size) {
    return this.slices(size).reduce(function (max, slice) {
        var sliceProduct = slice.reduce(function (product, num) {
            return product * num;
        }, 1);
        return max > sliceProduct ? max : sliceProduct;
    }, 0);
};

module.exports = LargestSeries;
