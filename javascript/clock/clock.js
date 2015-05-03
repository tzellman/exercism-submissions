/**
 * Pad a string
 * @param string
 * @param width
 * @param padding
 * @returns {string|*}
 */
function pad(string, width, padding) {
    padding = (padding || "0").charAt(0);
    string = string + "";
    return string.length >= width ? string : (new Array(width - string.length + 1).join(padding) + string);
}


function Clock(hour, minutes) {
    this.hour = hour || 0;
    this.minutes = minutes || 0;
}

/**
 * Add minutes to the clock
 * @param minutes
 * @returns {Clock}
 */
Clock.prototype.plus = function (minutes) {
    minutes += this.minutes;
    var hour = this.hour + (minutes >= 60 ? Math.floor(minutes / 60) : 0);
    this.hour = hour % 24;
    this.minutes = minutes % 60;
    return this;
};

/**
 * Subtract minutes from the clock
 * @param minutes
 * @returns {Clock}
 */
Clock.prototype.minus = function (minutes) {
    minutes = this.minutes - minutes;
    var hour = this.hour - (minutes < 0 ? Math.ceil(Math.abs(minutes / 60)) : 0);
    this.hour = hour > 0 ? hour % 24 : (24 + hour) % 24;
    this.minutes = minutes >= 0 ? (minutes % 60) : (60 - (Math.abs(minutes) % 60));
    return this;
};

Clock.prototype.toString = function () {
    return pad(this.hour, 2) + ":" + pad(this.minutes, 2);
};

Clock.prototype.equals = function (clock) {
    return this.hour === clock.hour && this.minutes === clock.minutes;
};


module.exports = {
    at: function (hour, minute) {
        return new Clock(hour, minute);
    }
};