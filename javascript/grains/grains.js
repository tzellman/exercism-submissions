function Grains(max) {
    this.max = max || 64;
}

/**
 * @param index 1-based index of the square
 * @returns {number}
 */
Grains.prototype.square = function (index) {
    return Math.pow(2, index - 1);
};

Grains.prototype.total = function () {
    var total = 0;
    for (var i = 1; i <= this.max; ++i) {
        total += this.square(i);
    }
    return total;
};

module.exports = Grains;