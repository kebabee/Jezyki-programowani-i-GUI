//W pierwszej kolejności definiuję funkcje służące do testów generatorów:
function wypisz(gen) {
    for (let x of gen) console.log(x);
}

function wypisz2(gen) {
    while (!(x = gen.next()).done) console.log(x.value);
}

function sklej(gen,glue) {
    let print = "";
    for (let x of gen) print += (x+glue);
    console.log(print);
}

function suma(gen) {
    let print = 0;
    for (let x of gen) print += x;
    console.log(print);
}

function iloczyn(gen) {
    let print = 1;
    for (let x of gen) print *= x;
    console.log(print);
}
//a) generetor dzielników liczby n
function* dzielniki(n) {
    for(let i = 1; i<=n; i++){
        if(n%i==0) yield i;
    }
}

//b)
function is_prime(n) { //funkcja sprawdzająca czy liczba jest pierwsza
    for(let i = 2; i < n; i++) {
        if(n % i == 0) return false; //jeśli zostanie znaleziony dzielnik j, funckja zwraca fałsz
    }
    return n > 1; //zgodnie z konwencją że 1 nie jest liczbą pierwszą
}

function* pierwsze(n) {
    for(let i = 1; i<=n; i++){
        if(is_prime(i)) {
            yield i;
        }
    }
}

//c)
function* rozkład(n) {
    let i = 2;
    while(i<=n) {
        if(n%i==0) {
            yield i;
            n=n/i; //n dzielone przez najmniejszy możliwy dzielnik
        } else {
            i++; //i zwiększane aż do "znalezienia" kolejnego dzielnika
        }
    }
}

console.log(`Testy funkcji dzielniki(n) dla n = 10\n${Array.from(dzielniki(10))}`);
wypisz(dzielniki(10));
wypisz2(dzielniki(10));
sklej(dzielniki(10),",");
suma(dzielniki(10));
iloczyn(dzielniki(10));

console.log(`\nTesty funkcji pierwsze(n) dla n = 15\n${Array.from(pierwsze(15))}`);
wypisz(pierwsze(15));
wypisz2(pierwsze(15));
sklej(pierwsze(15),",");
suma(pierwsze(15));
iloczyn(pierwsze(15));

console.log(`\nTesty funkcji rozkład(n) dla n = 60\n${Array.from(rozkład(60))}`);
wypisz(rozkład(60));
wypisz2(rozkład(60));
sklej(rozkład(60),",");
suma(rozkład(60));
iloczyn(rozkład(60));
