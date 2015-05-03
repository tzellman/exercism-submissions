var LETTER_SCORE = {};
var SCORES = {
    "AEIOULNRST": 1,
    "DG": 2,
    "BCMP": 3,
    "FHVWY": 4,
    "K": 5,
    "JX": 8,
    "QZ": 10
};

Object.keys(SCORES).forEach(function (k) {
    k.split('').forEach(function (l) {
        LETTER_SCORE[l] = SCORES[k];
    });
});

/**
 * Score a scrabble word
 * @param word
 * @param options optional parameters to support actual scrabble scoring
 * @param options.letterMultiplier  array of letter multipliers, 1 per letter
 * @param options.wordMultiplier    total word multiplier (e.g. 2)
 * @returns the score for the word
 */
module.exports = function (word, options) {
    options = options || {};
    var letterMultipler = options.letterMultiplier || [];
    var score = (word || '').split('').reduce(function (total, letter, i) {
        return total + (LETTER_SCORE[letter.toUpperCase()] * (letterMultipler[i] || 1));
    }, 0);
    score *= (options.wordMultiplier || 1);
    return score;
};