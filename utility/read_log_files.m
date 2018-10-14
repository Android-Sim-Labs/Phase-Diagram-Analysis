function output = read_log_files(data,varargin)
% read_log_file:  reads a log file for specific data
% input arguments: varargin(string or cellstring) = filename(s)
%                  data(string or cellstring) = data to be read
% output arguments: output(structure) = data, filenames

%  modified from read_fit_data.m

if isempty(varargin)
    files = dir('*.log');
    if isempty(files)
        disp('no log files (.log) in directory');
        return
    else
        nf = length(files);
        for i = 1:nf
            [pathstr,fname,ext,versn] = fileparts(files(i).name);
            output(i).filename = fname;
        end
    end
else
	nf = length(varargin);
	for i = 1:nf
        if ischar(varargin{i})
            if exist(varargin{i},'file')
                [pathstr,fname,ext,versn] = fileparts(varargin{i});
                if strcmp(ext,'.log')
                    output(i).filename = fname;
                    files(i).name = varargin{i};
                else
                    error(sprintf('file %d is not a .log file',i));
                end
            elseif exist([varargin{i} '.log'],'file')
                fname = [varargin{i} '.log'];
                output(i).filename = varargin{i};
                files(i).name = fname;
            else
                error(sprintf('log file %d does not exist',i));
            end
        else
            error(sprintf('input argument %d is not a string',i));
        end
    end
end

nf = length(files);
if iscell(data)
    nd = length(data);
    for i = 1:nd   
        if ischar(data{i})
            str = data{i};
            if any(strcmpi(str,{'<D20>','S0'}))
                data_field{i} = 'S0';
                data_match{i} = '<D20> =';
                data_format{i} = '%f';
            elseif any(strcmpi(str,{'<D22>','S2'})) 
                data_field{i} = 'S2';
                data_match{i} = '<D22> =';
                data_format{i} = '%f';
            elseif any(strcmpi(str,{'Residual norm','resnorm'}))
                data_field{i} = 'resnorm';
                data_match{i} = 'Residual norm=';
                data_format{i} = '%f';
            elseif any(strcmpi(str,{'Chi-squared','Chisq','Chi2'}))
                data_field{i} = 'Chi2';
                data_match{i} = 'Chi-squared=';
                data_format{i} = '%f';
            elseif any(strcmpi(str,{'Reduced Chi-sq','redchisq','redchi2'}))
                data_field{i} = 'redChi2';
                data_match{i} = 'Reduced Chi-sq=';
                data_format{i} = '%f';
            elseif any(strcmpi(str,{'convergence','status'}))
                data_field{i} = 'convergence';
                data_match{i} = 'MINPACK completed:';
                data_format{i} = '%s';
            else % general parameter values
                data_field{i} = str(~isspace(str));
                data_match{i} = [upper(str) ' ='];
                data_format{i} = '%f';
            end
        else
            error(sprintf('data %d is not a string',i));
        end
    end
    for i = 1:nf 
        [fid,message] = fopen(files(i).name);
        if isequal(fid,-1)
            error(message);
        end 
        status = fseek(fid,0,'bof');
        if isequal(status,-1)
            message = ferror(fid);
            error(message);
        end
        while ~feof(fid)
            fline = fgetl(fid);
            for d = 1:nd
                k = strfind(fline,data_match{d});
                if isempty(k), continue, end
                s = fline(k+length(data_match{d}):end);
                output(i).(data_field{d}) = sscanf(s,data_format{d});
            end
        end
        fclose(fid);
    end
elseif ischar(data)
    str = data;
    if any(strcmpi(str,{'<D20>','S0'}))
        data_field = 'S0';
        data_match = '<D20> =';
        data_format = '%f';
    elseif any(strcmpi(str,{'<D22>','S2'})) 
        data_field = 'S2';
        data_match = '<D22> =';
        data_format = '%f';
    elseif any(strcmpi(str,{'Residual norm','resnorm'}))
        data_field = 'resnorm';
        data_match = 'Residual norm=';
        data_format = '%f';
    elseif any(strcmpi(str,{'Chi-squared','Chisq','Chi2'}))
        data_field = 'Chi2';
        data_match = 'Chi-squared=';
        data_format = '%f';
    elseif any(strcmpi(str,{'Reduced Chi-sq','redchisq','redchi2'}))
        data_field = 'redChi2';
        data_match = 'Reduced Chi-sq=';
        data_format = '%f';
    elseif any(strcmpi(str,{'convergence','status'}))
        data_field = 'convergence';
        data_match = 'MINPACK completed:';
        data_format = '%s';
    else % general parameter values
        data_field = str(~isspace(str));
        data_match = [upper(str) ' ='];
        data_format = '%f';
    end
    for i = 1:nf
        [fid,message] = fopen(files(i).name);
        if isequal(fid,-1)
            error(message);
        end 
        status = fseek(fid,0,'bof');
        if isequal(status,-1)
            message = ferror(fid);
            error(message);
        end
        while ~feof(fid)
            fline = fgetl(fid);
            k = strfind(fline,data_match);
            if isempty(k), continue, end
            s = fline(k+length(data_match):end);
            output(i).(data_field) = sscanf(s,data_format);
        end
        fclose(fid);
    end
else
    error('data must be a cell array of strings if request more than one data or a single string');
end

return