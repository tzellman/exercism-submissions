const COLORS = ['black', 'brown', 'red', 'orange', 'yellow', 'green', 'blue', 'violet', 'grey', 'white'];

export const decodedValue = (colors) =>
    parseInt(
        colors
            .slice(0, 2)
            .map((c) => c.toLowerCase())
            .map((c) => COLORS.indexOf(c))
            .join(''),
        10
    );
