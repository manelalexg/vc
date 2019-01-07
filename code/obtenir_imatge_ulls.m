function [imatge] = obtenir_imatge_ulls(element, mida)
    dfactor = 0.60;
    d = pdist(element.pos_ulls, 'euclidean'); %distancia entre los dos ojos
    m = ceil(dfactor*d/2); %redondea al entero mayor o igual
    %figure; imshow(element.imatge);
    imatge = imcrop(element.imatge, [element.pos_ulls(1,:) - m, element.pos_ulls(2,:) + m]);
    imatge = imresize(imatge, mida);
    %figure; imshow(imatge);
end
