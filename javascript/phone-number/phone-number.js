function formatString(s) {
    var args = Array.prototype.slice.call(arguments, 1);
    return s.replace(/{(\d+)}/g, function (match, number) {
        return typeof args[number] !== 'undefined' ? args[number] : match;
    });
}

function PhoneNumber(number) {
    var match = /^(?:1(\d{10})|\(?(\d{3})\)?[. -]?(\d{3})[`. -]?(\d{4}))$/.exec(number);
    if (match) {
        this.digits = match[2] !== undefined ? [2, 3, 4].reduce(function (number, i) {
            return number + match[i];
        }.bind(this), "") : match[1];
    } else {
        this.digits = "0000000000";
    }
}

PhoneNumber.prototype.areaCode = function () {
    return this.digits.substr(0, 3);
};

PhoneNumber.prototype.number = function () {
    return this.digits;
};

PhoneNumber.prototype.toString = function () {
    return formatString("({0}) {1}-{2}", this.digits.substr(0, 3),
        this.digits.substr(3, 3), this.digits.substr(6, 4));
};

module.exports = PhoneNumber;
