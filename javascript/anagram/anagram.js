// my assumption here is that the easiest thing to do is sort every string first
// might not be the most performant, but makes sense to me..

const sortString = (s) => s.toLowerCase().split('').sort().join('');

export const findAnagrams = (word, possibilities) => {
    const sortedWord = sortString(word);
    return possibilities.filter(function (possibility) {
        return sortedWord === sortString(possibility) && word.toLowerCase() !== possibility.toLowerCase();
    });
};
