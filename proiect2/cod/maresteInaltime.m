function img = maresteInaltime(img,numarPixeliInaltime,metodaSelectareDrum,ploteazaDrum,culoareDrum)

img = rot90(img);
imgCopy = img;
drumuri = zeros(size(img,1),numarPixeliInaltime);
E = calculeazaEnergie(imgCopy);
for i = 1:numarPixeliInaltime
    
    %E = calculeazaEnergie(imgCopy);
    drum = selecteazaDrumVertical(E,metodaSelectareDrum);
    drumuri(:,i) = drum(:,2);
%   imgCopy = eliminaDrumVertical(imgCopy,drum);
    for j = 1: size(E,1)
       E(j,drum(j,2),:) = 255;
    end
   
end

for i = numarPixeliInaltime:-1:2
    drumuri(:,i:numarPixeliInaltime) = drumuri(:,i:numarPixeliInaltime) + ...
        (drumuri(:, i:numarPixeliInaltime) >= repmat(drumuri(:, i - 1), [1, numarPixeliInaltime - i + 1]));
end





for i = 1:numarPixeliInaltime
    
    disp(['Adaugam drumul orizontal numarul ' num2str(i) ...
        ' dintr-un total de ' num2str(numarPixeliInaltime)]);
    
    %calculeaza energia dupa ecuatia (1) din a1,rticol
    E = calculeazaEnergie(img);
    
    drum(:,2) = drumuri(:,i);
    
    
    
    %afiseaza drum
    if ploteazaDrum
        ploteazaDrumVertical(img,E,drum,culoareDrum);
        pause(1);
        close(gcf);
    end
    
    img = adaugaDrumVertical(img,drum);
    
end

img = rot90(img,3);