// naive factors function...
function* findFactors(num) {
    for (let i = 1, half = num / 2; i <= half; ++i) {
        if (num % i === 0) {
            yield i;
        }
    }
}

export const classify = (num) => {
    if (num <= 0) {
        throw new Error(`Classification is only possible for natural numbers.`);
    }
    const factors = Array.from(findFactors(num));
    const sum = factors.reduce((acc, n) => n + acc, 0);
    if (sum === num) {
        return 'perfect';
    }
    if (sum > num) {
        return 'abundant';
    }
    return 'deficient';
};
