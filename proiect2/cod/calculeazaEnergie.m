function E = calculeazaEnergie(img)
%calculeaza energia la fiecare pixel pe baza gradientului
%input: img - imaginea initiala
%output: E - energia

%urmati urmatorii pasi:
%transformati imaginea in grayscale
%folositi un filtru sobel pentru a calcula gradientul in directia x si y
%calculati magnitudinea gradientului
%E - energia = gradientul imaginii

%completati aici codul vostru

if size(img,3) == 3
  img = rgb2gray(img);
end

Mx = [-1 0 1; -2 0 2; -1 0 1];
Ix = imfilter(double(img),Mx);
Iy = imfilter(double(img), Mx');
E = abs(Ix) + abs(Iy);
%E = uint8(E);

%[E,~] = imgradient(img,'sobel');
