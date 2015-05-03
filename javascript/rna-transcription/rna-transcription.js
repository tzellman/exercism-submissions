var DNA_TO_RNA = {
    'G': 'C',
    'C': 'G',
    'T': 'A',
    'A': 'U'
};

function transcribe(strand) {
    var validNucleotides = Object.keys(DNA_TO_RNA).join('');
    strand = strand || "";

    // validate
    if (!new RegExp("^[" + validNucleotides + "]*$").test(strand)) {
        throw new Error("Invalid DNA strand");
    }

    var rna = "";
    for (var i = 0; i < strand.length; ++i) {
        rna += DNA_TO_RNA[strand[i]];
    }
    return rna;
}

module.exports = transcribe;
