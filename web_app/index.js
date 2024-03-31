/*
Utwórz nowy folder, uruchom terminal wewnątrz i komendą npm init stwórz metadane Twojej aplikacji webowej. Wpisz nazwę aplikacji, swoje imię i nazwisko jako autora.
Plikiem startowym niech będzie index.js. Napisz używając tylko modułu http serwis o trzech podstronach, które się nawzajem do siebie odwołują.
W przypadku wpisania innego adresu url powinna się pokazywać informacja o błędzie 404.
Dodaj do serwisu dwa pliki (obrazek i dokument pdf), a odwołania do nich w znacznikach img oraz A zawrzyj na stronie głównej.
Zadbaj o to, by po wpisaniu ich nazw jako adresu url, Twój serwer wysyłał do klienta, odpowiedni nagłówek content-type, oraz odczytaną za pomocą fs.readFileSync() ich zawartość.
*/

const http = require('http');
const fs = require('fs');

const server = http.createServer((req, res) => {
  if (req.url === '/') {
    res.end(`
      <p>main</p>
      <a href="/obrazek.png">Obrazek png</a>
      <br>
      <a href="/dokument.pdf">Dokument PDF</a>
      <br>
      <a href="/p1">Podstrona 1</a>
      <a href="/p2">Podstrona 2</a>
      <a href="/p3">Podstrona 3</a>
    `);
  } else if (req.url == '/p1') {
    res.end(`
      <p>Podstrona 1</p>
      <a href="/">main</a>
    `);
  } else if (req.url == '/p2') {
    res.end(`
      <p>Podstrona 2</p>
      <a href="/">main</a>
    `);
  } else if (req.url == '/p3') {
    res.end(`
      <p>Podstrona 3</p>
      <a href="/">main</a>
    `);
  } else if (req.url == '/obrazek.png') {
    let img = fs.readFileSync('./obrazek.png');
    res.writeHead(200, { 'Content-Type': 'image/png' });
    res.end(img);
  } else if (req.url == '/dokument.pdf') {
    let pdf = fs.readFileSync('./dokument.pdf');
    res.writeHead(200, { 'Content-Type': 'application/pdf' });
    res.end(pdf);
  } else {
    res.writeHead(404);
    res.end(`
      <p>404, url nie istnieje</p>
      <a href="/">main</a>
    `);
  }
});

server.listen(8111);
console.log('localhost:8111');
