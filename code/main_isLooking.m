%Carreguem el dataset
n = 300; %llegirem 150 imatges del dataset
dir_dataset = 'dataset\';
imatges = dir(strcat(dir_dataset, '*.pgm')); % llista d'imatges amb extensio bmp, es un struct
dataset = cell(1,n);
columna_mira = read_looking_data('Miram.xlsx'); %columna de mira o no del archivo
for i = 1 : n
    ruta_imatge = strcat(dir_dataset, imatges(i).name); %ruta_imatge = 'BioID_xxxx.pgm'
    ruta_info_ulls = strrep(ruta_imatge,'pgm','eye'); % ruta_info_ulls = 'data\BioId_xxxx.eye'    
    imatge = imread(strcat(ruta_imatge)); %llegim la imatge

    if length(size(imatge)) == 3 %si la imatge és en color la convertim
        imatge = rgb2gray(imatge);
    end
    %figure; imshow(imatge);
    
    %carreguem el dataset, cada element amb la imatge corresponent i la informacio dels ulls
    dataset{i}= struct('imatge', imatge, 'pos_ulls', llegir_ulls(ruta_info_ulls), 'mira', columna_mira(i));
end

%Obtenció de la taula de característiques dels mira i no-mira 
mida = [64 64]; %especifiquem mida de la finestra per les mostres

taula = obtenir_taula_ulls(dataset, mida);
taula.ull = repmat({'1'}, height(taula), 1);

%Dades per deteccio de mirada
lookingV = get_looking_vector(dataset);
taula.mira = lookingV'; %ponemos una nueva columna de looking en eye_data
%eye_data

%Mesclem el Ddataset i seleccionem les dades dedicades al training de les
%dedicades a les proves
files_taula = height(taula);
taula_mesclada = taula(randperm(files_taula),:); %mesclem les taules
percentatge_train = 0.9;
num_files_train = percentatge_train*files_taula; %2700 per train
    
%repartim les dades en els sets corresponents
training = taula_mesclada(1:num_files_train, :);
testing = taula_mesclada(num_files_train+1:end, :);

% Entrenem el model
model = TreeBagger(100,training,'mira'); %executem TreeBagger(mira:1 o no-mira:0)

% Provem el model entrenat
testing_no_res = testing;
testing_no_res.mira = []; %eliminem la variable a predir, desprès comprovarem si obtenim bons resultats
prediccio = predict(model, testing_no_res); %predim el valor de la variable mira utilitzant el nostre model

[conf_matrix,order ] = avaluar_prediccio(prediccio, testing.mira) %obtenim els resultats mitjnçant la matriu de confusió