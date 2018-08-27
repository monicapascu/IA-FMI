function img = amplificaContinut(img,factor,metodaSelectareDrum,ploteazaDrum,culoareDrum)


imgCopy = imresize(img,factor);
[H,W,~] = size(imgCopy);
[h,w,~] = size(img);
h_diff = H-h;
w_diff = W-w;

img = imgCopy;

if w_diff > 0
    img =  micsoreazaLatime(img,w_diff,metodaSelectareDrum,...
        ploteazaDrum,culoareDrum);
end

if h_diff > 0
    
    img = micsoreazaInaltime(img,h_diff,metodaSelectareDrum,...
        ploteazaDrum,culoareDrum);
end

    