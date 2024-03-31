#=
Napisz funkcję simpler, która będzie wprowadzać wyrażenia algebraiczne typu Expr do prostszej postaci. Wymagania:
  1. Funkcja powinna najpierw rekurencyjnie upraszczać podwyrażenia, liczby i symbole pozostają nie zmienione: simpler(a::Union{Number,Symbol})=a
  2. Wyrażenia, których argumentami są wyłącznie liczby, zastępowane są wyliczonąwartością, np :(1 + 2 + 4) => 7
  3. Z iloczynów usuwane są jedynki a z sum zera :(x + 0 + y) => :(x + y)
  4. Jeśli w iloczynie występuje 0 wynik jest zastępowany zerem :(x *  y  * 0) => 0
  5. Jeśli na skutek uproszczeń w iloczynie lub sumie został już tylko jeden argument to jest on wynikiem :(x + 0) -> :(+ x) => :x 
  6. Liczby występujące w sumach są do siebie dodawane a w iloczynach mnożone :(x + 3 + y + 5) => :(x + y + 8) oraz :(x * 3 * y * 5) => :(x * y * 15)
=#

function simpler(expr::Expr)
    args = [simpler(arg) for arg in expr.args]
    args2 = filter(arg -> arg != :*,filter(arg -> arg != :+, args))
    if all([isa(a, Number) for a in args2]) #wyliczanie samych liczb
        return eval(expr)
    elseif expr.args[1] == :+
        args = filter(arg -> arg != 0, args)
        if length(args) == 0
            return 0
        elseif length(args) == 1
            return args[1]
        elseif length(args) == 2
            return args[2]
        end
    elseif expr.args[1] == :*
        args = filter(arg -> arg != 1, args)
        if length(args) == 0 || (0 in args)
            return 0
        elseif length(args) == 1
            return args[1]
        elseif length(args) == 2
            return args[2]
        end
    end
    return Expr(expr.head, args...)
end

simpler(a::Number) = a
simpler(a::Symbol) = a
wyr = [
    :(x + 0 + y * 1),
    :((x + 0) * (z + u * 1)),
    :(((0 * x) * y) * z),
    :(1 + 2 + 3 + 4)]

for i in 1:length(wyr)
    println(wyr[i], " = ", simpler(wyr[i]))
end
