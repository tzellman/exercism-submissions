// my assumption here is that the easiest thing to do is sort every string first
// might not be the most performant, but makes sense to me..

function sortString(s) {
    return s.toLowerCase().split('').sort().join('');
}

module.exports = function (word) {
    var sortedWord = sortString(word);
    return {
        matches: function (possibilities) {
            if (typeof possibilities === "string") {
                possibilities = Array.prototype.slice.call(arguments);
            }
            return possibilities.filter(function (possibility) {
                return sortedWord === sortString(possibility) && word.toLowerCase() !== possibility.toLowerCase();
            });
        }
    };
};
