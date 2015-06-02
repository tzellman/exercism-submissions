'use strict';
var HelloWorld = function () {
};

HelloWorld.prototype.hello = function (input) {
    return 'Hello, ' + (input || 'world') + '!';
};

module.exports = HelloWorld;
