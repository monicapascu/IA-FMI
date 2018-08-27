function [descriptoriHOG, patches] = calculeazaHistogrameGradientiOrientati(img,puncte,dimensiuneCelula)
% calculeaza pentru fiecare punct histograma de gradienti orientati
% corespunzatoare dupa cum urmeaza:
%  - considera cele 16 celule inconjuratoare si calculeaza pentru fiecare
%  celula histograma de gradienti orientati de dimensiune 8;
%  - concateneaza cele 16 histograme de dimeniune 8 intr-un descriptor de
%  lungime 128 = 16*8;
%  - fiecare celula are dimensiunea dimensiuneCelula x dimensiuneCelula (4x4 pixeli)
%
% Input:
%       img - imaginea input
%    puncte - puncte de pe caroiaj pentru care calculam histograma de
%             gradienti orientati
%   dimensiuneCelula - defineste cat de mare este celula
%                    - fiecare celula este un patrat continand
%                      dimensiuneCelula x dimensiuneCelula pixeli
% Ouptut:
%        descriptoriHOG - matrice #Puncte X 128
%                       - fiecare linie contine histograme de gradienti
%                        orientati calculata pentru fiecare punct de pe
%                        caroiaj
%               patches - matrice #Puncte X (16 * dimeniuneCelula^2)
%                       - fiecare linie contine pixelii din cele 16 celule
%                         considerati pe coloana

nBins = 8; %dimeniunea histogramelor fiecarei celule

descriptoriHOG = zeros(0,nBins*4*4); % fiecare linie reprezinta concatenarea celor 16 histograme corespunzatoare fiecarei celule
patches = zeros(0,4*dimensiuneCelula*4*dimensiuneCelula); % 


if size(img,3)==3
    img = rgb2gray(img);
end
img = double(img);

f = [-1 0 1];
Ix = imfilter(img,f,'replicate');
Iy = imfilter(img,f','replicate');

orientare = atand(Ix./(Iy+eps)); %unghiuri intre -90 si 90 grade
orientare = orientare + 90; %unghiuri in intervalul (0,180)

numarCeluleY = 4;
numarCeluleX = 4;

lengthInterval = 180/nBins;
binCenters = lengthInterval/2:lengthInterval:180-lengthInterval/2;
for i = 1:size(puncte,1) % pentru fiecare punct
    y = puncte(i,1);
    x = puncte(i,2);
    patch = img(y-7:y+8,x-8:x+7);
    orientarePatch = orientare(y-7:y+8,x-8:x+7);
    %magnitudinePatch = magnitudine(y-7:y+8,x-8:x+7);
    dimCelula = dimensiuneCelula;
    contor = 0;
    for yC = 0:numarCeluleY-1
        for xC = 0:numarCeluleX-1
            contor = contor + 1;
            orientareCelula = orientarePatch(dimCelula*yC+1:dimCelula*(yC+1), dimCelula*xC+1:dimCelula*(xC+1));
            histogramaPatch(contor,:) = hist(orientareCelula(:),binCenters);
        end
    end
    descriptoriHOG(i,:) = reshape(histogramaPatch,1,128);
    patches(i,:) = patch(:)';%reshape(patch(:),1,4*dimensiuneCelula*4*dimensiuneCelula);
end

end
