function looking_column = llegir_columna_mirar( filename )
%Llegeix la columna de si la persona mira o no del fitxer 'filename' 

    sheet = 1;
    range = 'E5:E1525';
    looking_column = xlsread(filename,sheet,range);
end

