var score = require('./scrabble-score');

describe('Scrabble', function() {
  it("scores an empty word as zero",function() {
    expect(score("")).toEqual(0);
  });

  it("scores a null as zero",function() {
    expect(score(null)).toEqual(0);
  });

  it("scores a very short word",function() {
    expect(score("a")).toEqual(1);
  });

  it("scores the word by the number of letters",function() {
    expect(score("street")).toEqual(6);
  });

  it("scores more complicated words with more",function() {
    expect(score("quirky")).toEqual(22);
  });

  it("scores case insensitive words",function() {
    expect(score("MULTIBILLIONAIRE")).toEqual(20);
  });
  it("scores double word multiplier",function() {
    expect(score("MULTIBILLIONAIRE", {wordMultiplier: 2})).toEqual(40);
  });
  it("scores triple word multiplier",function() {
    expect(score("MULTIBILLIONAIRE", {wordMultiplier: 3})).toEqual(60);
  });
  it("scores letter multiplier",function() {
    expect(score("at", {letterMultiplier: [1, 2]})).toEqual(3);
  });
});
