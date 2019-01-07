%Carreguem el dataset
n = 150; %llegirem 150 imatges del dataset
dir_dataset = 'dataset\';
imatges = dir(strcat(dir_dataset, '*.pgm')); % llista d'imatges amb extensio bmp, es un struct
dataset = cell(1,n);
for i = 1 : n
    ruta_imatge = strcat(dir_dataset, imatges(i).name); %ruta_imatge = 'BioID_xxxx.pgm'
    ruta_info_ulls = strrep(ruta_imatge,'pgm','eye'); % ruta_info_ulls = 'data\BioId_xxxx.eye'    
    imatge = imread(strcat(ruta_imatge)); %llegim la imatge
    %figure; imshow(imatge);
    
    %carreguem el dataset, cada element amb la imatge corresponent i la informacio dels ulls
    dataset{i}= struct('imatge', imatge, 'pos_ulls', llegir_ulls(ruta_info_ulls));
end

%Obtenció de la taula de característiques dels ulls i no-ulls 
mida = [64 64]; %especifiquem mida de la finestra per les mostres

taula_ulls = obtenir_taula_ulls(dataset, mida);
taula_ulls.ull = repmat({'1'}, height(taula_ulls), 1);

taula_no_ulls = obtenir_taula_no_ulls(dataset, mida);
taula_no_ulls.ull = repmat({'0'}, height(taula_no_ulls), 1);

%Mesclem els datasets anteriors i seleccionem les dades dedicades al training de les
%dedicades a les proves
% separate training, testing data
[ training_data, testing_data ] = split_data(eye_data, non_eye_data);

% train model
%model = fitcsvm(training_data, 'class');
model = TreeBagger(100,training_data,'class'); %variable respuesta class(eye o no eye)
%model
% Use ResponseVarName to specify label 'class'

% test model: precision, recall, accuracy
testing_nolabel = testing_data;
testing_nolabel.class = []; % remove class column, para ver si luego predice correcto
prediction = predict(model, testing_nolabel);
%prediction
%testing_data.class

[conf_matrix,order ] = eval_prediction(prediction, testing_data.class)