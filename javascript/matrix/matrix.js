'use strict';

function Matrix(matrix) {
    var self     = this;
    this.rows    = [];
    this.columns = [];

    matrix.split('\n').forEach(function (rowString) {
        var row = rowString.trim().split(' ').map(function (val) {
            return +val;
        });
        self.rows.push(row);
        row.forEach(function (val, index) {
            if (self.columns.length == index) {
                self.columns.push([val]);
            } else {
                self.columns[index].push(val);
            }
        });
    });
}

module.exports = Matrix;
