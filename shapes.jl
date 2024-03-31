#=
Zaimplementuj struktury Punkt, Koło, Prostokąt opisujące leżące na płaszczyźnie figury o różnych kształtach, rozmiarach i położeniach. Dla każdej z figur zdefiniuj funkcje obliczające pola i obwody.
Dla każdej pary klas zdefiniuj funkcję odległość obliczającą odległość między nimi. Odległością figur A, B nazywamy długość najkrótszego odcinka którego jeden koniec należy do figury A a drugi koniec do figury B.
Następnie stwórz tablicę dwunastu figur położonych w pewnych odległościach od siebie i w jednej linijce skonstruuj macierz odległości między tymi figurami.
Dodatkowo dla każdej figury zdefiniuj funkcję rysuj(fig), która nanosi kontur figuryna istniejący wykres.  Użyj biblioteki ‘Plots‘.  Sprawdź na kilku przykładach czy twoje funkcje działają poprawnie.
=#

using Plots

struct Dot
    O::Complex #O.re -> oś x, O.im -> oś y
end
struct Rect
    O::Complex
    a::Real #szerokość
    b::Real #wysokość
end
struct Circ
    O::Complex
    r::Real #promień
end

dist(fig1::Dot, fig2::Dot) = hypot(fig1.O.re - fig2.O.re, fig1.O.im - fig2.O.im) #hypot(a,b)=sqrt(a^2+b^2)
dist(fig1::Circ, fig2::Dot) = max(hypot(fig1.O.re - fig2.O.re, fig1.O.im - fig2.O.im) - fig1.r, 0)
dist(fig1::Dot, fig2::Circ) = max(hypot(fig1.O.re - fig2.O.re, fig1.O.im - fig2.O.im) - fig2.r, 0)
dist(fig1::Circ, fig2::Circ) = max(hypot(fig1.O.re - fig2.O.re, fig1.O.im - fig2.O.im) - fig2.r - fig1.r, 0)

function dist(fig1::Rect, fig2::Dot)
    dx = fig2.O.re - fig1.O.re #odległość między współ. x Rect a współ. x Dot
    dy = fig2.O.im - fig1.O.im #jak wyżej dla współ. y
    if abs(dx) > fig1.a/2 #prawda gdy Dot jest poza "pasem" wyznaczanym przez lewy i prawy bok
        if abs(dy) > fig1.b/2 #jak wyżej dla "pasa" górnego i dolnego boku
            return hypot(abs(dx) - fig1.a/2, abs(dy) - fig1.b/2)
        else
            return abs(dx) - fig1.a/2
        end
    else
        if abs(dy) > fig1.b/2
            return abs(dy) - fig1.b/2
        else #prawdziwe tylko gdy Dot jest w środku Rect
            return 0
        end
    end
end
dist(fig1::Dot, fig2::Rect) = dist(fig2, fig1)

function dist(fig1::Rect, fig2::Circ) #podobnie jak dla pary Rect, Dot; w odpowiednich miejscach promień Circ
    dx = fig2.O.re - fig1.O.re
    dy = fig2.O.im - fig1.O.im
    if abs(dx) - fig2.r > fig1.a/2
        if abs(dy) - fig2.r > fig1.b/2
            return max(hypot(abs(dx) - fig1.a/2, abs(dy) - fig1.b/2) - fig2.r, 0)
        else
            return max(abs(dx) - fig1.a/2 - fig2.r, 0)
        end
    else
        if abs(dy) - fig2.r > fig1.b/2
            return max(abs(dy) - fig1.b/2 - fig2.r, 0)
        else
            return 0
        end
    end
end
dist(fig1::Circ, fig2::Rect) = dist(fig2, fig1)

function dist(fig1::Rect, fig2::Rect) #podobnie jak dla pary Rect, Dot; sprawdzane czy cały prostokąt nachodzi na "pasy"
    dx = fig2.O.re - fig1.O.re
    dy = fig2.O.im - fig1.O.im
    if abs(dx) - fig1.a/2 - fig2.a/2 > 0 
        if abs(dy) - fig1.b/2 - fig2.b/2 > 0
            return hypot(abs(dx) - fig1.a/2 - fig2.a/2, abs(dy) - fig1.b/2 - fig2.b/2)
        else
            return abs(dx) - fig1.a/2 - fig2.a/2
        end
    else
        if abs(dy) - fig1.b/2 - fig2.b/2 > 0
            return abs(dy) - fig1.b/2 - fig2.b/2
        else
            return 0
        end
    end
end

function circle(x, y, r; n=60) #pomocnicza funkcja tworząca koło
    θ = 0:360÷n:360
    Plots.Shape(r*sind.(θ) .+ x, r*cosd.(θ) .+ y)
end

rysuj(fig::Circ) = plot!(circle(fig.O.re,fig.O.im,fig.r))
rysuj(fig::Rect) = plot!(Shape([(fig.O.re - fig.a/2,fig.O.im - fig.b/2),(fig.O.re - fig.a/2, fig.O.im + fig.b/2),(fig.O.re + fig.a/2,fig.O.im + fig.b/2),(fig.O.re + fig.a/2, fig.O.im - fig.b/2)]))
rysuj(fig::Dot) = scatter!([fig.O.re],[fig.O.im])

area(fig::Dot) = 0
area(fig::Rect) = fig.a * fig.b
area(fig::Circ) = pi * fig.r^2

obwod(fig::Dot) = 0
obwod(fig::Circ) = 2 * pi * fig.r
obwod(fig::Rect) = 2 * fig.a + 2 * fig.b

figures = [ # tablica zawierająca figury
    Dot(0 + 0im), 
    Rect(1+2im, 4,2), 
    Circ(1 - 1im, 1), 
    Rect(-2.5 -2.5im, 1, 5), 
    Circ(-2 + 4im, 2), 
    Dot(0 + 6im), 
    Rect(1 - 4im, 2, 2), 
    Rect(3 + 0im, 2, 4), 
    Circ(5 + 4im, 1), 
    Dot(-3 + 1im), 
    Circ(-5 - 4im, 2), 
    Dot(3 - 3im)]

println([round(dist(a,b), digits=2) for a in figures, b in figures])

plot(size=(1000,1000), xlims=(-6,6), ylims=(-6,6)) #podstawowe parametry wykresu

for i in 1:length(figures)
    rysuj(figures[i])
    println(figures[i], ", pole: ", round(area(figures[i]),digits=3), ", obwód: ", round(obwod(figures[i]),digits=3))
end
plot!()
#
