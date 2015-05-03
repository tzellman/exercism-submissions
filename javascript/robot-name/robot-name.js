function randomAlpha() {
    return String.fromCharCode("A".charCodeAt(0) + Math.floor(Math.random() * 26));
}
function randomDigit() {
    return Math.floor(Math.random() * 10);
}
function randomName() {
    return [
        randomAlpha(),
        randomAlpha(),
        randomDigit(),
        randomDigit(),
        randomDigit()
    ].join("");
}

function Robot() {
    this.name = randomName();
}

Robot.prototype.reset = function () {
    this.name = randomName();
};

module.exports = Robot;
