export const steps = (num) => {
    if (num <= 0) {
        throw new Error('Only positive numbers are allowed');
    }
    let steps = 0;
    while (num !== 1) {
        if (num % 2 === 0) {
            num /= 2;
        } else {
            num = 3 * num + 1;
        }
        ++steps;
    }
    return steps;
};
