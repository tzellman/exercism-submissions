export class ComplexNumber {
    constructor(real, imag) {
        this._real = real;
        this._imag = imag;
    }

    get real() {
        return this._real;
    }

    get imag() {
        return this._imag;
    }

    add(num) {
        if (!(num instanceof ComplexNumber)) {
            throw new Error(`Invalid input`);
        }
        this._real += num.real;
        this._imag += num.imag;
        return this;
    }

    sub(num) {
        if (!(num instanceof ComplexNumber)) {
            throw new Error(`Invalid input`);
        }
        this._real -= num.real;
        this._imag -= num.imag;
        return this;
    }

    div(num) {
        if (!(num instanceof ComplexNumber)) {
            throw new Error(`Invalid input`);
        }
        const { _real, _imag } = this;
        const divisor = num.real * num.real + num.imag * num.imag;
        this._real = (_real * num.real + _imag * num.imag) / divisor;
        this._imag = (_imag * num.real - _real * num.imag) / divisor;
        return this;
    }

    mul(num) {
        if (!(num instanceof ComplexNumber)) {
            throw new Error(`Invalid input`);
        }
        const { _real, _imag } = this;
        this._real = _real * num.real - _imag * num.imag;
        this._imag = _imag * num.real + _real * num.imag;
        return this;
    }

    get abs() {
        return Math.sqrt(this._real * this._real + this._imag * this._imag);
    }

    get conj() {
        return new ComplexNumber(this._real, this._imag !== 0 ? this._imag * -1 : this._imag);
    }

    get exp() {
        const realExp = Math.exp(this._real);
        return new ComplexNumber(realExp * Math.cos(this._imag), realExp * Math.sin(this._imag));
    }
}
