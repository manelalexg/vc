function [imatge] = obtenir_imatge_ulls(element, mida)
    dfactor = 0.60;
    d = pdist(element.pos_ulls, 'euclidean'); %distancia entre los dos ojos
    m = ceil(dfactor*d/2); %redondea al entero mayor o igual
    imatge = imcrop(element.imatge, [element.pos_ulls(2,:) - m, 2*m + d, 2*m]);
    
    %Mostrem la imatge i els ulls retallats
    
    %subplot(1,2,1), imshow(element.imatge);
    %title('Detector ulls');
    %subplot(1,2,2);
    %imshow(imatge);
    %title('Ulls retallats');
    
    imatge = imresize(imatge, mida);
end
