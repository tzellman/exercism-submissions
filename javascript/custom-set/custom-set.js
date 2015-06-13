'use strict';

function Set(elements) {
    var self      = this instanceof Set ? this : Object.create(Set.prototype);
    self.elements = (elements || []).reduce(function (map, el) {
        map[el] = el;
        return map;
    }, Object.create(null));
}

Set.prototype.delete = function (object) {
    delete this.elements[object];
    return this;
};

Set.prototype.put = function (object) {
    this.elements[object] = object;
    return this;
};

Set.prototype.isEmpty = function () {
    return this.size() === 0;
};

Set.prototype.empty = function () {
    this.elements = [];
    return this;
};

Set.prototype.size = function () {
    return Object.keys(this.elements).length;
};

Set.prototype.member = function (object) {
    return this.elements[object] !== undefined;
};

Set.prototype.intersection = function (other) {
    return this.difference(this.difference(other));
};

Set.prototype.subset = function (other) {
    return this.intersection(other).size() === other.size();
};

Set.prototype.union = function (other) {
    other = other instanceof Set ? other : new Set(other);
    return new Set(this.toList().concat(other.toList()));
};

Set.prototype.toList = function () {
    var els = this.elements;
    return Object.keys(els).map(function (k) {
        return els[k];
    }).sort();
};

Set.prototype.disjoint = function (other) {
    other = other instanceof Set ? other : new Set(other);
    return !this.isEmpty() && !other.isEmpty() &&
        this.difference(other).size() === this.size() &&
        other.difference(this).size() === other.size();
};

Set.prototype.eql = function (other) {
    other = other instanceof Set ? other : new Set(other);
    return this.difference(other).isEmpty() && other.difference(this).isEmpty();
};

// do most of the work in the difference method - the other methods can just use this one
Set.prototype.difference = function (other) {
    other = other instanceof Set ? other : new Set(other);
    return new Set(this.toList().reduce(function (arr, k) {
        if (!other.member(k)) {
            arr.push(k);
        }
        return arr;
    }, []));
};

module.exports = Set;
