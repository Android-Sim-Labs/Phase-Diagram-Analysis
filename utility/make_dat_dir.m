function make_dat_dir(a_dir)
% make_dat_dir is a function that either moves existing .dat file in pwd to a directory
% called dat_files or creates .dat files from either .asc files in the pwd or in the directory
% specified by the input argument and stores them in a directory with name dat_files

if (nargin == 1)
    cd([pwd,'\',a_dir]);
    files = dir('*.asc');
    
    if (length(files) == 0)
        disp('no ascii files to create .dat files in given directory');
    else
        nf = length(files);

        for i=1:nf
            [pathstr,filename,ext,versn] = fileparts(files(i).name);
            %[filename,ext] = strtok(files(i).name,'.');
            asc2dat(filename,3326);
        end

        mkdir('..\dat_files');
        movefile('*.dat','..\dat_files');
    end
    
    cd('..');
else
    a_files = dir('*.asc');
    d_files = dir('*.dat');
    
    if (length(d_files) == 0) 
        disp('no .dat files in directory'); 
    else
        if (exist('dat_files','dir') == 7)
            movefile('*.dat','\dat_files');
        else
            mkdir('dat_files');
            movefile('*.dat','\dat_files');
        end
    end
    
    if (length(a_files) == 0) 
        disp('no ascii files in directory'); 
    else
        nf = length(a_files);

        for i=1:nf
            [pathstr,filename,ext,versn] = fileparts(a_files(i).name)
            %[filename,ext] = strtok(files(i).name,'.');
            asc2dat(filename,3326);
        end
        
        if (exist('dat_files','dir') == 7)
            movefile('*.dat','\dat_files');
        else
            mkdir('dat_files');
            movefile('*.dat','\dat_files');
        end
    end
end