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

%Obtenci� de la taula de caracter�stiques dels ulls i no-ulls 
mida = [64 64]; %especifiquem mida de la finestra per les mostres

taula_ulls = obtenir_taula_ulls(dataset, mida);
taula_ulls.ull = repmat({'1'}, height(taula_ulls), 1);

taula_no_ulls = obtenir_taula_no_ulls(dataset, mida);
taula_no_ulls.ull = repmat({'0'}, height(taula_no_ulls), 1);

%Mesclem els datasets anteriors i seleccionem les dades dedicades al training de les
%dedicades a les proves
taula = [taula_ulls; taula_no_ulls]; %concatenem les taules per fila
files_taula = height(taula);
taula_mesclada = taula(randperm(files_taula),:); %mesclem les taules
percentatge_train = 0.9;
num_files_train = percentatge_train*files_taula; %2700 per train
    
%repartim les dades en els sets corresponents
training = taula_mesclada(1:num_files_train, :);
testing = taula_mesclada(num_files_train+1:end, :);

% Entrenem el model
model = TreeBagger(100,training,'ull'); %executem TreeBagger(eye:1 o no-eye:0)

% Provem el model entrenat
testing_no_res = testing;
testing_no_res.ull = []; %eliminem la variable a predir, despr�s comprovarem si obtenim bons resultats
prediccio = predict(model, testing_no_res); %predim el valor de la variable ull utilitzant el nostre model

[conf_matrix,order ] = avaluar_prediccio(prediccio, testing.ull) %obtenim els resultats mitjn�ant la matriu de confusi�