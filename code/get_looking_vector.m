function [ res ] = get_looking_vector(imgs)
    %Convert 1xN cell to 1xN struct
    dataM = cell2mat(imgs);
    
    %Extract the 'looking' field from the 1xN struct
    %dataM
    res = extractfield(dataM,'mira');
    %looking
    
    %Duplicate each one because for each image there are 2 eyes.
    
%     vect = kron(looking,[1,1]);
    %vect
end