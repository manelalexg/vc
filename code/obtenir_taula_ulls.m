function [res] = obtenir_taula_ulls(dataset, mida)
    res = struct();
    
    for i = length(dataset):-1:1
        ull = obtenir_imatge_ulls(dataset{i}, mida);
        f = generate_features(ull); %caracteristiques d'una cara
        
%descomentar si no tira        
%         if size(res == 1)
%            res = s;
%         end
        res(i) = f; %omplim la taula
    end
    
    res = struct2table(res);
    %res
end
