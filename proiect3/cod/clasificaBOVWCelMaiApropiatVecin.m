function eticheta = clasificaBOVWCelMaiApropiatVecin(histogramaBOVW_test,histogrameBOVW_exemplePozitive,histogrameBOVW_exempleNegative)
% eticheta = eticheta celui mai apropiat vecin (in sensul distantei Euclidiene)
% eticheta = 1, daca cel mai apropiat vecin este un exemplu pozitiv,
% eticheta = 0, daca cel mai apropiat vecin este un exemplu negativ. 
% Input: 
%       histogramaBOVW_test - matrice 1 x K, histograma BOVW a unei imagini test
%       histogrameBOVW_exemplePozitive - matrice #ImaginiExemplePozitive x K, fiecare linie reprezinta histograma BOVW a unei imagini pozitive
%       histogrameBOVW_exempleNegative - matrice #ImaginiExempleNegative x K, fiecare linie reprezinta histograma BOVW a unei imagini negative
% Output: 
%     eticheta - eticheta dedusa a imaginii test

  

distExemplePozitive = inf;
for j = 1:size(histogrameBOVW_exemplePozitive)
    distantaEuclidiana = sqrt(sum((histogramaBOVW_test - histogrameBOVW_exemplePozitive(j,:)).^2));
    if distantaEuclidiana < distExemplePozitive
        distExemplePozitive = distantaEuclidiana;
    end
end

distExempleNegative = inf;
for j = 1:size(histogrameBOVW_exempleNegative)
    distantaEuclidiana = sqrt(sum((histogramaBOVW_test - histogrameBOVW_exempleNegative(j,:)).^2));
    if distantaEuclidiana < distExempleNegative
        distExempleNegative = distantaEuclidiana;
    end
end

if distExemplePozitive < distExempleNegative
    eticheta = 1;
else
    eticheta = 0;
end

end
