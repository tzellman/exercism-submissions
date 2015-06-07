module.exports = function (input) {
    return (input || '').trim().split(/\s+/).reduce(function (map, p) {
        // an empty input string will still split to an array of size 1 empty string..
        if (p) {
            map[p] = map.hasOwnProperty(p) ? map[p] + 1 : 1;
        }
        return map;
    }, {});
};
