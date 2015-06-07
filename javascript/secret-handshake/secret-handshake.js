'use strict';

var binary = require('../binary/binary');

var OPERATIONS = ['wink', 'double blink', 'close your eyes', 'jump'];

function SecretHandshake(number) {
    if (typeof(number) !== 'number') {
        throw new Error("Handshake must be a number");
    }
    this.number = number;
}

SecretHandshake.prototype.commands = function () {
    var self = this;
    // apply a bit-mask, based on the index of the operation
    var commands = OPERATIONS.filter(function (op, index) {
        return self.number & (1 << index);
    });
    // finally, reverse it if it matches the next binary step
    if (self.number & (1 << (OPERATIONS.length))) {
        commands.reverse();
    }
    return commands;
};

module.exports = SecretHandshake;
