module.exports = function (old) {
    return Object.keys(old).reduce(function (map, key) {
        old[key].forEach(function (letter) {
            map[letter.toLowerCase()] = parseInt(key);
        });
        return map;
    }, {});
};
