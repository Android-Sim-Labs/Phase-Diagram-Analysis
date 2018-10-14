function plot_fit_files(varargin)
% plot_fit_files: plots the spectral data within .spc files from a NLSL fit
% input arguments: varargin(string or cellstring) = filename(s)

nf = length(varargin);

if nf == 0
    files = dir('*.spc');
    nf = length(files);
end

for i = 1:nf
    if nargin < 1
        fname = files(i).name;
    else
        fname = varargin{i};
    end
    
    [pathstr,name,ext,versn] = fileparts(fname);
    
    if isempty(ext)
        fit_specs = load([name '.spc'],'-ascii');
    else
        fit_specs = load(fname,'-ascii');
    end
    
    if isnumeric(fit_specs)
        figure('name',fname);
        %title(strrep(name,'_',' '));
        plot_spectra([fit_specs(:,1:2) fit_specs(:,1) fit_specs(:,3)],0,{'-k';'-r'});
        title(sprintf('data and fit spectra for %s',strrep(name(1:9),'_',' ')));
        xlabel('magnetic field (gauss)');
        legend('fit','data');
        axis tight;
    else
        error('one input argument is not a numeric array');
    end
end

return
