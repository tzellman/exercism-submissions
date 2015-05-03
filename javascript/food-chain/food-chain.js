function formatString(s) {
    var args = Array.prototype.slice.call(arguments, 1);
    return s.replace(/{(\d+)}/g, function (match, number) {
        return typeof args[number] !== 'undefined' ? args[number] : match;
    });
}

var SWALLOWED = [
    {what: "fly", statement: "I don't know why she swallowed the fly. Perhaps she'll die."},
    {
        what: "spider",
        statement: "It wriggled and jiggled and tickled inside her.",
        action: "wriggled and jiggled and tickled inside her"
    },
    {what: "bird", statement: "How absurd to swallow a bird!"},
    {what: "cat", statement: "Imagine that, to swallow a cat!"},
    {what: "dog", statement: "What a hog, to swallow a dog!"},
    {what: "goat", statement: "Just opened her throat and swallowed a goat!"},
    {what: "cow", statement: "I don't know how she swallowed a cow!"},
    {what: "horse", statement: "She's dead, of course!"}
];

/**
 *
 * @param index 1-based index of verse
 * @returns {Array}
 */
function getVerse(index) {
    if (--index < 0 || index >= SWALLOWED.length) {
        throw new Error("Invalid verse specified");
    }

    var swallowed = SWALLOWED[index],
        startsWithVowel = !!/^[aeiou]/i.exec(swallowed.what),
        lines = [];
    lines.push(formatString("I know an old lady who swallowed a{0} {1}.", startsWithVowel ? "n" : "", swallowed.what));
    lines.push(swallowed.statement);

    // sentinels are the first OR last verse
    while (index > 0 && index < (SWALLOWED.length - 1)) {
        var swallowedNext = SWALLOWED[index - 1];
        var action = swallowedNext.action ? formatString(" that {0}", swallowedNext.action) : "";
        var line = formatString("She swallowed the {0} to catch the {1}{2}.", swallowed.what, swallowedNext.what, action);
        lines.push(line);
        index--;
        swallowed = swallowedNext;

        if (index === 0) {
            lines.push(swallowed.statement);
        }
    }

    return lines;
}

/**
 *
 * @param fromIndex 1-based stating index
 * @param toIndex optional ending index, 1-based
 * @returns {Array}
 */
function getVerses(fromIndex, toIndex) {
    if (toIndex === undefined) {
        toIndex = fromIndex;
    }
    var lines = [];
    for (var i = fromIndex; i <= toIndex; ++i) {
        Array.prototype.push.apply(lines, getVerse(i));
        lines.push(""); // add a blank line after each verse
    }
    if (toIndex !== fromIndex) {
        lines.push(""); //extra blank line when fetching multiple verses
    }

    return lines;
}

module.exports = {
    verse: function () {
        return getVerses.apply(this, arguments).join("\n");
    },
    verses: function () {
        return getVerses.apply(this, arguments).join("\n");
    }
};
