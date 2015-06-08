'use strict';

var code = String.prototype.charCodeAt,
    char = String.fromCharCode,
    min  = code.call('a', 0),
    max  = code.call('f', 0);

function getHexCharMap() {
    var charMap  = {},
        charCode = min,
        value    = 10;
    while (charCode <= max) {
        charMap[char(charCode++)] = value++;
    }
    return charMap;
}

var Hexadecimal = function (input) {
    this.input = (input || '').trim();
};

Hexadecimal.prototype.toDecimal = function () {
    var hexMap    = getHexCharMap(),
        multipler = 1;

    return /^[\d,a-f]+$/.test(this.input) ?
        this.input.split('').reverse().reduce(function (accum, val) {
            val        = /\d/.test(val) ? +val : hexMap[val];
            var result = accum + (val * multipler);
            multipler <<= 4; // bit-shift to next multiplier
            return result;
        }, 0) : 0;
};

module.exports = Hexadecimal;
