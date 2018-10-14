function plot_fit_results(fit_results)
% plot_fit_results: plots the spectral data within the output structure
% from read_fit_results.
% input arguments: fit_results(struct) = contains data to be plot.

[ns,nt] = size(fit_results);% ns = # samples, nt = # trials

for s = 1:ns
    for t = 1:nt
        % plot fit results
        fname = fit_results(s,t).spcfile;
        if isempty(fname), continue, end
        spcdata = fit_results(s,t).spcdata;
        redchisq = fit_results(s,t).redChi2;
        figure('name',fname);
        plot_spectra([spcdata(:,[1 2]) spcdata(:,[1 3])],0,0,{'-k','-r'});
        title(sprintf('%s with redChisq = %f',strrep(fname,'_',' '),redchisq));
        xlabel('magnetic field (gauss)');
        legend('fit','data');
    end
end

return