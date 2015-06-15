'use strict';

// my initial thought is to use regexes to match
// not ideal, but that's the approach for now - keeps it fairly flexible/scalable

var CHAR_WIDTH    = 3,
    ROW_HEIGHT    = 4,
    ROW_SEPARATOR = ',',
    UNKNOWN       = '?',
    MAPPING       = {
        0: /\s_\s\|\s\|{2}_\|/,
        1: /\s{3}(\s{2}\|){2}/,
        2: /\s_\s{2}_\|{2}_\s/,
        3: /\s_\s{2}_\|\s_\|/,
        4: /\|_\|\s{2}\|/,
        5: /\s_\s\|_\s{2}_\|/,
        6: /\s_\s\|_\s\|_\|/,
        7: /\s_\s{3}\|\s{2}\|/,
        8: /\s_\s\|_\|{2}_\|/,
        9: /\s_\s\|_\|\s_\|/
    };

module.exports.convert = function (input) {
    // NOTE - could use some error checking...
    var lines        = input.split('\n'),
        charsPerLine = lines[0].length / CHAR_WIDTH,
        rows         = lines.reduce(function (arr, line, lineIndex) {
            var i = 0, j = 0, rowIndex = Math.floor(lineIndex / ROW_HEIGHT);
            if (arr.length === rowIndex) {
                arr.push([]);
            }
            for (; j < charsPerLine; ++j, i += CHAR_WIDTH) {
                if (j === arr[rowIndex].length) {
                    arr[rowIndex].push('');
                }
                arr[rowIndex][j] += line.substr(i, CHAR_WIDTH);
            }
            return arr;
        }, []);

    return rows.map(function (row) {
        return row.map(function (char) {
            var value;
            if (!Object.keys(MAPPING).some(function (k) {
                    value = k;
                    return MAPPING[k].test(char);
                })) {
                value = UNKNOWN;
            }
            return value;
        }).join('');
    }).join(ROW_SEPARATOR);
};
