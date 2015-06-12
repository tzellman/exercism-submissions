'use strict';

function Tree(value) {
    this.data  = value;
    this.right = null;
    this.left  = null;
}

Tree.prototype.insert = function (value) {
    var side = value <= this.data ? 'left' : 'right';
    if (this[side] === null) {
        this[side] = new Tree(value);
    } else {
        this[side].insert(value);
    }
};

Tree.prototype.each = function (cb) {
    if (this.left) {
        this.left.each(cb); // visit the left
    }
    cb.call(null, this.data); // visit itself
    if (this.right) {
        return this.right.each(cb); // visit the right
    }
};

module.exports = Tree;
