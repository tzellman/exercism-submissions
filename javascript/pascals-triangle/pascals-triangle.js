'use strict';

function Triangle(size) {
    var self = this instanceof Triangle ? this : Object.create(Triangle.prototype),
        i    = 1, j, row;

    self.rows    = [];
    self.lastRow = null;

    for (; i <= size; ++i) {
        if (!self.lastRow) {
            row = [i];
        } else {
            row = new Array(i);
            for (j = 0; j < i; ++j) {
                row[j] = (j > 0 ? self.lastRow[j - 1] : 0) + (j < i - 1 ? self.lastRow[j] : 0);
            }
        }
        self.rows.push(row);
        self.lastRow = row;
    }
}

module.exports = Triangle;
