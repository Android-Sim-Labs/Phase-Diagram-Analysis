function make_asc_dir
% make_asc_dir is a function that stores all ascii files in pwd into one directory
% called ascii_files

a_files = dir('*.asc');

if (length(a_files) == 0) 
    disp('no ascii files in directory');
else
    if (exist('ascii_files','dir') == 7)
        movefile('*.asc','\ascii_files');
    else
        mkdir('ascii_files');
        movefile('*.asc','\ascii_files');
    end
end