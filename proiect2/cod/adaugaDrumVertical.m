function img1 = adaugaDrumVertical(img,drum)

img1 = zeros(size(img,1),size(img,2)+1,size(img,3),'uint8');

for i=1:size(img1,1)
    coloana = drum(i,2);
    
    if coloana == 1
        v1 = [img(i,coloana,:) , img(i,coloana+1,:)];
        avg1 = mean(v1);
        v1 = [avg1 , img(i,coloana+1,:)];
        avg2 = mean(v1);
        img1(i,:,:) = [avg1,avg2,img(i,coloana+1:end,:)];
    else
        if coloana == size(img,2)
            v1 = [img(i,coloana-1,:) , img(i,coloana,:)];
            avg1 = mean(v1);
            avg2 = avg1;
            img1(i,:,:) = [img(i,1:coloana-1,:),avg1,avg2];
        else
            
            
            v1 = [img(i,coloana-1,:) , img(i,coloana+1,:)];
            avg1 = mean(v1);
            v1 = [avg1 , img(i,coloana+1,:)];
            avg2 = mean(v1);
            img1(i,:,:) = [img(i,1:coloana-1,:),avg1,avg2,img(i,coloana+1:end,:)];
        end
    end
    
    
    
    
    
end