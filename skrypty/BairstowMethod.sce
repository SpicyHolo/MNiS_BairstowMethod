clear;mode(0);clc;
//Funkcja wyswietla miejsca zerowe 
//W szcególności wartości zespolone
function printRoots(X)
    for n=1:1:max(size(X))
        if (isreal(X(n)))
            mprintf("x%u = %f\n",n,X(n));
        else
            mprintf("x%u = %f %+fi\n",n,real(X(n)),imag(X(n)));
            end  
    end
endfunction

//Funkcja znajduje miejsca zerowe r. kwadratowego
//wywoływana jest pod koniec programu, gdy wielomian
//jest zredukowany do trójmianu
function X = solveQuadratic(P)
    p = coeff(P);
    a = p(3)
    b = p(2)
    c = p(1)
    X(1) = (-b+sqrt(b.^2 - 4*a*c))/(2*a)
    X(2) = (-b-sqrt(b.^2 - 4*a*c))/(2*a)
endfunction
//Funkcja znajduje miejsca zerowe r. liniowego
//wywoływana jest pod koniec programu, gdy wielomian
//jest zredukowany do dwumianu
function X = solveLinear(P)
    p = coeff(P);
    a = p(2);
    b = p(1);
    X(1) = (-b/a);
endfunction
//Główna funkcja znajduje miejsca zerowe wielomianu metodą Bairstowa
//Przyjmuje poly oraz tolerancje błędu w zakresie od 0 do 1
function [X, Time] = BairstowMethod(P,tolerance)
    tic();
    order = degree(P);
    X = [] //Output
    //Pierwsza pętla w funkcji, sprawdza czy wielomian jest stopnia większego niż 2
    //Wartości początkowe r i s to współczynniki znormalizowanego wielomianu
    //stworzonego z 3 głównych współczynników wielomianu wejściowego
    while order > 2
        n = order+1;
        a = coeff(P);
        //Initial Guess
        r = a(n-1)/a(n)
        s = a(n-2)/a(n)
        
        //W pętli wyznaczane są wartości:
        //b(n) - współczynniki wielomianu będącego wynikiem 
        //dzielenia wejściowego przez x^2 - rx - s
        //c(n) - uzyskujemy dzieląc wielomian utworzony
        //z współczynników b(n) przez x^2 - rx - s
        //Pętla przerywa się, gdy zostanie osiągnieta tolerancja
        while 1==1
            n = order+1;
            //B
            b(n) = a(n);
            b(n-1) = a(n-1)+r*b(n)
            //C
            c(n) = b(n);
            c(n-1) = b(n-1)+r*c(n);
         
            for n = n-2:-1:1
                b(n) = a(n)+r*b(n+1)+s*b(n+2);
                c(n) = b(n) + r*c(n+1) + s*c(n+2);   
            end
            
            //Szukanie Δr, Δs 
            D = [c(3) c(4); c(2) c(3)]
            e = [b(2); b(1)];
            [delta] = linsolve(D,e);
            
            //Nowe wartości miejsc zerowych
            r = r + delta(1);
            s = s + delta(2);
            
            //Wyznaczanie błędu
            Err_r = abs(delta(1)/r)
            Err_s = abs(delta(2)/r);
            
            if(Err_s <= tolerance && Err_r <= tolerance)
                break; //Przerwij pętle po uzyskaniu tolerancji
            end
        end
        //Tworzymy wyznaczony trójmian
        Q = poly([-s -r 1], 'x', 'c');
		
        //Dodajemy wyznaczone miejsca zerowe do wektora rozwiązań
        X = [X; solveQuadratic(Q)];

        //Dzielimy wielomian wejściowy przez wyznaczony trójmian
        P = pdiv(P,Q);
        order = degree(P);
    end

    //Rozwiązanie wielomianu 2-go stopnia
    if(order == 2) then
        X = [X; solveQuadratic(P)];

    //Rozwiązanie wielomianu 1-go stopnia
    elseif(order == 1) then
        X = [X; solveLinear(P)];
    end    
    //Wyznaczenie czasu obliczeń [ms]
    Time = 1000*toc();
endfunction

