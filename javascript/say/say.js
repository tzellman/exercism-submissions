'use strict';

function makeMapping(power, max, label) {
    var divisor = Math.pow(10, power);
    return {
        max    : Math.pow(10, max) - 1,
        handler: function (value) {
            var result    = [],
                offset    = Math.floor(value / divisor),
                remainder = value % (offset * divisor);
            result.push(inEnglish(offset));
            result.push(label);
            if (remainder) {
                result.push(inEnglish(remainder));
            }
            return result.join(' ');
        }
    };
}

var MAPPING = [
    {
        max    : 9,
        values : 'zero one two three four five six seven eight nine'.split(' '),
        handler: function (value) {
            return this.values[value % 10];
        }
    },
    {
        max    : 19,
        values : 'ten eleven twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen'.split(' '),
        handler: function (value) {
            return this.values[value % 10];
        }
    },
    {
        max    : 99,
        values : 'twenty thirty forty fifty sixty seventy eighty ninety'.split(' '),
        handler: function (value) {
            var tens      = Math.floor(value / 10),
                remainder = value % (tens * 10);
            return this.values[tens - 2] + (remainder !== 0 ? '-' + inEnglish(remainder) : '');
        }
    },
    makeMapping(2, 3, "hundred"),
    makeMapping(3, 6, "thousand"),
    makeMapping(6, 9, "million"),
    makeMapping(9, 12, "billion")
];

var inEnglish = module.exports.inEnglish = function (number) {
    var i = 0, obj;
    for (; i < MAPPING.length; ++i) {
        obj = MAPPING[i];
        if (number <= obj.max) {
            return obj.handler(number);
        }
    }
    throw new Error('Number must be between 0 and 999,999,999,999.');
};
