export const isPangram = (s) =>
    s
        .toLowerCase()
        .replace(/[^a-z]+/gi, '')
        .split('')
        .reduce((set, c) => {
            set.add(c);
            return set;
        }, new Set()).size === 26;
