function School() {
    this._grades = {};
}

School.prototype.add = function (name, grade) {
    if (this._grades[grade]) {
        this._grades[grade].push(name);
    } else {
        this._grades[grade] = [name];
    }
    this._grades[grade].sort(); //ammortized
    return this;
};

School.prototype.roster = function () {
    return this._grades;
};

School.prototype.grade = function (num) {
    return this._grades[num] || [];
};

module.exports = School;
