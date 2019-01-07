% LOAD variable data
if ~exist('data', 'var') % reload only if needed
    %addpath data;
    data = read_data('data\', 100);
    n = length(data); %n =100 en este caso
end

crop_size = [64 64]; %para hacer el recorte de los ojos

% generate eye data, 1 row per eye
eye_class = 'eye';
eye_data = generate_eye_data(data, crop_size); %eye_data = tabla de catacteristicas
eye_data.class = repmat({eye_class}, height(eye_data), 1); %añade otro campo en el struct para cada fila
%eye_data

% generate non eye data, 1 row per non-eye
non_eye_per_image = 18;
non_eye_class = 'no-eye';
non_eye_data = generate_non_eye_data(data, non_eye_per_image, crop_size);
non_eye_data.class = repmat({non_eye_class}, height(non_eye_data), 1);
%non_eye_data

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



% TODO : Normalizar lluminositat
% TODO : Generate vector features per passar ho

% read https://www.researchgate.net/publication/262987479_Efficient_eye_detection_using_HOG-PCA_descriptor
%COMPARACIONS
%Lluminositat normalitzada
%Classificador
%Descriptors

%Dades per deteccio de mirada
lookingV = get_looking_vector(data);
eye_data.looking = lookingV'; %ponemos una nueva columna de looking en eye_data
%eye_data

%Separar ulls mirant i no-mirant
eye_looking = eye_data(eye_data.looking==1,:);
%eye_looking
no_eye_looking = eye_data(eye_data.looking==0,:);
%no_eye_looking


% separate training, testing data
[training_data_look, testing_data_look] = split_data(eye_looking, no_eye_looking);

%train model
modelLook = TreeBagger(100,training_data_look,'looking'); %variable 'looking'

testing_nolabel = testing_data_look;
testing_nolabel.looking = [];
predictionLook = predict(modelLook, testing_nolabel);

%testing_data_look.looking
looking_labels = cellstr(num2str(testing_data_look.looking));
%looking_labels
[conf_matrix_look,orderlook] = eval_prediction (predictionLook, looking_labels)
