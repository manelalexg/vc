function [res] = obtenir_taula_no_ulls(dataset, mida)
    res = struct();
    num_elems = 19; %numero d'elements no ull per imatge (150->5%....150*19->95%)
    mida = mida - 1; % imcrop random behaviour
    
    for i = length(dataset):-1:1
        dt = dataset{i};

        start_points = [randi(size(dt.image, 2) - mida(2), num_elems, 1),...
                        randi(size(dt.image, 1) - mida(1), num_elems, 1)];
        %start_points
    
        for j = 1:size(start_points, 1) %19 iteraciones por cada imagen
            % crop subimage
            no_ull = imcrop(dt.image, [start_points(j,:), mida]);
            %I = insertMarker(dt.image, [start_points(j,1) start_points(j,2)]);
            %figure;imshow(img);
            %figure;imshow(I);
            
            % generate descriptors
            f = generate_features(no_ull);

%descomentar si no tira        
%         if size(res == 1)
%            res = s;
%         end
            res(num_elems*(i-1)+j) = f; %la primera seria en la pos 1783->18*99+1
            %non_eye_data
        end
    end
    res = struct2table(res);
    %non_eye_data
end