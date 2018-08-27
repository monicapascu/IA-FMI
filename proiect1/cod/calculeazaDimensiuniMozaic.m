function params = calculeazaDimensiuniMozaic(params)
%calculeaza dimensiunile mozaicului
%obtine si imaginea de referinta redimensionata avand aceleasi dimensiuni
%ca mozaicul

%completati codul Matlab
...

Imgs = dir([params.numeDirector '/*.' params.tipImagine]);
firstTile = imread([params.numeDirector '/' Imgs(1).name]);

[h1,w1,c1] = size(params.imgReferinta);
[H1,W1,C1] = size(firstTile);


  
% if( mod(newHeight,H1)~=0) newHeight= floor(newHeight/H1)*H1;



%calculeaza automat numarul de piese pe verticala
params.numarPieseMozaicVerticala =floor((h1*W1*params.numarPieseMozaicOrizontala)/(H1*w1));
params.imgReferintaRedimensionata = imresize(params.imgReferinta, [H1*params.numarPieseMozaicVerticala,W1*params.numarPieseMozaicOrizontala]);