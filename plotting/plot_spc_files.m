function plot_spc_files(varargin)
% plot_spc_files: plots the spectral data within .spc files from a NLSL fit
% input arguments: varargin(string or cellstring) = filename(s)

if isempty(varargin)
    files = dir('*.spc');
    if isempty(files)
        disp('no spc files (.spc) in directory');
        return
    else
        nf = length(files);
        for i = 1:nf
            [pathstr,fname,ext,versn] = fileparts(files(i).name);
            files(i).filename = fname;
            spc = load_spc_files(fname);
            files(i).data = spc.data;
        end
    end
else
	nf = length(varargin);
	for i = 1:nf
        if ischar(varargin{i})
            if exist(varargin{i},'file')
                [pathstr,fname,ext,versn] = fileparts(varargin{i});
                if strcmp(ext,'.spc')
                    files(i).name = varargin{i};
                else
                    error(sprintf('file %d is not a .spc file',i));
                end
                files(i).filename = fname;
                spc = load_spc_files(fname);
                files(i).data = spc.data;
            elseif exist([varargin{i} '.spc'],'file')
                fname = [varargin{i} '.spc'];
                files(i).name = fname;
                files(i).filename = varargin{i};
                spc = load_spc_files(varargin{i});
                files(i).data = spc.data;
            else
                error(sprintf('spc file %d does not exist',i));
            end
        else
            error(sprintf('input argument %d is not a string',i));
        end
    end
end

nf = length(files);
for i = 1:nf
    figure('name',files(i).filename);
%     plot_spectra([fit_specs(:,1:2) fit_specs(:,1) fit_specs(:,3)],0,{'-k';'-r'});
    plot_spectra([files(i).data(:,[1 2]) files(i).data(:,[1 3])],0,0,{'-k','-r'});
%     title(sprintf('data and fit spectra for %s',strrep(name(1:9),'_',' ')));
    title(strrep(files(i).filename,'_',' '));
    xlabel('magnetic field (gauss)');
    legend('fit','data');
end

return
