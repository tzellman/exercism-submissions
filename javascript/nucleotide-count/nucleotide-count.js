function dna(strand) {
    var hist = {};
    var validNucleotides = 'ACGT';
    strand = strand || "";

    // validate
    if (!new RegExp("^[" + validNucleotides + "]*$").test(strand)) {
        throw new Error("Invalid DNA strand");
    }

    validNucleotides.split('').forEach(function (nucleotide) {
        hist[nucleotide] = 0;
    });

    for (var i = 0; i < strand.length; ++i) {
        hist[strand[i]]++;
    }

    return {
        histogram: function () {
            return hist;
        },
        count: function (nucleotide) {
            return hist[nucleotide];
        }
    };
}

module.exports = dna;
