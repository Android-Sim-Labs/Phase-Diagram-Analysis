% loads data in .asc or .dat files in pwd into the workspace

files = dir('*.dat');

if ~isempty(files)
    nf = length(files);

    for i = 1:nf
        load(files(i).name,'-ascii');
    end
end

clear files;
files = dir('*.asc');

if ~isempty(files)
    nf = length(files);

    for i = 1:nf
        load(files(i).name,'-ascii');
    end
end

clear files nf i;
return