'use strict';

const minCharCode = 'a'.charCodeAt(0);
const maxCharCode = 'z'.charCodeAt(0);

const group = (msg, size) =>
    msg
        .split('')
        .reduce((groups, c, index) => {
            if (index % size === 0) {
                groups.splice(0, null, '');
            }
            groups[0] += c;
            return groups;
        }, [])
        .reverse();

const cipher = (msg) =>
    msg
        .toLowerCase()
        .replace(/[^a-z0-9]/g, '')
        .split('')
        .map(function (c) {
            const charCode = c.charCodeAt(0);
            return charCode <= maxCharCode && charCode >= minCharCode
                ? String.fromCharCode(maxCharCode - charCode + minCharCode)
                : c;
        })
        .join('');

export const encode = (msg) => group(cipher(msg), 5).join(' ');
export const decode = (msg) => cipher(msg);
