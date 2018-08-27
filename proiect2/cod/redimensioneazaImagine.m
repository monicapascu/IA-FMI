function imgRedimensionata = redimensioneazaImagine(img,parametri)
%redimensioneaza imaginea
%
%input: img - imaginea initiala
%       parametri - stuctura de defineste modul in care face redimensionarea 
%
% output: imgRedimensionata - imaginea redimensionata obtinuta


optiuneRedimensionare = parametri.optiuneRedimensionare;
metodaSelectareDrum = parametri.metodaSelectareDrum;
ploteazaDrum = parametri.ploteazaDrum;
culoareDrum = parametri.culoareDrum;
factor = parametri.factor;

switch optiuneRedimensionare
    
    case 'micsoreazaLatime'
        numarPixeliLatime = parametri.numarPixeliLatime;
        imgRedimensionata = micsoreazaLatime(img,numarPixeliLatime,metodaSelectareDrum,...
            ploteazaDrum,culoareDrum);
        
    case 'micsoreazaInaltime'
        %completati aici codul vostru
        numarPixeliInaltime = parametri.numarPixeliInaltime;
        imgRedimensionata = micsoreazaInaltime(img,numarPixeliInaltime,metodaSelectareDrum,...
            ploteazaDrum,culoareDrum);
        
        
    case 'maresteLatime'
        %completati aici codul vostru
        numarPixeliLatime = parametri.numarPixeliLatime;
        imgRedimensionata = maresteLatime(img,numarPixeliLatime,metodaSelectareDrum,...
            ploteazaDrum,culoareDrum);
        
    case 'maresteInaltime'
        %completati aici codul vostru
        numarPixeliInaltime = parametri.numarPixeliInaltime;
        imgRedimensionata = maresteInaltime(img,numarPixeliInaltime,metodaSelectareDrum,...
            ploteazaDrum,culoareDrum);
        
    case 'amplificaContinut'
        %completati aici codul vostru
        imgRedimensionata = amplificaContinut(img,factor,metodaSelectareDrum,ploteazaDrum,culoareDrum);
        
    case 'eliminaObiect'
        %completati aici codul vostru
        imgRedimensionata = eliminaObiect(img,metodaSelectareDrum,ploteazaDrum,culoareDrum);
        
end