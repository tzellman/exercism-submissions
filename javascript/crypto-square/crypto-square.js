'use strict';

// memoize, so we can cache results / compute once, and hide internal results
function memoize(cb) {
    var self = this, result;
    return function () {
        if (result === undefined) {
            result = cb.apply(self, arguments);
        }
        return result;
    }
}

// splits text into groups of max size, returning an array
function splitText(text, size) {
    var index = 0,
        arr   = [];
    for (; index < text.length; index += size) {
        arr.push(text.substr(index, size));
    }
    return arr;
}

// maps columns from an array of strings, up to size length each, returning an array
function columnMap(arr, size) {
    var index  = 0,
        groups = [];
    for (; index < size; ++index) {
        groups.push(arr.reduce(function (accum, str) {
            return accum + (index < str.length ? str.charAt(index) : '');
        }, ''));
    }
    return groups;
}


var Crypto = module.exports = function (msg) {
    this.raw = msg;
};

Crypto.prototype.normalizePlaintext = function () {
    return memoize.call(this, function () {
        return this.raw.toLowerCase().replace(/[^a-z\d]/gi, '');
    })();
};

Crypto.prototype.size = function () {
    return memoize.call(this, function () {
        return Math.ceil(Math.sqrt(this.normalizePlaintext().length));
    })();
};

Crypto.prototype.plaintextSegments = function () {
    return memoize.call(this, function () {
        return splitText(this.normalizePlaintext(), this.size());
    })();
};

Crypto.prototype.ciphertext = function () {
    return memoize.call(this, function () {
        return columnMap(this.plaintextSegments(), this.size()).join('');
    })();
};

Crypto.prototype.normalizeCiphertext = function () {
    return memoize.call(this, function () {
        return splitText(this.ciphertext(), this.size()).join(' ');
    })();
};
