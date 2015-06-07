'use strict';

// doubly linked list
function LinkedList() {
    this.head = null;
    this.tail = null;
}

function Element(value) {
    this.value = value;
    this.prev  = null;
    this.next  = null;
}

LinkedList.prototype.push = function (object) {
    var node = new Element(object);
    if (this.tail) {
        this.tail.next = node;
        node.prev      = this.tail;
    } else {
        this.head = node;
    }
    this.tail = node;
};

LinkedList.prototype.unshift = function (object) {
    var node = new Element(object);
    if (this.head) {
        this.head.prev = node;
        node.next      = this.head;
    } else {
        this.tail = node;
    }
    this.head = node;
};

LinkedList.prototype.pop = function () {
    var value = undefined;
    if (this.tail) {
        value = this.tail.value;
        if (!this.tail.prev) {
            this.head = this.tail = null;
        } else {
            this.tail      = this.tail.prev;
            this.tail.next = null;
        }
    }
    return value;
};

LinkedList.prototype.shift = function () {
    var value = undefined;
    if (this.head) {
        value = this.head.value;
        if (!this.head.next) {
            this.head = this.tail = null;
        } else {
            this.head      = this.head.next;
            this.head.prev = null;
        }
    }
    return value;
};

LinkedList.prototype.count = function () {
    if (!this.head) return 0;
    var count = 1;
    var ptr   = this.head;
    while (ptr !== this.tail) {
        ptr = ptr.next;
        count++;
    }
    return count;
};

LinkedList.prototype.delete = function (object) {
    var ptr = this.head;
    while (ptr) {
        if (ptr.value === object) {
            if (ptr.next) {
                ptr.next.prev = ptr.prev;
            }
            if (ptr.prev) {
                ptr.prev.next = ptr.next;
            }
            if (this.head === ptr) {
                this.head = ptr.next;
            }
            if (this.tail === ptr) {
                this.tail = ptr.prev;
            }
            break;
        }
        ptr = ptr.next;
    }
};

module.exports = LinkedList;
