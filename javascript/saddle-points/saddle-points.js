'use strict';

function Matrix(values) {
    var self     = this instanceof Matrix ? this : Object.create(Matrix.prototype);
    self.columns = [];
    self.rows    = values.trim().split('\n').map(function (row) {
        return row.trim().split(' ').map(function (val, col) {
            val = +val;
            if (col === self.columns.length) {
                self.columns.push([val]);
            } else {
                self.columns[col].push(val);
            }
            return val;
        });
    });

    var rowMaxes = self.rows.map(function (row) {
        return Math.max.apply(null, row);
    });
    var colMins  = self.columns.map(function (col) {
        return Math.min.apply(null, col);
    });

    self.saddlePoints = self.rows.reduce(function (arr, row, i) {
        self.columns.forEach(function (col, j) {
            var val = row[j];
            if (val === rowMaxes[i] && val === colMins[j]) {
                arr.push([i, j]);
            }
        });
        return arr;
    }, []);
    return self;
}

module.exports = Matrix;
