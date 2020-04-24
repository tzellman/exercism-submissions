// the strategy here is as follows:
// 1. find the row with the maximum width
// 2. "square" the transpose, padding where necessary
// 3. ending padding is removed
//
// Note that I use a non-space padding pattern so input spaces are preserved
//
// This only  requires looping through the rows twice, and the transpose once

const PADDING = '💩';
export const transpose = (rows) => {
    // find the max width and its index
    const maxWidth = rows.reduce((max, row) => (row.length > max ? row.length : max), 0);

    const cols = [];
    const appendToCol = (index, value) => {
        if (cols.length <= index) {
            cols[index] = [value];
        } else {
            cols[index].push(value);
        }
    };

    // transpose and square w/padding
    rows.forEach((row) => {
        row.split('').forEach((value, index) => appendToCol(index, value));
        let pad = row.length;
        while (pad < maxWidth) {
            appendToCol(pad++, PADDING);
        }
    });

    // transform to strings and remove ending padding
    return cols.map((col) =>
        col
            .join('')
            .replace(new RegExp(`(${PADDING})+$`), '')
            .replace(new RegExp(PADDING, 'g'), ' ')
    );
};
