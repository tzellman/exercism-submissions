'use strict';

var code = String.prototype.charCodeAt,
    char = String.fromCharCode,
    min  = code.call('a', 0),
    max  = code.call('z', 0);

function group(arr, size) {
    return arr.reduce(function (groups, c, index) {
        if (index % size === 0) {
            groups.splice(0, null, '');
        }
        groups[0] += c;
        return groups;
    }, []).reverse();
}

// commence golfing
module.exports.encode = function (msg) {
    return group(msg.toLowerCase().replace(/[^a-z0-9]/g, '').split('').map(function (c) {
        var charCode = code.call(c, 0);
        return charCode <= max && charCode >= min ? char(max - charCode + min) : c;
    }), 5).join(' ');
};
