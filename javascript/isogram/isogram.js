export const isIsogram = (text) => {
    const normalized = text
        .replace(/[\s-]+/g, '')
        .toLowerCase()
        .split('')
        .sort();
    let lastChar;
    let currentChar;
    while (normalized.length && (currentChar = normalized.shift()) !== lastChar) {
        lastChar = currentChar;
    }
    return normalized.length === 0;
};
