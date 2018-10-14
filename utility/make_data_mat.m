function make_data_mat(data_type,data_dir)
% make_dat_mat creates a matrix of all spectra in ascii or
% dat files (which one specified by the input argument data_type) stored in
% directory data_dir.
%
% this matrix is stored in the file all_data.dat or all_data.asc

switch data_type
    case 'dat'
        if (nargin == 1)
            files = dir('*.dat');
            nf = length(files);
        
            % all_data = dlmread('all_data.dat',' ');
            data = load(files(1).name);% data is a (num_points x 2) matrix
            dat_mat = zeros(size(data));
            dat_mat(:,1:2) = data;
            
            for i=2:nf
                data = load(files(i).name);
                dat_mat(:,2*i-1:2*i) = data;
            end
            
            format = [repmat('%8.3f %10.5f ',1,nf-1), '%8.3f %10.5f\n'];
            fid=fopen('all_data.dat','w');
            fprintf(fid,format,dat_mat');
            fclose(fid);
        else
            if (exist(data_dir,'dir') == 7)
                cd([pwd,'\',data_dir]);
                files = dir('*.dat');
                
                if (length(files) == 0)
                    disp('no .dat files in directory');
                else
                    nf = length(files);
        
                    data = load(files(1).name);% data is a (num_points x 2) matrix
                    dat_mat = zeros(size(data));
                    dat_mat(:,1:2) = data;
            
                    for i=2:nf
                        data = load(files(i).name);
                        dat_mat(:,2*i-1:2*i) = data;
                    end
            
                    format = [repmat('%8.3f %10.5f ',1,nf-1), '%8.3f %10.5f\n'];
                    fid=fopen('all_data.dat','w');
                    fprintf(fid,format,dat_mat');
                    fclose(fid);
                end
            
                cd('..');
            else
                disp('directory does not exist');
            end
        end
    case 'ascii'
        if (nargin == 1)
            files = dir('*.asc');
            nf = length(files);
        
            % a_all_data = dlmread('all_data.asc','\t');
            data = load(files(1).name);% data is a (num_points x 2) matrix
            dat_mat = zeros(size(data));
            dat_mat(:,1:2) = data;
            
            for i=2:nf
                data = load(files(i).name);
                dat_mat(:,2*i-1:2*i) = data;
            end
            
            format = [repmat('%-11.6f\t%-12.6f\t',1,nf-1), '%-11.6f\t%-12.6f\n'];
            fid=fopen('all_data.asc','w');
            fprintf(fid,format,dat_mat');
            fclose(fid);
        else
            if (exist(data_dir,'dir') == 7)
                cd([pwd,'\',data_dir]);
                files = dir('*.asc');
                
                if (length(files) == 0)
                    disp('no ascii files in directory');
                else
                    nf = length(files);
        
                    data = load(files(1).name);% data is a (num_points x 2) matrix
                    dat_mat = zeros(size(data));
                    dat_mat(:,1:2) = data;
            
                    for i=2:nf
                        data = load(files(i).name);
                        dat_mat(:,2*i-1:2*i) = data;
                    end
            
                    format = [repmat('%-11.6f\t%-12.6f\t',1,nf-1), '%-11.6f\t%-12.6f\n'];
                    fid=fopen('all_data.asc','w');
                    fprintf(fid,format,dat_mat');
                    fclose(fid);
                end
            
                cd('..');
            else
                disp('directory does not exist');
            end
        end     
    otherwise
        error('invalid file extension or data type');
end
