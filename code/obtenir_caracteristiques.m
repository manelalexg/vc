function [caracteristiques] = obtenir_caracteristiques(im)
%   Genera un array de caracteristicas les quals descriuen una imatge
%   parametre im:           imagtge a descriure
%   retorna features:    struct de caracteristiques
    
    fs = {
        @extractLBPFeatures ...
        @Hog ...
        @std2 ...
        @mean2
    };

    size(fs,2)
 
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
    end
end

function [caract] = Hog (im)
    [caractHOG, visualHOG] = extractHOGFeatures(im, 'CellSize', [16 16]);
    %plot(visualHOG);
    caract = caractHOG;
    caract
end