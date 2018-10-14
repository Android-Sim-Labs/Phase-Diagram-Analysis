function make_data_dirs
% make_data_dirs creates directories in the experiment directory (ie pwd) to store
% the .asc files and .dat files

a_files = dir('*.asc');
d_files = dir('*.dat');

if (length(a_files) == 0) 
    disp('no ascii files in directory');
else
    make_asc_dir;
end

if (length(d_files) == 0)
    if (exist('ascii_files','dir') == 7)
        make_dat_dir('ascii_files');
    else
        disp('no .dat files in directory, and no ascii file directory');
    end
else
    make_dat_dir;
end

return