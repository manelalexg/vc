function looking_column = read_looking_data( filename )
%read_looking_data Read the column of whether the person is looking or not 

    sheet = 1;
    range = 'E5:E1525';
    looking_column = xlsread(filename,sheet,range);
end

