function formatString(s) {
    var args = Array.prototype.slice.call(arguments, 1);
    return s.replace(/{(\d+)}/g, function (match, number) {
        return typeof args[number] !== 'undefined' ? args[number] : match;
    });
}

var MAX_BOTTLES = 99;

function bottleString(num) {
    return num === 0 ? "No more" : num + "";
}

/**
 *
 * @param index 1-based index of verse
 * @returns {Array}
 */
function getVerse(index) {
    if (index < 0 || index > MAX_BOTTLES) {
        throw new Error("Invalid verse specified");
    }
    var bottleSuffix = index !== 1 ? "s" : "",
        numBottles = bottleString(index),
        nextNumBottles = bottleString(index - 1).toLowerCase(),
        nextBottleSuffix = (index - 1) !== 1 ? "s" : "",
        pronoun = index > 1 ? "one" : "it",
        lines = [];

    lines.push(formatString("{0} bottle{1} of beer on the wall, {2} bottle{1} of beer.", numBottles, bottleSuffix, numBottles.toLowerCase()));
    if (index > 0) {
        lines.push(formatString("Take {0} down and pass it around, {1} bottle{2} of beer on the wall.", pronoun, nextNumBottles, nextBottleSuffix));
    } else {
        lines.push(formatString("Go to the store and buy some more, {0} bottles of beer on the wall.", MAX_BOTTLES));
    }
    lines.push("");
    return lines;
}

/**
 *
 * @param fromIndex 1-based stating index
 * @param toIndex optional ending index, 1-based
 * @returns {Array}
 */
function sing(fromIndex, toIndex) {
    if (toIndex === undefined) {
        toIndex = 0;
    }
    var lines = [];
    for (var i = fromIndex; i >= toIndex; --i) {
        Array.prototype.push.apply(lines, getVerse(i));
    }
    return lines;
}

module.exports = {
    verse: function () {
        return getVerse.apply(this, arguments).join("\n");
    },
    sing: function () {
        return sing.apply(this, arguments).join("\n");
    }
};
