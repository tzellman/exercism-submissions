'use strict';

function ArgumentError() {
    this.message = 'Invalid argument passed';
}
ArgumentError.prototype             = Object.create(Error.prototype);
ArgumentError.prototype.constructor = ArgumentError;

function WordProblem(problem) {
    this.problem = problem;
}

var handler = {
    'what is|\\?$': function () {
        // noop
    },

    // numbers, supporting pos/neg - parse it and potentially
    // * call the last operation, or
    // * 'push' it on as the result
    '[=-]?\\d+': function (context) {
        var value = +context.value;
        if (context.op) {
            context.op.call(null, context.result, value);
        } else {
            context.result = value;
        }
        delete context.op;
    },

    'plus': function (context) {
        context.op = function (v1, v2) {
            context.result = v1 + v2;
        }
    },

    'minus': function (context) {
        context.op = function (v1, v2) {
            context.result = v1 - v2;
        }
    },

    'multiplied by|times': function (context) {
        context.op = function (v1, v2) {
            context.result = v1 * v2;
        }
    },

    'divided by': function (context) {
        context.op = function (v1, v2) {
            context.result = v1 / v2;
        }
    }
};


WordProblem.prototype.answer = function () {
    var problem = this.problem.toLowerCase().trim(),
        index   = 0,
        context = {result: 0};

    while (Object.keys(handler).some(function (key) {
        // construct a regex that matches on the beginning of the string
        var regex = '^(' + key + ')\\s*',
            match = new RegExp(regex).exec(problem.substr(index));
        if (match) {
            // set the value into the context
            context.value = match[1];
            // call the handler method, passing the context
            handler[key].call(null, context);
            // update our index, which should always be 0 + total match length
            index += match.index + match[0].length;
            return true; //sentinel, end the iteration
        }
    }));

    // if we didn't hit the end of the input, it must be invalid
    if (index < problem.length - 1) {
        throw new ArgumentError(problem.substr(index));
    }
    return context.result;
};

module.exports.WordProblem   = WordProblem;
module.exports.ArgumentError = ArgumentError;
