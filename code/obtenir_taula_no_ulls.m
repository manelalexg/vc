function [res] = obtenir_taula_no_ulls(dataset, mida)
    res = struct();
    num_elems = 19; %numero d'elements no ull per imatge (1520->5%....1520*19->95%)
    mida = mida - 1; % imcrop random behaviour
    
    for i = length(dataset):-1:1
        dt = dataset{i};

        start_points = [randi(size(dt.imatge, 2) - mida(2), num_elems, 1),...
                        randi(size(dt.imatge, 1) - mida(1), num_elems, 1)];
        %start_points
    
        for j = 1:size(start_points, 1) %19 iteracions per cada imatge
            % crop subimatge
            no_ull = imcrop(dt.imatge, [start_points(j,:), mida]);
            %I = insertMarker(dt.image, [start_points(j,1) start_points(j,2)]);
            %figure;imshow(no_ull);
            %figure;imshow(I);
            
            % generate descriptors
            f = obtenir_caracteristiques(no_ull);
        
            if size(res) == 1
               res = f;
            end
            res(num_elems*(i-1)+j) = f; %la primera seria en la pos 2071->19*(150-1)+1
            %res
        end
    end
    res = struct2table(res);
    %res
end