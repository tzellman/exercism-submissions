'use strict';

// can't use map,reduce,etc per readme
module.exports = function (arr, transform) {
    arr         = arr || [];
    var results = [], i = 0;
    for (; i < arr.length; ++i) {
        results.push(transform ? transform.call(null, arr[i]) : arr[i]);
    }
    return results;
};
