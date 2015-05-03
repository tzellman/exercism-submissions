/**
 * Returns a distinct array of elements
 * @param arr
 * @returns {Array}
 */
function distinctArray(arr) {
    return Object.keys(arr.reduce(function (map, len) {
        map[len] = true;
        return map;
    }, {}));
}

/**
 * @param sides
 * @throws Error if the sides violate the triangle inequality principle
 */
function validateSides(sides) {
    sides.sort();
    if (sides.length != 3 || sides[0] < 0 || (distinctArray(sides).length === 1 && sides[0] === 0)
        || ((sides[0] + sides[1] ) <= sides[2])) {
        throw new Error("Invalid lengths provided");
    }
}

// name -> # of distinct lengths
var TYPES = {
    equilateral: 1,
    isosceles: 2,
    scalene: 3
};

module.exports = function () {
    var sides = Array.prototype.slice.call(arguments, 0, 3);
    return {
        kind: function () {
            validateSides(sides);
            var uniqueSides = distinctArray(sides).length;
            return Object.keys(TYPES).reduce(function (current, type) {
                return current ? current : (TYPES[type] === uniqueSides ? type : null);
            }, null);
        }
    };
};