'use strict';

// map the charcode to the full plant name
var PLANTS = 'grass clover radishes violets'.split(' ').reduce(function (map, plant) {
    map[plant.charAt(0)] = plant;
    return map;
}, Object.create(null));

// default children names
var CHILDREN = 'Alice Bob Charlie David Eve Fred Ginny Harriet Ileana Joseph Kincaid Larry'.split(' ')

var PLANTS_PER_CHILD_PER_ROW = 2;

function Garden(diagram, students) {
    var self = this,
        rows = diagram.split('\n');

    students = (students || CHILDREN).map(function (student) {
        student       = student.toLowerCase();
        self[student] = []; // set each child's plants to an empty array
        return student;
    }).sort();

    rows.forEach(function (row) {
        row.toLowerCase().split('').forEach(function (plantCode, i) {
            var student = students[Math.floor(i / PLANTS_PER_CHILD_PER_ROW)];
            self[student].push(PLANTS[plantCode]);
        });
    });
}

module.exports = Garden;
