'use strict';

var DAY_PREFIXES = 'Sun Mon Tues Wednes Thurs Fri Satur'.split(' ');

function findDate(dayOfWeek, startDate, lastOf) {
    return function () {
        var d          = new Date(this.year, this.month, startDate),
            firstDay   = d.getDay(),
            daysInWeek = DAY_PREFIXES.length,
            dayDiff    = dayOfWeek >= firstDay ? dayOfWeek - firstDay :
                (daysInWeek - firstDay + dayOfWeek);
        if (dayDiff) {
            d.setDate(d.getDate() + dayDiff);
        }
        if (lastOf) {
            while (new Date(this.year, this.month, d.getDate() + daysInWeek).getMonth() === this.month) {
                d.setDate(d.getDate() + daysInWeek);
            }
        }
        return d;
    }
}

function Meetup(month, year) {
    var self   = this instanceof Meetup ? this : Object.create(Meetup.prototype);
    self.month = month;
    self.year  = year;

    DAY_PREFIXES.forEach(function (prefix, dayOffset) {
        Meetup.prototype[prefix.toLowerCase() + 'teenth'] = findDate(dayOffset, 13);
        Meetup.prototype['first' + prefix + 'day']        = findDate(dayOffset, 1);
        Meetup.prototype['second' + prefix + 'day']       = findDate(dayOffset, 8);
        Meetup.prototype['third' + prefix + 'day']        = findDate(dayOffset, 15);
        Meetup.prototype['fourth' + prefix + 'day']       = findDate(dayOffset, 22);
        Meetup.prototype['last' + prefix + 'day']         = findDate(dayOffset, 22, true);
    });
    return self;
}

module.exports = Meetup;
