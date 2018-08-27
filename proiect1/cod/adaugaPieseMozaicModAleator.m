function imgMozaic = adaugaPieseMozaicModAleator(params)
%
%tratati si cazul in care imaginea de referinta este gri (are numai un canal)

imgMozaic = uint8(zeros(size(params.imgReferintaRedimensionata)));
[H,W,C,N] = size(params.pieseMozaic);
[h,w,c] = size(params.imgReferintaRedimensionata);
[h1,w1,c1] = size(params.imgReferinta);

img = params.imgReferintaRedimensionata;
nrTotalPiese = (h-H)*(w-W);
tilesValues = double(zeros(N,c));



switch(params.criteriu)
    case 'aleator'
        %pune o piese aleatoare in mozaic, nu tine cont de nimic
        nrPieseAdaugate = 0;
        nrTotalPiese = (h-H)*(w-W);
        aleator = zeros(h-H,w-W);
        
        while (nrPieseAdaugate ~= nrTotalPiese)
            y = randi(h-H);
            x = randi(w-W);
            if aleator(y,x) == 0
                match = randi(N);
                match1 = params.pieseMozaic(:,:,:,match);
                if c==1
                    match1 = rgb2gray(match1);
                end
                imgMozaic(y:y+H-1, x:x+W-1, :) = match1;
                aleator(y,x) = 1;
                nrPieseAdaugate = nrPieseAdaugate+1;
                fprintf('Construim mozaic ... %2.2f%% \n',100*nrPieseAdaugate/nrTotalPiese);
            end
        end
        
        
        
        
    case 'distantaCuloareMedie'
        %completati codul Matlab
        nrPieseAdaugate = 0;
        nrTotalPiese = (h-H)*(w-W);
        aleator = zeros(h-H,w-W);
        
        for n = 1:N
            currentTile = params.pieseMozaic(:,:,:,n) ;
            if (c==1)
                currentTile = rgb2gray(currentTile);
            end
            
            for k = 1:c
                tilesValues(n,k) = mean2(currentTile(:,:,k));
            end
        end
        
        while (nrPieseAdaugate ~= nrTotalPiese)
            y = randi(h-H);
            x = randi(w-W);
            if aleator(y,x) == 0
                subImag = img(y:y+H-1,x:x+W-1, :);
                subImagValues = zeros(1,c);
                for k=1:c
                    subImagValues(k) = mean2(subImag(:,:,k));
                end
                dist = zeros(N,1);
                for n = 1:N
                    dist(n) = sqrt(sum((subImagValues - tilesValues(n,:)).^2));
                end
                
                [minDist , match] = min(dist);
                window = imgMozaic(y:y+H-1,x:x+W-1, :);
                match1 = params.pieseMozaic(:,:,:,match);
                if c==1
                    match1 = rgb2gray(match1);
                end
                
                
                imgMozaic(y:y+H-1, x:x+W-1, :) = match1;
                nrPieseAdaugate = nrPieseAdaugate+1;
                fprintf('Construim mozaic ... %2.2f%%  \n',100*nrPieseAdaugate/nrTotalPiese);
                aleator(y,x) = 1;
            end
        end
        
    otherwise
        printf('EROARE, optiune necunoscut \n');
        
end
