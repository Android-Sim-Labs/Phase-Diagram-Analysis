function P = read_P_run_file(varargin)
% read_P_run_file: reads parameters from run file
% input arguments: varargin(string or cellstring) = filename(s)
% output arguments: P(structure) = parameters

if isempty(varargin)
    files = dir('*.run');
    if isempty(files)
        disp('no run files (.run) in directory');
        return
    else
        nf = length(files);
        for i = 1:nf
            [pathstr,fname,ext,versn] = fileparts(files(i).name);
            P(i).filename = fname;
        end
    end
else
	nf = length(varargin);
	for i = 1:nf
        if ischar(varargin{i})
            if exist(varargin{i},'file')
                [pathstr,fname,ext,versn] = fileparts(varargin{i});
                if strcmp(ext,'.run')
                    P(i).filename = fname;
                    files(i).name = varargin{i};
                else
                    error(sprintf('file %d is not a .run file',i));
                end
            elseif exist([varargin{i} '.run'],'file')
                fname = [varargin{i} '.run'];
                P(i).filename = varargin{i};
                files(i).name = fname;
            else
                error(sprintf('run file %d does not exist',i));
            end
        else
            error(sprintf('input argument %d is not a string',i));
        end
    end
end

nf = length(files);

% [tok,rem] = strtok(str2,'=')
% sscanf(rem(2:end),'%f,',Inf)
% match = regexp(str1, '(\d*\.\d*)','match');
% match = regexp(str1, '[a-zA-Z]*(?=,|\s)','match');

% data_field = str(~isspace(str));
% data_match = [upper(str) ' ='];
% data_format = '%f';

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
        k = strfind(fline,'let');
        if isempty(k), continue, end
        [pnames,values] = strtok(fline(k+3:end),'=');
        m = regexp(pnames,'\w*(?=,|\s)','match');
        v = sscanf(values(2:end),'%f,',Inf);
        nm = length(m);
        nv = length(v);
        if nm ~= nv
            error('number of parameters ~= number of values');
        else
            for n = 1:nm
                P(i).(m{n}) = v(n);
            end
        end
    end
    fclose(fid);
end

return