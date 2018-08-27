function imgMozaic = adaugaPieseMozaicPeCaroiaj(params)
%
%tratati si cazul in care imaginea de referinta este gri (are numai un canal)

imgMozaic = uint8(zeros(size(params.imgReferintaRedimensionata)));
[H,W,C,N] = size(params.pieseMozaic);
[h,w,c] = size(params.imgReferintaRedimensionata);
[h1,w1,c1] = size(params.imgReferinta);

img = params.imgReferintaRedimensionata;
nrTotalPiese = params.numarPieseMozaicOrizontala * params.numarPieseMozaicVerticala;
tilesValues = double(zeros(N,c));


switch(params.criteriu)
    case 'aleator'
        %pune o piese aleatoare in mozaic, nu tine cont de nimic
        
        nrPieseAdaugate = 0;
        for i =1:params.numarPieseMozaicVerticala
            for j=1:params.numarPieseMozaicOrizontala
                %alege un indice aleator din cele N
                indice = randi(N);    
                imgMozaic((i-1)*H+1:i*H,(j-1)*W+1:j*W,:) = params.pieseMozaic(:,:,:,indice);
                nrPieseAdaugate = nrPieseAdaugate+1;
                fprintf('Construim mozaic ... %2.2f%% \n',100*nrPieseAdaugate/nrTotalPiese);
            end
        end
        
    case 'distantaCuloareMedie'
        %completati codul Matlab
        nrPieseAdaugate = 0;
        
        for n = 1:N
            currentTile = params.pieseMozaic(:,:,:,n) ;
            if (c==1)
                currentTile = rgb2gray(currentTile);
            end
            
            for k = 1:c
                tilesValues(n,k) = mean2(currentTile(:,:,k));
            end
        end
        

        for y =1:params.numarPieseMozaicVerticala
            for x=1:params.numarPieseMozaicOrizontala
                % gasim sub-imaginea
 
                subImag = img((y-1)*H+1:y*H, (x-1)*W+1:x*W,:);
                
                subImagValues = zeros(1,c);
                for k=1:c
                    subImagValues(k) = mean2(subImag(:,:,k));
                end
                dist = zeros(N,1);
                for n = 1:N
                    dist(n) = sqrt(sum((subImagValues - tilesValues(n,:)).^2));
                end
                
                [minDist , match] = min(dist);
                
                if (y>1) && (x>1)
                    patch1 = imgMozaic((y-2)*H+1:(y-1)*H ,(x-1)*W+1:x*W,:);
                    piesa = params.pieseMozaic(:,:,:,match);
                    patch2 = imgMozaic((y-1)*H+1:y*H ,(x-2)*W+1:(x-1)*W ,:);
                  
                    if c==1
                        piesa = rgb2gray(piesa);
                        
                    end
                    while (patch1 == piesa) | (patch2 == piesa)
                        dist(match)=1000;
                        [minDist , match] = min(dist);
                        piesa = params.pieseMozaic(:,:,:,match);
                         if c==1
                        piesa = rgb2gray(piesa);
                        
                         end
                    end
                end
                
                    
                
                    if (y==1) && (x>1)
                        patch = imgMozaic((y-1)*H+1:y*H ,(x-2)*W+1:(x-1)*W ,:);
                        piesa = params.pieseMozaic(:,:,:,match);
                        if c == 1
                            piesa = rgb2gray(piesa);
                        end
                        if patch == piesa
                            dist(match)=1000;
                            [minDist , match] = min(dist);
                        end
                    end
                
                    if (x==1)&&(y>1)
                        patch = imgMozaic((y-2)*H+1:(y-1)*H ,(x-1)*W+1:x*W,:);
                        piesa = params.pieseMozaic(:,:,:,match);
                        if c == 1
                            piesa = rgb2gray(piesa);
                        end
                        if patch == piesa
                            dist(match)=1000;
                            [minDist , match] = min(dist);
                        end
                    end
                  

                match1 = params.pieseMozaic(:,:,:,match);
                if c==1
                    match1 = rgb2gray(match1);
                end
                imgMozaic((y-1)*H+1:y*H,(x-1)*W+1:x*W,:) = match1;
                nrPieseAdaugate = nrPieseAdaugate+1;
                fprintf('Construim mozaic ... %2.2f%%  \n',100*nrPieseAdaugate/nrTotalPiese);
   
            end
        end
       
    otherwise
        printf('EROARE, optiune necunoscut \n');
    
end
    
    
    
    
    
