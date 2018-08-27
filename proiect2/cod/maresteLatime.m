function img = maresteLatime(img,numarPixeliLatime,metodaSelectareDrum,ploteazaDrum,culoareDrum)

imgCopy = img;
drumuri = zeros(size(img,1),numarPixeliLatime);
E = calculeazaEnergie(imgCopy);
for i = 1:numarPixeliLatime
    
  % E = calculeazaEnergie(imgCopy);
    drum = selecteazaDrumVertical(E,metodaSelectareDrum);
    drumuri(:,i) = drum(:,2);
%   imgCopy = eliminaDrumVertical(imgCopy,drum);
    for j = 1: size(E,1)
       E(j,drum(j,2),:) = 255;
    end
  
end

for i = numarPixeliLatime:-1:2
    drumuri(:,i:numarPixeliLatime) = drumuri(:,i:numarPixeliLatime) + ...
        (drumuri(:, i:numarPixeliLatime) >= repmat(drumuri(:, i - 1), [1, numarPixeliLatime - i + 1]));
end


for i = 1:numarPixeliLatime
    
    disp(['Adaugam drumul vertical numarul ' num2str(i) ...
        ' dintr-un total de ' num2str(numarPixeliLatime)]);
    
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
