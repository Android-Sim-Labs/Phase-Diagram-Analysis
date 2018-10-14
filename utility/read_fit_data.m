function [spectra,summary] = read_fit_data(data_name,data_files)

if nargin > 1
    ndf = length(data_files);
    
    for i = 1:ndf
        if ~ischar(data_files{i})
            error('data file must be a string');
        end
        
        files(i) = dir(data_files{i});
    end
else
    files = dir('*.log');
end

nf = length(files);

if iscell(data_name)
    nd = length(data_name);
    
    % construct data_str for allocating data structure
    % check to see if entries in data_name cell array are strings
    
    data_str{1} = 'filename';
    data_str{2} = {};
    
    for d = 1:nd   
        str = data_name{d};
        
        if ~ischar(str)
            error('data name must be a string');
        else
            if strcmp(str,'<D20>')
                str = 'D20';
            elseif strcmp(str,'<D22>')
                str = 'D22';
            end
        end
    
        data_str{d*2+1} = str;
        data_str{d*2+2} = {};
        data_match{d} = [data_name{d} ' ='];
    end
    
    spectra = struct(data_str{:});
    spectra_fields = fieldnames(spectra);
    summary = cell(1,nd);
    temp = repmat(NaN,[nf nd]);
    data_there = repmat(false,[nf nd]);
    
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
            tline = fgetl(fid);
            
            for d = 1:nd
                k = strfind(tline,data_match{d});
                
                if isempty(k), continue, end
                
                s = tline(k+length(data_match{d}):end);
                data_there(i,d) = true;
                temp(i,d) = sscanf(s,'%f');
            end
        end

        fclose(fid);
    end
    
    for i = 1:nf
        spectra(i).filename = files(i).name;
        summary{1}{i,1} = files(i).name;
        
        for d = 1:nd
            spectra(i).(spectra_fields{d+1}) = temp(i,d);
            summary{d+1} = temp(data_there(:,d),d);
        end
    end
elseif ischar(data_name)
    str = data_name;
    
    if strcmp(str,'<D20>')
        str = 'D20';
    elseif strcmp(str,'<D22>')
        str = 'D22';
    end
            
    data_str{1} = 'filename';
    data_str{2} = {};
    data_str{3} = str;
    data_str{4} = {};
    spectra = struct(data_str{:});
    summary = repmat(NaN,[nf 1]);
    data_match = [data_name ' ='];
    
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
            tline = fgetl(fid);
            k = strfind(tline,data_match);
        
            if isempty(k), continue, end
        
            s = tline(k+length(data_match):end);
            summary(i) = sscanf(s,'%f');
        end

        spectra(i).filename = files(i).name;
        spectra(i).(str) = summary(i);
        
        fclose(fid);
    end
else
    error('data name must be a cell array of strings if request more than one data or a single string');
end

return