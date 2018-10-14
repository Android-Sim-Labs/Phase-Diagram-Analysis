function output = load_asc_files(varargin)
% load_asc_files: loads data in .asc files into output structure
% output.name = filename, output.data = contents of .asc file

if isempty(varargin)
%     disp('no filename or filenames given');
%     return
    files = dir('*.asc');
    if isempty(files)
        disp('no ascii files (.asc) in directory');
        return
    else
        nf = length(files);
        for i = 1:nf
            [pathstr,fname,ext,versn] = fileparts(files(i).name);
            output(i).name = fname;
            output(i).data = load(files(i).name,'-ascii');
        end
    end
else
	nf = length(varargin);
	for i = 1:nf
        if ischar(varargin{i})
            if exist(varargin{i},'file')
                [pathstr,fname,ext,versn] = fileparts(varargin{i});
                if strcmp(ext,'.asc')
                    output(i).name = fname;
                    output(i).data = load(varargin{i},'-ascii');
                else
                    error(sprintf('file %d is not a .asc file',i));
                end
            elseif exist([varargin{i} '.asc'],'file')
                fname = [varargin{i} '.asc'];
                output(i).name = varargin{i};
                output(i).data = load(fname,'-ascii');
            else
                error(sprintf('ascii file %d does not exist',i));
            end
        else
            error(sprintf('input argument %d is not a string',i));
        end
    end
end

return

% if ischar(varargin{i})
%     fname = varargin{i};
%     varargout{i} = load(fname,'-ascii');
% else
%     error(sprintf('input argument %d is not a string specifying a filename',i));
% end