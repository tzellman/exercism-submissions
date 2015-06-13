'use strict';

function Palindromes(options) {
    var self     = this instanceof Palindromes ? this : Object.create(Palindromes.prototype);
    self.options = options || {};
}

function isPalindrome(num) {
    var numString = ('' + num);
    // there are surely some optimizations that could be made, but this is the naive approach
    return numString === (numString.split('').reverse().join(''));
}

function addIfUnique(arr, i, j) {
    var val = [i, j].sort();
    if (!arr.some(function (tuple) {
            return tuple[0] === val[0] && tuple[1] === val[1];
        })) {
        arr.push(val);
    }
}

Palindromes.prototype.generate = function () {
    var minFactor = this.options.minFactor || 1,
        maxFactor = this.options.maxFactor || 1,
        i         = minFactor,
        j         = minFactor, product,
        pals      = Object.create(null);

    this.palindromes = pals;

    // trying to reduce the amount of multiplies
    for (; i <= maxFactor; ++i) {
        for (j = minFactor, product = i * j; j <= maxFactor; ++j, product += i) {
            if (isPalindrome(product)) {
                if (!pals[product]) {
                    pals[product] = [];
                }
                addIfUnique(pals[product], i, j);
                // keep track of largest/smallest so we don't have to sort later
                pals.largest  = pals.largest !== undefined ? Math.max(pals.largest, product) : product;
                pals.smallest = pals.smallest !== undefined ? Math.min(pals.smallest, product) : product;
            }
        }
    }
    return this;
};

Palindromes.prototype.largest = function () {
    if (!this.palindromes) throw new Error("You must generate the palindromes first");
    return {value: this.palindromes.largest, factors: this.palindromes[this.palindromes.largest]};
};

Palindromes.prototype.smallest = function () {
    if (!this.palindromes) throw new Error("You must generate the palindromes first");
    return {value: this.palindromes.smallest, factors: this.palindromes[this.palindromes.smallest]};
};

module.exports = Palindromes;
