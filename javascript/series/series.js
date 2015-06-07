'use strict';

function Series(str) {
    this.digits = str.replace(/[^\d]+/g, '').split('').map(function (s) {
        return +s;
    });
}

Series.prototype.slices = function (size) {
    if (size > this.digits.length) {
        throw new Error('Slice size is too big.');
    }
    var i, slices = [];
    for (i = 0; i <= this.digits.length - size; ++i) {
        slices.push(this.digits.slice(i, i + size));
    }
    return slices;
};

module.exports = Series;
