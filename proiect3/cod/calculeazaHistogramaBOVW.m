function histogramaBOVW = calculeazaHistogramaBOVW(descriptoriHOG, cuvinteVizuale)
  % calculeaza histograma BOVW pe baza descriptorilor si a cuvintelor
  % vizuale, gasind pentru fiecare descriptor cuvantul vizual cel mai
  % apropiat (in sensul distantei Euclidiene)
  %
  % Input:
  %   descriptori: matrice MxD, contine M descriptori de dimensiune D
  %   cuvinteVizuale: matrice NxD, contine N centri de dimensiune D 
  % Output:
  %   histogramaBOVW: vector linie 1xN 
  
 % completati codul
 k  = size(cuvinteVizuale,1);
 nrDescriptori = size(descriptoriHOG,1);
 histogramaBOVW = zeros(1,k);
 
 for i = 1:nrDescriptori
     distantaMinima = inf;
     for j = 1:k
         distantaEuclidiana = sqrt(sum((descriptoriHOG(i,:) - cuvinteVizuale(j,:)).^2));
         if distantaMinima > distantaEuclidiana
             distantaMinima = distantaEuclidiana;
             indiceLinie = j;
         end
     end
     histogramaBOVW(indiceLinie) = histogramaBOVW(indiceLinie) +1 ;
 end;
         
     
end