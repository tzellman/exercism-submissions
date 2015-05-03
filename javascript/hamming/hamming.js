function hammingDifference(s1, s2) {
    if (!s1 || !s2 || s1.length != s2.length) {
        throw new Error('DNA strands must be of equal length.');
    }
    return s1.split('').reduce(function (diff, char, i) {
        return diff + (char === s2[i] ? 0 : 1);
    }, 0);
}

module.exports = {
    compute: hammingDifference
};
