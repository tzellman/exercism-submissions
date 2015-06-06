'use strict';

module.exports.translate = function (sentence) {
    var words = sentence.replace(/\s+/g, ' ').toLowerCase().split(' ');
    return words.map(function (word) {

        // JS does not support negative lookbehind, so have to try several regexes
        // first regex checks for qu, since they must remain together
        // second regex matches for consonants up to the first vowel
        var translated = [/^([^aeiouq]*qu)(.*)$/, /^([^aeiou]+)(.*)$/].reduce(function (result, regex) {
            if (result) return result;
            var match = regex.exec(word);
            if (match) {
                result = match[2] + match[1];
            }
            return result;
        }, null);
        return (translated || word) + 'ay';
    }).join(' ');
};
