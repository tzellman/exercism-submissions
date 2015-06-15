'use strict';

var BRACE       = '{',
    END_BRACE   = '}',
    BRACKET     = '[',
    END_BRACKET = ']',
    PAREN       = '(',
    END_PAREN   = ')';

function pushContext(arr) {
    arr = arr || [];
    arr.unshift([]);
    return arr;
}

function popContext(arr, emptyOk) {
    arr = arr || [];
    if (!emptyOk && arr.length <= 1) return false;
    if (arr[0].length) return false;
    arr.shift();
    return true;
}

module.exports = function (input) {
    var context = pushContext(), i, char;
    for (i = 0; i < input.length; ++i) {
        char = input.charAt(i);
        if (char === BRACE || char === BRACKET) {
            context[0].unshift(char);
        } else if (char === END_BRACE) {
            if (!context[0].length || context[0][0] !== BRACE) return false;
            context[0].shift();
        } else if (char === END_BRACKET) {
            if (!context[0].length || context[0][0] !== BRACKET) return false;
            context[0].shift();
        } else if (char === PAREN) {
            pushContext(context);
        } else if (char === END_PAREN) {
            if (!popContext(context)) return false;
        }
    }
    return popContext(context, true);
};
