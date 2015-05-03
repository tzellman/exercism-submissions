module.exports = function (birthday) {
    var date = new Date(birthday.getTime() + Math.pow(10, 12));
    date = new Date(date.getFullYear(), date.getMonth(), date.getDate());
    return {
        date: function () {
            return date;
        }
    };
}