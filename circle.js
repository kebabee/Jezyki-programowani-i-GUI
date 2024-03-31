/* 
Właściwości (properties).
Wzorując się na klasie:

class Kwadrat {
  constructor(a) { this.a = a; }
  get bok() { return this.a; }
  set bok(a) { this.a = a; }
  get obwód() { return 4 * this.a; }
  set obwód(len) { this.a = len / 4; }
  get pole() { return this.a * this.a; }
  set pole(P) { this.a = Math.sqrt(P); }
  toString() {return ‘a=${this.bok}\nL=${this.obwód}\nP=${this.pole}\n‘;}
}

let k = new Kwadrat(1);
k.bok = 12;
console.log(k+"");
k.obwód = 12;
console.log(k+"");
k.pole=12;
console.log(k+"");

Napisz klasę Koło z właściwościami promień, średnica, obwód, pole. Wewnętrznie jedyną prawdziwą daną ma być promień r, a pozostałe powinny być obliczane na jego podstawie.
Powinny być jednak możliwe przypisania:
var k=new Koło(3);   // Koło o promieniu 3
k.promień=8;         // zmienia promień na 8
k.średnica=10;       // zmienia promień ma 5
k.pole=4;            // zmienia promień na sqrt(4/Pi)
k.obwód=7;           // zmienia promień na 3.5/Pi

Napisz też funkcję demonstrującą, że wszystkie sety i gety działają poprawnie. Funkcja, powinna pokazywać stan wszystkich setów po każdym gecie z treści zadania.
Następnie utwórz tablicę zawierającą koła i kwadraty i oblicz w pętli ich łączne pole i obwód.
*/

class Kwadrat {
    constructor(a) { this.a = a; }
    get bok() { return this.a; }
    set bok(a) { this.a = a; }
    get obwód() { return 4 * this.a; }
    set obwód(len) { this.a = len / 4; }
    get pole() { return this.a * this.a; }
    set pole(P) { this.a = Math.sqrt(P); } 
    toString() {return `a=${this.bok}\nL=${this.obwód}\nP=${this.pole}\n`;}
}

class Koło {
    constructor(r) { this.r = r; }
    get promień() { return this.r; }
    set promień(r) { this.r = r; }
    get średnica() { return 2 * this.r; }
    set średnica(d) { this.r = d / 2; }
    get obwód() { return 2 * Math.PI * this.r; }
    set obwód(L) { this.r = L / (2 * Math.PI); }
    get pole() { return Math.PI * this.r * this.r; }
    set pole(P) { this.r = Math.sqrt(P / Math.PI); } 
    toString() {return `r=${this.promień}\nd=${this.średnica}\nL=${this.obwód}\nP=${this.pole}\n`;}
}

let k = new Koło(1);
function demo(a) { //argumentem a jest przypisanie wartości do wybranej właściwości
    a;
    console.log(k+"");
}
demo(k.promień=8);
demo(k.średnica=10);
demo(k.pole=4);
demo(k.obwód=7);

let ar=[new Koło(3), new Koło (5), new Kwadrat(4), new Kwadrat(6)];
let sumaP = 0;
let sumaL = 0;
for (let i = 0; i < ar.length; i++) {
    sumaP += ar[i].pole;
    sumaL += ar[i].obwód;
}
console.log(`Łączne pole: ${sumaP}\nŁączny obwód: ${sumaL}`);
