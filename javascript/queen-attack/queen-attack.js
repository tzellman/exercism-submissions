'use strict';

var BOARD_SIZE = 8;

function Queens(options) {
    var self   = this instanceof Queens ? this : Object.create(Queens.prototype);
    options    = options || {};
    self.white = options.white || [0, 3];
    self.black = options.black || [7, 3];

    if (self.white[0] === self.black[0] && self.white[1] === self.black[1]) {
        throw "Queens cannot share the same space";
    }
    return self;
}

Queens.prototype.canAttack = function () {
    // same row, column or slope of 1 (diagonal)
    return this.white[0] === this.black[0] || this.white[1] === this.black[1] ||
        Math.abs((this.white[1] - this.black[1]) / (this.white[0] - this.black[0])) === 1;
};

Queens.prototype.toString = function () {
    var i, j, row, rows = [];
    for (i = 0; i < BOARD_SIZE; ++i) {
        row = [];
        for (j = 0; j < BOARD_SIZE; ++j) {
            if (this.white[0] === i && this.white[1] === j) {
                row.push('W');
            } else if (this.black[0] === i && this.black[1] === j) {
                row.push('B');
            } else {
                row.push('_');
            }
        }
        rows.push(row.join(' '));
    }
    return rows.join('\n') + '\n';
};

module.exports = Queens;
