export class List {
    constructor(initialItems = undefined) {
        this.values = [];
        for (const item of initialItems || []) {
            if (item instanceof List) {
                this.append(item);
            } else {
                this.values.push(item);
            }
        }
    }

    append(list) {
        if (list instanceof List) {
            this.values.push(...list.values);
            return this;
        }
        throw new Error(`Invalid input`);
    }

    concat(...lists) {
        for (const list of lists) {
            if (!(list instanceof List)) {
                throw new Error(`Invalid input`);
            }
            this.append(list);
        }
        return this;
    }

    filter(cb) {
        const newList = new List();
        for (const value of this.values) {
            if (cb && cb.call(null, value)) {
                newList.values.push(value);
            }
        }
        return newList;
    }

    map(cb) {
        const newList = new List();
        for (const value of this.values) {
            if (cb) {
                newList.values.push(cb.call(null, value));
            }
        }
        return newList;
    }

    length() {
        return this.values.length;
    }

    foldl(cb, initial) {
        let accum = initial;
        for (const value of this.values) {
            if (cb) {
                accum = cb.call(null, accum, value);
            }
        }
        return accum;
    }

    foldr(cb, initial) {
        let accum = initial;
        for (let i = this.values.length - 1; i >= 0; --i) {
            if (cb) {
                accum = cb.call(null, accum, this.values[i]);
            }
        }
        return accum;
    }

    reverse() {
        this.values = this.foldl((arr, item) => {
            arr.unshift(item);
            return arr;
        }, []);
        return this;
    }
}
