//
// This is only a SKELETON file for the "Bob" exercise. It's been provided as a
// convenience to get you started writing code faster.
//

var Bob = function () {
};

var ANSWER_DEFAULT = 'Whatever.',
    ANSWER_QUESTION = 'Sure.',
    ANSWER_NOTHING = 'Fine. Be that way!',
    ANSWER_EXCLAIM = 'Whoa, chill out!';

Bob.prototype.hey = function (input) {
    input = input.trim();
    var answer = ANSWER_DEFAULT;
    if (!input) {
        answer = ANSWER_NOTHING;
    } else if (/[A-za-z]/g.exec(input) && input.toUpperCase() === input) {
        answer = ANSWER_EXCLAIM;
    } else if (/.*[?]$/g.exec(input)) {
        answer = ANSWER_QUESTION;
    }
    return answer;
};

module.exports = Bob;
