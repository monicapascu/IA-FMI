function img =  eliminaObiect(img,metodaSelectareDrum,ploteazaDrum,culoareDrum)

imshow(img);
[vertX,vertY] = ginput;
vertX = floor(vertX);
vertY = floor(vertY);
mask = poly2mask(vertX,vertY,size(img,1),size(img,2));


vertical_sum = sum(mask,1);
horizontal_length = sum(vertical_sum ~= 0);
horizontal_sum = sum(mask,2);
vertical_length = sum(horizontal_sum ~= 0);

pixels = sum(mask(:));

if (horizontal_length <= vertical_length)
    direction = 'vertical';
    
else
    direction = 'horizontal';
    
end
nr = 1;

switch direction
    case 'vertical'
        while(pixels ~=0)
            
            
            E = calculeazaEnergie(img) - 100000.*(double(mask));
            drum = selecteazaDrumVertical(E,metodaSelectareDrum);
            img = eliminaDrumVertical(img,drum);
            
            mask = eliminaDrumVertical(mask,drum);
            pixels = sum(mask(:));
            disp(['Eliminam drumul vertical numarul ' num2str(nr)]);
            nr = nr+1;
            if ploteazaDrum
                ploteazaDrumVertical(img,E,drum,culoareDrum);
                pause(1);
                close(gcf);
            end
            
        end
        
    case 'horizontal'
        
        img = rot90(img);
        
        mask = rot90(mask);
        while(pixels ~=0)
            
            E = calculeazaEnergie(img) - 100000.*(double(mask));
            drum = selecteazaDrumVertical(E,metodaSelectareDrum);
            img = eliminaDrumVertical(img,drum);
            
            mask = eliminaDrumVertical(mask,drum);
            pixels = sum(mask(:));
            disp(['Eliminam drumul orizontal numarul ' num2str(nr)]);
            nr = nr+1;
            
            if ploteazaDrum
                ploteazaDrumVertical(img,E,drum,culoareDrum);
                pause(1);
                close(gcf);
            end
        end
        
        img = rot90(img,3);
    otherwise
        warning('eroare');
end





