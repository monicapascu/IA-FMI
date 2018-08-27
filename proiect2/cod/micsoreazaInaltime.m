function img = micsoreazaInaltime(img,numarPixeliInaltime,metodaSelectareDrum,ploteazaDrum,culoareDrum)

img = rot90(img);

for i = 1:numarPixeliInaltime
    
    disp(['Eliminam drumul orizonat numarul ' num2str(i) ...
        ' dintr-un total de ' num2str(numarPixeliInaltime)]);
    
    
    E = calculeazaEnergie(img);
    
    
    drum = selecteazaDrumVertical(E,metodaSelectareDrum);
    
    
    if ploteazaDrum
        ploteazaDrumVertical(img,E,drum,culoareDrum);
        pause(1);
        close(gcf);
    end
    
    
    img = eliminaDrumVertical(img,drum);
    
end

img = rot90(img,3);