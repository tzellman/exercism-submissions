'use strict';

var code    = String.prototype.charCodeAt,
    char    = String.fromCharCode,
    charMin = code.call('a', 0),
    charMax = code.call('z', 0),
    range   = charMax - charMin + 1;

function random(min, max) {
    return Math.random() * (max - min) + min;
}

function randomAlpha(size) {
    if (!size) {
        return char(random(charMin, charMax + 1));
    }
    var i = 0, chars = [];
    for (; i < size; ++i) {
        chars.push(randomAlpha());
    }
    return chars.join('');
}

var Cipher = function (key) {
    this.key = key === undefined ? randomAlpha(random(100, 200)) : key;
    if (!/^[a-z]+$/.test(this.key)) {
        throw new Error("Bad key");
    }
    this.keyCodes = this.key.split('').map(function (c) {
        return code.call(c);
    });
};

Cipher.prototype.encode = function (msg) {
    var self = this;
    return msg.split('').map(function (c, i) {
        return char(charMin + (self.keyCodes[i] - charMin + code.call(c) - charMin) % range);
    }).join('');
};

Cipher.prototype.decode = function (msg) {
    var self = this;
    return msg.split('').map(function (c, i) {
        var diff = code.call(c) - self.keyCodes[i];
        return char(diff < 0 ? charMax + diff + 1 : charMin + diff);
    }).join('');
};

module.exports = Cipher;