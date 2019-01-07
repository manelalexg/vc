function [caracteristiques] = obtenir_caracteristiques(im)
%   Genera un array de caracteristicas les quals descriuen una imatge
%   parametre im:           imagtge a descriure
%   retorna features:    struct de caracteristiques
    
    %fs es un array de funcions predefinides
    fs = {
        @extractLBPFeatures,...
        @Hog,...
        @std2,...
        @mean2,...
        %@side_histogram,...
    };
 
    caracteristiques = struct();
    
    for i = 1:size(fs,2) %size(fs,2) = numero de columnes
        fun = fs{i}; %f es un function_handle @
        fun_info = functions(fun);
        %fun_info
        fun_resultat = fun(im);
        %fun_resultat
        for j=1:size(fun_resultat,2) %recorremos los resultados del funresult
             nom = strcat(fun_info.function, int2str(j));
             %pone nombre a cada campo del struct features
             caracteristiques.(nom) = fun_resultat(j);
        end
        %caracteristiques
    end
    %caracteristiques
end

function [caract] = Hog (im) % Tarda molt i no millora massa els resultats
    [caractHOG, visualHOG] = extractHOGFeatures(im, 'CellSize', [32 32]);
    caract = caractHOG;
    %plot(visualHOG); %visualitzacio de les HOG features
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