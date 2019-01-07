function [ img1, img2 ] = extract_eye_image(eyeElem, eyesize)
%   From a data instance extract imatges around eye position
%   param: eyeElem      struct representing an image with eye positions
%   param: eyesize      [ height , width ] of final images
%   return:  img1,img2  imatges of size eyesize around eye position
    dfactor = 0.60;
    d = pdist(eyeElem.eyepos, 'euclidean'); %distancia entre los dos ojos
    m = ceil(dfactor*d/2); %redondea al entero mayor o igual
    %[eyeElem.eyepos(1,:) - m, 2*m, 2*m]
    %I = insertMarker(eyeElem.image, [209 88]);
    %figure; imshow(I,[]);
    img1 = imcrop(eyeElem.image, [eyeElem.eyepos(1,:) - m, 2*m, 2*m]);
    img2 = imcrop(eyeElem.image, [eyeElem.eyepos(2,:) - m, 2*m, 2*m]);
    img1 = imresize(img1, eyesize);
    img2 = imresize(img2, eyesize);
    %figure; imshow(img1);
    %figure; imshow(img2);
end

