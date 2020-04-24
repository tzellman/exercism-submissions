export class Rectangles {
    static count(rows) {
        let found = 0;
        // transform strings to a matrix
        const matrix = rows.map((row) => row.split(''));
        // find all vertex pairs per row, given by index pairs
        const vertexPairs = matrix.map(Rectangles.getVertexPairs);

        // try every row as a potential "top" of the rectangle
        vertexPairs.forEach((topPairs, topIndex) => {
            topPairs.forEach((topPair) => {
                // try every row below as a potential "bottom" for the top
                vertexPairs.slice(topIndex + 1).forEach((bottomPairs, bottomIndex) => {
                    bottomPairs.forEach((bottomPair) => {
                        // check to see if each corner matches
                        if (bottomPair[0] === topPair[0] && bottomPair[1] === topPair[1]) {
                            // check that we have columnar connectors
                            const rowSpans = matrix.slice(topIndex, topIndex + bottomIndex + 2);
                            // check if every connecting column is a plus (+) or pipe (|)
                            if (
                                bottomPair.every((cornerIndex) =>
                                    /^[+|]+$/.test(rowSpans.map((row) => row[cornerIndex]).join(''))
                                )
                            ) {
                                found++;
                            }
                        }
                    });
                });
            });
        });

        return found;
    }

    static getVertices(row) {
        return row.reduce((arr, c, i) => {
            if (c === '+') {
                arr.push(i);
            }
            return arr;
        }, []);
    }

    static getVertexPairs(row) {
        let vertices = Rectangles.getVertices(row);
        return vertices.reduce((arr, v, i) => {
            vertices.slice(i + 1).forEach((v2) => {
                // check these two are connected via a dash (-) or plus (+)
                if (/^[+-]+$/.test(row.slice(v, v2 + 1).join(''))) {
                    arr.push([v, v2]);
                }
            });
            return arr;
        }, []);
    }
}
