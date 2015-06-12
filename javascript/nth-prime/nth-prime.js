'use strict';

// currently, all tests finish on my machine in 0.022 seconds :)
module.exports.nth = function (nth) {
    // keep both a map and an array, for speed
    var primeMap   = {2: true},
        primes     = [2],
        maxChecked = 2;

    if (nth < 1) {
        throw new Error("Prime is not possible");
    }

    // checks the number if it is prime by attempting to divide the
    // previous prime numbers into it, up to it's square root
    // this means we can take advantage of previous work
    function checkPrime(num) {
        var i, prime,
            isPrime  = true,
            // only need to check up to the sqrt of the number
            maxCheck = Math.ceil(Math.sqrt(num));

        if (num === maxChecked + 1) {
            for (i = 0; isPrime && i < primes.length; ++i) {
                prime = primes[i];
                if (prime > maxCheck) break;
                isPrime = num % prime !== 0;
            }
            if (isPrime) {
                primeMap[num] = true;
                primes.push(num);
            }
            maxChecked++;
        }
        return primeMap[num] || false;
    }

    while (primes.length < nth) {
        checkPrime(maxChecked + 1);
    }
    return primes.slice(-1)[0];
};
