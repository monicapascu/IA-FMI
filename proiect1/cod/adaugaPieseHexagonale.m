function imgMozaic = adaugaPieseHexagonale(params)


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

        vertX = [13,27,40,27,13,0];
        vertY = [28,28,14,0,0,14];
        mask = poly2mask(vertX,vertY,H,W);
        
        if c == 3
        mask = logical(repmat(mask, [1 1 3]));
        else
            mask = logical(mask);
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
                
                window(mask) = match1(mask);
                imgMozaic(y:y+H-1, x:x+W-1, :) = window;
                nrPieseAdaugate = nrPieseAdaugate+1;
               fprintf('Construim mozaic ... %2.2f%% , %f %f \n',100*nrPieseAdaugate/nrTotalPiese,y,x);
               aleator(y,x) = 1;
            end
        end
  
    case 'distantaCuloareMedie'
        %completati codul Matlab
        nrPieseAdaugate = 0;
        imgMozaic = padarray(imgMozaic, [H W] , 'replicate','both');
        img = padarray(img, [H W] , 'replicate','both');
        
        for n = 1:N
            currentTile = params.pieseMozaic(:,:,:,n) ;
            if (c==1)
                currentTile = rgb2gray(currentTile);
            end
            
            for k = 1:c
                tilesValues(n,k) = mean2(currentTile(:,:,k));
            end
        end
        
        vertX = [13,27,40,27,13,0];
        vertY = [28,28,14,0,0,14];
        overlapW = 27;
        overlapH = 14;
        mask = poly2mask(vertX,vertY,H,W);
        
        if c == 3
            mask = logical(repmat(mask, [1 1 3]));
        else
            mask = logical(mask);
        end
        
        vecini=double(zeros(h,w));
        i=0;
        
        for y =1:H:h+overlapH
            nr = 1;
            i=i+1;
            j=0;
            for x=1:overlapW:w+overlapW
                
                if mod(nr , 2) ~= 0
                    y = y + overlapH;
                    subImag = img(y:y+H-1,x:x+W-1, :);
                else
                    subImag = img(y:y+H-1,x:x+W-1, :);
                end
                
                nr = nr+1;
                
                subImagValues = zeros(1,c);
                for k=1:c
                    subImagValues(k) = mean2(subImag(:,:,k));
                end
                dist = zeros(N,1);
                for n = 1:N
                    dist(n) = sqrt(sum((subImagValues - tilesValues(n,:)).^2));
                end
                
                [minDist , match] = min(dist);
                
                j=j+1;
                vecini(i,j)=match;
                if(i>1) && (j>1) && (j<w)
                    
                    while vecini(i,j-1)==vecini(i,j) || vecini(i-1,j) == vecini(i,j) || vecini(i-1,j-1) == vecini(i,j) || ...
                            vecini(i-1,j+1)== vecini(i,j) || vecini(i,j+1) == vecini(i,j)
                        dist(vecini(i,j))=1000;
                        [minDist , match] = min(dist);
                        vecini(i,j) = match;
                        
                    end
                    
                end
                
                match = vecini(i,j);
                window = imgMozaic(y:y+H-1,x:x+W-1, :);
                match1 = params.pieseMozaic(:,:,:,match);
                if c==1
                    match1 = rgb2gray(match1);
                end
                window(mask) = match1(mask);
                imgMozaic(y:y+H-1, x:x+W-1, :) = window;
                nrPieseAdaugate = nrPieseAdaugate+1;
                fprintf('Construim mozaic ...  \n');
                
                
                if mod(nr,2) == 0
                    y = y - overlapH;
                end
                
            end
        end
        
        imgMozaic = imcrop(imgMozaic, [1+overlapW H w-1 h-1]);
       
      
       
    otherwise
        printf('EROARE, optiune necunoscut \n');
    
end
