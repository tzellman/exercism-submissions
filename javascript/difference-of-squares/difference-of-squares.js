'use strict';

function Squares(max) {
    var i = 1, sumOfSquares = 0, sum = 0;
    for (; i <= max; ++i) {
        sumOfSquares += (i * i);
        sum += i;
    }
    this.sumOfSquares = sumOfSquares;
    this.squareOfSums = sum * sum;
    this.difference   = Math.abs(this.sumOfSquares - this.squareOfSums);
}

module.exports = Squares;
