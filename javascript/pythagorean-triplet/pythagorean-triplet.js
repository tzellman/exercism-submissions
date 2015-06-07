'use strict';

function Triplet() {
    this.numbers = Array.prototype.slice.call(arguments, 0, 3);
    if (this.numbers.length !== 3) throw new Error("Must pass in 3 numbers");
}

Triplet.prototype.product = function () {
    return this.numbers.reduce(function (product, number) {
        return product * number;
    }, 1);
};

Triplet.prototype.sum = function () {
    return this.numbers.reduce(function (sum, number) {
        return sum + number;
    }, 0);
};

Triplet.prototype.isPythagorean = function () {
    var sums = this.numbers.map(function (num) {
        return num * num;
    });
    return sums[0] + sums[1] === sums[2];
};

function Triplets(options) {
    options  = options || {};
    this.min = options.minFactor || 1;
    this.max = options.maxFactor || 1000;
    this.sum = options.sum;
}

Triplets.prototype.toArray = function () {
    var i, j, k,
        triplets = [],
        triplet;

    // naive, iterative approach - check all combinations
    for (i = this.min; i <= this.max - 2; ++i) {
        for (j = i + 1; j <= this.max - 1; ++j) {
            for (k = j + 1; k <= this.max; ++k) {
                triplet = new Triplet(i, j, k);
                if (triplet.isPythagorean() && (!this.sum || this.sum === triplet.sum())) {
                    triplets.push(triplet);
                }
            }
        }
    }
    return triplets;
};

Triplet.where = function (options) {
    return new Triplets(options).toArray();
};

module.exports = Triplet;
