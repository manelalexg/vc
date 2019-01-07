function [features] = obtenir_caracteristiques(im)
%   Generate an array of features describing an image
%   param im:           image to describe
%   return features:    struct of features
    
    %fs un array de funciones predefinidas
    fs = {
        @extractLBPFeatures,...
        @Hog,...
        @std2,...
        @mean2,...
        %@side_histogram,...
    };
 
    features = struct();
    
    for i = 1:size(fs,2) %size(fs,2) = numero de columnas
        f = fs{i}; %f es un function_handle @
        finfo = functions(f);
        %finfo
        funresult = f(im);
        %funresult
        for j=1:size(funresult,2) %recorremos los resultados del funresult
             name = strcat(finfo.function,int2str(j));
             %pone nombre a cada campo del struct features
             features.(name) = funresult(j);
        end
        %features
    end
    %features
end

function [feat] = Hog (im) % Tarda molt i no millora massa els resultats
    [features, visual] = extractHOGFeatures(im, 'CellSize', [32 32]);
    feat = features;
    %plot(visual); %visualitzacio de les HOG features
end

function [hs] = side_histogram(im)
    x = double(im);
    %mean(x, 1) 
    %mean(x, 2)' 
    %std(x, 1, 1) 
    %std(x, 1, 2)'
    hs = [mean(x, 1) mean(x, 2)' std(x, 1, 1) std(x, 1, 2)'];
    %bar(hs);
end