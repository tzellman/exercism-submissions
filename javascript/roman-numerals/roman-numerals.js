'use strict';

var MAP = {1000: 'M', 500: 'D', 100: 'C', 50: 'L', 10: 'X', 5: 'V', 1: 'I'};

// just returns a new string, repeating the input string num times, or empty if num <= 0
function repeat(string, num) {
    return num > 0 ? new Array(num + 1).join(string) : '';
}

module.exports = function (num) {
    var roman   = '',
        current = 1000,
        next;

    // the logic is pretty simple:
    // 1. while the number is > the current check, add it's roman value
    // 2. if the number is > (our current check minus the next lower increment), deal with cases like IV and IX
    // Note that I decrement the passed value - until it eventually is 0 and we're done
    function check(val, increment) {
        while (num >= val) {
            roman += MAP[val];
            num -= val;
        }
        if (num && num >= val - increment) {
            roman += MAP[increment] + MAP[val];
            num -= (val - increment);
        }
    }

    while (current) {
        // compute the next 10s increment
        next = Math.floor(current / 10);
        check(current, next);
        // now, check the 10s midpoint
        check(current / 2, next);
        // set current to next, until we get to 0
        current = next;
    }
    return roman;
};