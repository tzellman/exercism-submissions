'use strict';

function bufferEmptyException() {
}
bufferEmptyException.prototype             = Object.create(Error.prototype);
bufferEmptyException.prototype.constructor = bufferEmptyException;

function bufferFullException() {
}
bufferFullException.prototype             = Object.create(Error.prototype);
bufferFullException.prototype.constructor = bufferFullException;

var CircularBuffer = function (capacity) {
    this.capacity = capacity;
    this.buf      = [];
};

CircularBuffer.prototype.read = function () {
    if (this.buf.length === 0) throw new bufferEmptyException();
    return this.buf.splice(0, 1)[0];
};

CircularBuffer.prototype.write = function (obj) {
    if (this.buf.length >= this.capacity) throw new bufferFullException();
    if (obj !== null && obj !== undefined) {
        this.buf.push(obj);
    }
    return this;
};

CircularBuffer.prototype.forceWrite = function (obj) {
    if (obj !== null && obj !== undefined) {
        if (this.buf.length >= this.capacity) {
            this.buf.splice(0, 1);
        }
        this.buf.push(obj);
    }
    return this;
};

CircularBuffer.prototype.clear = function (obj) {
    this.buf.splice(0, this.buf.length);
    return this;
};

module.exports = {
    bufferEmptyException: bufferEmptyException,
    bufferFullException : bufferFullException,
    circularBuffer      : function (capacity) {
        return new CircularBuffer(capacity);
    }
};