module.exports = function (input) {
    return (input || '').split(/\s+/).reduce(function (map, p) {
        map[p] = map.hasOwnProperty(p) ? map[p] + 1 : 1;
        return map;
    }, {});
};
