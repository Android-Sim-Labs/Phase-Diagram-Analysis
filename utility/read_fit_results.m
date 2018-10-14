function varargout = read_fit_results(filename)
% read_fit_results:  reads results of a fit from logfname and plots the
% results.
% input arguments: filename(string) = filename of both .log and .spc file
% number output arguments: empty = just plots the results
%                   one = structure containing the fit results and
%                   parameters

if ischar(filename)
    if exist(filename,'file')
        [pathstr,fname,ext,versn] = fileparts(filename);
        if strcmp(ext,'.log')
            output.logfile = fname;
            files.logfile = filename;
            if exist([fname '.spc'],'file')
                output.spcfile = fname;
                files.spcfile = [fname '.spc'];
            else
                error(sprintf('dir must contain a %s.spc file',fname));
            end
            if exist([fname '.run'],'file')
                output.runfile = fname;
                files.runfile = [fname '.run'];
            else
                error(sprintf('dir must contain a %s.run file',fname));
            end
        elseif strcmp(ext,'.spc')
            output.spcfile = fname;
            files.spcfile = filename;
            if exist([fname '.log'],'file')
                output.logfile = fname;
                files.logfile = [fname '.log'];
            else
                error(sprintf('dir must contain a %s.log file',fname));
            end
            if exist([fname '.run'],'file')
                output.runfile = fname;
                files.runfile = [fname '.run'];
            else
                error(sprintf('dir must contain a %s.run file',fname));
            end
        elseif strcmp(ext,'.run')
            output.runfile = fname;
            files.runfile = filename;
            if exist([fname '.spc'],'file')
                output.spcfile = fname;
                files.spcfile = [fname '.spc'];
            else
                error(sprintf('dir must contain a %s.spc file',fname));
            end
            if exist([fname '.log'],'file')
                output.logfile = fname;
                files.logfile = [fname '.log'];
            else
                error(sprintf('dir must contain a %s.log file',fname));
            end
        else
            error('filename must be for a .log, .spc, or .run file');
        end
    elseif exist([filename '.log'],'file')
        output.logfile = filename;
        files.logfile = [filename '.log'];
        if exist([filename '.spc'],'file')
            output.spcfile = filename;
            files.spcfile = [filename '.spc'];
        else
            error(sprintf('dir must contain a %s.spc file',filename));
        end
        if exist([filename '.run'],'file')
            output.runfile = filename;
            files.runfile = [filename '.run'];
        else
            error(sprintf('dir must contain a %s.run file',filename));
        end
    elseif exist([filename '.spc'],'file')
        output.spcfile = filename;
        files.spcfile = [filename '.spc'];
        if exist([filename '.log'],'file')
            output.logfile = filename;
            files.logfile = [filename '.log'];
        else
            error(sprintf('dir must contain a %s.log file',filename));
        end
        if exist([filename '.run'],'file')
            output.runfile = filename;
            files.runfile = [filename '.run'];
        else
            error(sprintf('dir must contain a %s.run file',filename));
        end
    elseif exist([filename '.run'],'file')
        output.runfile = filename;
        files.runfile = [filename '.run'];
        if exist([filename '.spc'],'file')
            output.spcfile = filename;
            files.spcfile = [filename '.spc'];
        else
            error(sprintf('dir must contain a %s.spc file',filename));
        end
        if exist([filename '.log'],'file')
            output.logfile = filename;
            files.logfile = [filename '.log'];
        else
            error(sprintf('dir must contain a %s.log file',filename));
        end
    else
        error(sprintf('dir must contain a %s.run, %s.spc, and a %s.log file',filename,filename,filename));
    end
else
    error('first argument is not a string');
end

spc = load_spc_files(files.spcfile);
output.spcdata = spc.data;
log_data = {'gib0','gib2','c20','c22','rprp','rpll','S0','S2','redchisq','status'};
log = read_log_files(log_data,files.logfile);
oldrunP = read_P_run_files(files.runfile);
if nargout == 0
    % plot fit results
    figure;
    plot_spectra([spc.data(:,[1 2]) spc.data(:,[1 3])],0,0,{'-k','-r'});
%     plot_spectra(spc.data(:,[1 2]));
%     hold on,plot_spectra(spc.data(:,[1 3]),0,0,{'-r'}),hold off;
    title(strrep(output.logfile,'_',' '));
else
    log_fields = fieldnames(log);
    log_fields = log_fields(~strcmp(log_fields,'filename'));
    run_fields = fieldnames(oldrunP);
    run_fields = run_fields(~strcmp(run_fields,'filename'));
    same_fields = intersect(log_fields,run_fields);
%     newrunP = oldrunP;
    for i = 1:length(log_fields)
        output.(log_fields{i}) = log.(log_fields{i});
    end
    for i = 1:length(run_fields)
        newrunP.(run_fields{i}) = oldrunP.(run_fields{i});
    end
    for i = 1:length(same_fields)
        newrunP.(same_fields{i}) = log.(same_fields{i});
    end
    output.oldrunP = oldrunP;
    output.newrunP = newrunP;
    varargout{1} = output;
end

return

% if ischar(logfname)
%     if exist(logfname,'file')
%         [pathstr,lfname,ext,versn] = fileparts(logfname);
%         if strcmp(ext,'.log')
%             output.logfile = lfname;
%             files.logfile = logfname;
%             if exist([lfname '.run'],'file')
%                 output.runfile = lfname;
%                 files.runfile = [lfname '.run'];
%             else
%                 error(sprintf('dir must contain a %s.run file',lfname));
%             end
%             if ischar(spcfname)
%                 if exist(spcfname,'file')
%                     [pathstr,sfname,ext,versn] = fileparts(spcfname);
%                     if strcmp(ext,'.spc')
%                         if strcmp(lfname,sfname)
%                             output.spcfile = sfname;
%                             files.spcfile = spcfname;
%                         else
%                             error('log filename must equal spc filename');
%                         end
%                     else
%                         error('2nd file is not a .spc file');
%                     end
%                 elseif exist([spcfname '.spc'],'file')
%                     sfname = [spcfname '.spc'];
%                     if strcmp(lfname,spcfname)
%                         output.spcfile = spcfname;
%                         files.spcfile = sfname; 
%                     else
%                         error('log filename must equal spc filename');
%                     end
%                 else
%                     error('spc file does not exist');
%                 end
%             else
%                 error('second argument is not a string');
%             end
%         else
%             error('1st file is not a .log file');
%         end
%     elseif exist([logfname '.log'],'file')
%         lfname = [logfname '.log'];
%         output.logfile = logfname;
%         files.logfile = lfname;
%         if exist([logfname '.run'],'file')
%             output.runfile = logfname;
%             files.runfile = [logfname '.run'];
%         else
%             error(sprintf('dir must contain a %s.run file',logfname));
%         end
%         if ischar(spcfname)
%             if exist(spcfname,'file')
%                 [pathstr,sfname,ext,versn] = fileparts(spcfname);
%                 if strcmp(ext,'.spc')
%                     if strcmp(logfname,sfname)
%                         output.spcfile = sfname;
%                         files.spcfile = spcfname;
%                     else
%                         error('log filename must equal spc filename');
%                     end
%                 else
%                     error('2nd file is not a .spc file');
%                 end
%             elseif exist([spcfname '.spc'],'file')
%                 sfname = [spcfname '.spc'];
%                 if strcmp(logfname,spcfname)
%                     output.spcfile = spcfname;
%                     files.spcfile = sfname; 
%                 else
%                     error('log filename must equal spc filename');
%                 end
%             else
%                 error('spc file does not exist');
%             end
%         else
%             error('second argument is not a string');
%         end
%     else
%         error('log file does not exist');
%     end
% else
%     error('first argument is not a string');
% end