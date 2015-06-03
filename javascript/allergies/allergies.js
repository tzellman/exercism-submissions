'use strict';

var ALLERGENS = 'eggs peanuts shellfish strawberries tomatoes chocolate pollen cats'.split(' ').reverse();

var Allergies = function (score) {
    var maxValue = Math.pow(2, ALLERGENS.length),
        value    = maxValue;

    // rebase the score to remove untracked allergens within the 2's power scale
    while (score >= maxValue) {
        while (value < score) {
            value <<= 1;
        }
        value >>= 1;
        score -= value;
    }

    this.allergies = ALLERGENS.reduce(function (arr, allergen) {
        maxValue >>= 1;
        if (score >= maxValue) {
            score -= maxValue;
            arr.push(allergen);
        }
        return arr;
    }, []).reverse();
};

Allergies.prototype.list = function () {
    return this.allergies;
};

Allergies.prototype.allergicTo = function (something) {
    return this.allergies.indexOf((something || '').toLowerCase()) >= 0;
};

module.exports = Allergies;
