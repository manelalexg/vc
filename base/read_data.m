%el parametro de salida data es un array de structs, donde cada struct
%almacena la imagen, la posicion de los ojos y si esta mirando o no.

function data = read_data(data_dir, n_opt)
    imf = dir(strcat(data_dir, '*.pgm')); % llista d'imatges amb extensio bmp, es un struct
    n = length(imf); % nombre d'imatges en el directori = 1521
    if nargin > 1 %nargin = 2 (data_dir y n_opt)
        n = n_opt;
    end
    
    %images = zeros([n,100,100]); % array n imatges de mida 100 x 100 (para mostras las imagenes luego)
    
    data = cell(1,n); %una matriz de cell de 1 fila i n columnas
    looking_column = read_looking_data('Miram.xlsx'); %columna de mira o no del archivo

    for i = 1 : n
         name = imf(i).name; %nombre del archivo pgm name = 'BioID_xxxx.pgm'
         name_eye = strcat(data_dir, name(1:end-3),'eye'); % name_eye = 'data\BioId_xxxx.eye'
         im = imread(strcat(data_dir, name)); %leemos la imagen.eye
         
         s = size(im); %num_fil, num_col
         l = length(s); %2 dimensiones si es gris
         if l == 3 %para converitr a gris si es una imagen en color
             im = rgb2gray(im);
         end
         
         %images(i,:,:) = imresize(im,[100 100]);
         
         %metemos en cada columna de 'data' un struct(image,eyepos,looking)
         data{i}= struct('image', im, 'eyepos', readEye(name_eye), 'looking', looking_column(i));
    end

    %mostrem les imatges
    %for index = 1 : 20
      % I =  uint8(squeeze(images(index,:,:))); % squeeze elimina les dimensions que tenen mida 1 (singletons)
     %  figure; imshow(I,[]);
    %end   

    function M = readEye(filename)
        %lee el archivo de texto con 'dlmread' empezando por la fila 1 y la
        %columna 0 con el delimitador de espacio. Luego reformula la forma
        %de los valores obtenidos (4 valores) en un array de 2x2.
        M = reshape(dlmread(filename,'', 1,0),[2,2])'; 
        %tendriamos por ejemplo:
        % M = 
            % 232 110
            % 161 110
    end
end
