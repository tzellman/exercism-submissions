'use strict';

// mapping of what changes to make when in each bearing state
var BEARINGS = {
    north: {
        right  : 'east',
        left   : 'west',
        advance: [0, 1]
    },
    east : {
        right  : 'south',
        left   : 'north',
        advance: [1, 0]
    },
    south: {
        right  : 'west',
        left   : 'east',
        advance: [0, -1]
    },
    west : {
        right  : 'north',
        left   : 'south',
        advance: [-1, 0]
    }
};

function Robot() {
    this.coordinates = [0, 0];
    this.bearing     = 'north';
}

Robot.prototype.orient = function (direction) {
    if (!/east|west|north|south/.test(direction)) {
        throw "Invalid Robot Bearing"; // I normally would not throw strings..
    }
    this.bearing = direction;
    return this;
};

Robot.prototype.turnRight = function () {
    this.bearing = BEARINGS[this.bearing].right;
    return this;
};

Robot.prototype.turnLeft = function () {
    this.bearing = BEARINGS[this.bearing].left;
    return this;
};

Robot.prototype.at = function (/*x, y*/) {
    this.coordinates = Array.prototype.slice.call(arguments, 0, 2);
    return this;
};

Robot.prototype.place = function (options) {
    options = options || {};
    if (options.direction) {
        this.orient(options.direction);
    }
    var coords = this.coordinates;
    if (typeof(options.x) === 'number') {
        coords[0] = options.x;
    }
    if (typeof(options.y) === 'number') {
        coords[1] = options.y;
    }
    this.at.apply(this, coords);
    return this;
};

Robot.prototype.advance = function () {
    var move = BEARINGS[this.bearing].advance;
    this.coordinates[0] += move[0];
    this.coordinates[1] += move[1];
    return this;
};

var instructionMap = {
    r: 'turnRight',
    l: 'turnLeft',
    a: 'advance'
};

Robot.prototype.instructions = function (instructions) {
    return instructions.toLowerCase().trim().split('').reduce(function (arr, i) {
        if (instructionMap.hasOwnProperty(i)) {
            arr.push(instructionMap[i]);
        }
        return arr;
    }, []);
};

Robot.prototype.evaluate = function (instructions) {
    var self = this;
    this.instructions(instructions).forEach(function (instruction) {
        self[instruction].call(self);
    });
};

module.exports = Robot;
