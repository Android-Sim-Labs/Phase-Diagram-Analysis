function output = load_fit_files(varargin)
% load_fit_files: loads data in .spc files into output structure
% output.name = filename, output.data = contents of .spc file

if isempty(varargin)
%     disp('no filename or filenames given');
%     return
    files = dir('*.spc');

    if isempty(files)
        disp('no spc files (.spc) in directory');
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
                if strcmp(ext,'.spc')
                    output(i).name = fname;
                    output(i).data = load(varargin{i},'-ascii');
                else
                    error(sprintf('file %d is not a .spc file',i));
                end
            elseif exist([varargin{i} '.spc'],'file')
                fname = [varargin{i} '.spc'];
                output(i).name = varargin{i};
                output(i).data = load(fname,'-ascii');
            else
                error(sprintf('spc file %d does not exist',i));
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
    
%for i = 1:nf
%    fid = fopen(files(i).name);
%    [pathstr,name,ext,versn] = fileparts(files(i).name);
%    spectra = fscanf(fid,'%f %f %f',[3 Inf]);
%    spectra = spectra';
%    save(name,'spectra','-ascii','-double');
%    fit_spec = load(name,'-ascii');
%end

%clear files pathstr ext versn nf i fid name spectra

%subplot(3,1,1)
%plot_spectra([sample_01_1(:,1:2),[sample_01_1(:,1),sample_01_1(:,3)]],0,{'.g';'-r'})
%axis tight,hold off
%subplot(3,1,2),plot_spectra([sample_01_2(:,1:2),[sample_01_2(:,1),sample_01_2(:,3)]],0,{'.g';'-r'})
%axis tight,hold off
%subplot(3,1,3),plot_spectra([sample_01_3(:,1:2),[sample_01_3(:,1),sample_01_3(:,3)]],0,{'.g';'-r'})
%axis tight,hold off

%sample_02_4 = read_fit_files('sample_02_4.spc');
%sample_02_5 = read_fit_files('sample_02_5.spc');
%plot_spectra([sample_02_4(:,1:2) sample_02_4(:,1) sample_02_4(:,3)],{'-k';'-r'}),axis tight
%figure,plot_spectra([sample_02_5(:,1:2) sample_02_5(:,1) sample_02_5(:,3)],{'-k';'-r'}),axis tight