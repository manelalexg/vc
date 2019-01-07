function [res] = obtenir_taula_ulls(dataset, mida)
    res = struct();
    
    for i = length(dataset):-1:1
        ull = obtenir_imatge_ulls(dataset{i}, mida); %obtenim els ulls
        f = obtenir_caracteristiques(ull); %obtenim caracteristiques dels dos ulls
        
        %inicialitzem el contenidor
        if size(res) == 1
           res = f;
        end
        res(i) = f; %omplim la taula
    end
    
    res = struct2table(res);
    %res
end
