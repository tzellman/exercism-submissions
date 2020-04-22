export const parse = (phrase) =>
    phrase
        .split(/[\s-_]+/)
        .map((w) => w.charAt(0).toUpperCase())
        .join('');
