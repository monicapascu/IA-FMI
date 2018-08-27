%proiect REALIZAREA DE MOZAICURI
%

%%
%seteaza parametri pentru functie

%citeste imaginea care va fi transformata in mozaic
%puteti inlocui numele imaginii
params.imgReferinta = imread('../data/imaginiTest/obama.jpeg');

%seteaza directorul cu imaginile folosite la realizarea mozaicului
%puteti inlocui numele directorului
params.numeDirector = '..\data\colectie';

params.tipImagine = 'png';

%seteaza numarul de piese ale mozaciului pe orizontala
%puteti inlocui aceasta valoare
params.numarPieseMozaicOrizontala = 100;
%numarul de piese ale mozaciului pe verticala va fi dedus automat

%seteaza optiunea de afisare a pieselor mozaicului dupa citirea lor din
%director
params.afiseazaPieseMozaic = 0;

%seteaza modul de aranjare a pieselor mozaicului
%optiuni: 'aleator','caroiaj' , 'hexagon'
params.modAranjare = 'caroiaj';

%seteaza criteriul dupa care realizeze mozaicul
%optiuni: 'aleator','distantaCuloareMedie'
params.criteriu = 'distantaCuloareMedie';

%%
%apeleaza functia principala
imgMozaic = construiesteMozaic(params);

imwrite(imgMozaic,'mozaic.jpg');
figure, imshow(imgMozaic);