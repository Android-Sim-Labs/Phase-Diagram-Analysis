function spectra = measure_fit_qual(metric,varargin)

if ~ischar(metric)
    error('the metric to measure fit quality must be a string');
end

% spectra = struct('filename',{},'dist',{});

if nargin < 2
    files = dir('*.spc');
    nf = length(files);
    filenames = cell(nf,1);
    distances = repmat(NaN,nf,1);
    
    for i = 1:nf
        fit_specs = load(files(i).name,'-ascii');
        filenames{i} = files(i).name;
        distances(i) = pdist(fit_specs(:,2:3)',metric);
        % spectra(i).filename = files(i).name;
        % spectra(i).dist = pdist(fit_specs(:,2:3)',metric);
    end
else
    nf = length(varargin);
    filenames = cell(nf,1);
    distances = repmat(NaN,nf,1);
  
    for i = 1:nf
        if ischar(varargin{i})
            fname = varargin{i};
            fit_specs = load(fname,'-ascii');
            filenames{i} = files(i).name;
            distances(i) = pdist(fit_specs(:,2:3)',metric);
            % spectra(i).filename = fname;
            % spectra(i).dist = pdist(fit_specs(:,2:3)',metric);
        else
            error('input argument must be a cell array of filenames or a single filename');
        end
    end 
end

[distances,indices] = sort(distances);
filenames = {filenames{indices}}';
spectra.filenames = filenames;
spectra.dists = distances;

return