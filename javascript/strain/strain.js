'use strict';

// not using filter per the readme
var keep = module.exports.keep = function (arr, predicate) {
    arr = arr || [];
    return arr.reduce(function (kept, obj) {
        if (predicate.call(null, obj)) {
            kept.push(obj);
        }
        return kept;
    }, []);
};

// just reuse the keep method by wrapping and negating the predicate
module.exports.discard = function (arr, predicate) {
    return keep.call(null, arr, function (obj) {
        return !predicate.call(null, obj);
    });
};
