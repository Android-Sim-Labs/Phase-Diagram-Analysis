function output = load_dat_files(varargin)
% load_dat_files: loads data in .dat files into output structure
% output.name = filename, output.data = contents of .dat file

if isempty(varargin)
%     disp('no filename or filenames given');
%     return
    files = dir('*.dat');
    if isempty(files)
        disp('no dat files (.dat) in directory');
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
                if strcmp(ext,'.dat')
                    output(i).name = fname;
                    output(i).data = load(varargin{i},'-ascii');
                else
                    error(sprintf('file %d is not a .dat file',i));
                end
            elseif exist([varargin{i} '.dat'],'file')
                fname = [varargin{i} '.dat'];
                output(i).name = varargin{i};
                output(i).data = load(fname,'-ascii');
            else
                error(sprintf('dat file %d does not exist',i));
            end
        else
            error(sprintf('input argument %d is not a string',i));
        end
    end
end

return

% if isempty(varargin)
%     disp('no filename or filenames given');
%     return
% else
% 	nf = length(varargin);
% 	
% 	if nf > 1
%         for i = 1:nf
%             if ischar(varargin{i})
%                 fname = varargin{i};
%                 varargout{i} = load(fname,'-ascii');
%             else
%                 error(sprintf('file %d is not a string specifying a filename',i));
%             end
%         end
% 	else
%         if ischar(varargin{1})
%             fname = varargin{1};
%             varargout{1} = load(fname,'-ascii');
% 	    else
%             error('input arguments must be strings specifying filenames');
% 	    end
%     end
% end