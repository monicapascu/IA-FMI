function d = selecteazaDrumVertical(E,metodaSelectareDrum)
%selecteaza drumul vertical ce minimizeaza functia cost calculate pe baza lui E
%
%input: E - energia la fiecare pixel calculata pe baza gradientului
%       metodaSelectareDrum - specifica metoda aleasa pentru selectarea drumului. Valori posibile:
%                           'aleator' - alege un drum aleator
%                           'greedy' - alege un drum utilizand metoda Greedy
%                           'programareDinamica' - alege un drum folosind metoda Programarii Dinamice
%
%output: d - drumul vertical ales

d = zeros(size(E,1),2);

switch metodaSelectareDrum
    case 'aleator'
        %pentru linia 1 alegem primul pixel in mod aleator
        linia = 1;
        %coloana o alegem intre 1 si size(E,2)
        coloana = randi(size(E,2));
        %punem in d linia si coloana coresponzatoare pixelului
        d(1,:) = [linia coloana];
        for i = 2:size(d,1)
            %alege urmatorul pixel pe baza vecinilor
            %linia este i
            linia = i;
            %coloana depinde de coloana pixelului anterior
            if d(i-1,2) == 1%pixelul este localizat la marginea din stanga
                %doua optiuni
                optiune = randi(2)-1;%genereaza 0 sau 1 cu probabilitati egale
            elseif d(i-1,2) == size(E,2)%pixelul este la marginea din dreapta
                %doua optiuni
                optiune = randi(2) - 2; %genereaza -1 sau 0
            else
                optiune = randi(3)-2; % genereaza -1, 0 sau 1
            end
            coloana = d(i-1,2) + optiune;%adun -1 sau 0 sau 1:
            % merg la stanga, dreapta sau stau pe loc
            d(i,:) = [linia coloana];
        end
    case 'greedy'
        %completati aici codul vostru
        [val,index] = min(E(1,:));
        d(1,2) = index;
        for i = 2 : size(E,1)
            if index == 1
                vecini = [E(i,index),E(i,index+1)];
                pozMinim = find(vecini==min(vecini),1);
                index = pozMinim;
                d(i,2) = index;
            else
                if index == size(E,2)
                    vecini = [E(i,end-1),E(i,index)];
                    pozMinim = find(vecini==min(vecini),1);
                    index = pozMinim + index - 2;
                    d(i,2) = index;
                else
                    vecini = [E(i,index-1),E(i,index),E(i,index+1)];
                    pozMinim = find(vecini==min(vecini),1);
                    index = pozMinim + index -2;
                    d(i,2) = index;
                end
            end
        end
        
      
    case 'programareDinamica'
        %completati aici codul vostru
        M = zeros(size(E));
        M(1,:) = E(1,:);
        for i = 2:size(M,1)
            for j = 1:size(M,2)
                if j == 1
                    M(i,j) = E(i,j) + min([M(i-1,j),M(i-1,j+1)]);
                else
                    if j == size(M,2)
                        M(i,j) = E(i,j) + min([M(i-1,j-1),M(i-1,j)]);
                    else
                        M(i,j) = E(i,j) + min([M(i-1,j-1),M(i-1,j),M(i-1,j+1)]);
                    end
                end
            end
        end
        
        ultimaLinie = M(end,:);
        coloana = find(ultimaLinie == min(ultimaLinie),1);
        
        d(size(M,1),:) = [size(M,1),coloana];
        
        for i = size(M,1)-1 : -1 : 1
            if coloana == 1
                v = [M(i,1) , M(i,2)];
                nouaColoana = find(v==min(v),1);
            else
                if coloana == size(M,2)
                    v = [M(i,end-1),M(i,end)];
                    pozMinim = find(v==min(v),1);
                    nouaColoana = coloana + pozMinim -2;
                else
                    v = [M(i,coloana-1),M(i,coloana),M(i,coloana+1)];
                    pozMinim = find (v==min(v),1);
                    nouaColoana = coloana + pozMinim -2;
                end
            end
            
            d(i,:) = [i,nouaColoana];
            coloana = nouaColoana;
        end
        
        
        
        
    otherwise
        error('Optiune pentru metodaSelectareDrum invalida');
end

end