function plot_spectra(spectra,space,trans,plot_styles)
% plot_spectra plots either one spectrum or many spectra onto one graph
% either stacked on top of each other or not
%
% if spectra = 1 spectrum, then 1st col = B-field and 2nd col = spectrum
% values, either difference or absorbance
% if spectra = > 1 spectrum, then col [1 2] = [B-field spectrum], 
% col [3 4] =  another [B-field spectrum], ...
%
% varargin = linestyles for the plot or each spectrum, see LineSpec
% the size of varargin = [number_spectrum length(plot_style_string)] 

[np,nc] = size(spectra);

if nc < 2 || rem(nc,2) ~= 0
    error('each spectrum must contain 2 columns: [B-field absorbance_values]');
end

ns = nc/2;

spacing = 0;
translation = 0;
styles = cell(ns,1);
styles = repmat({{'-k'}},[ns 1]);

if nargin > 1
    spacing = space;
end

if nargin > 2
    translation = trans;
end

if nargin > 3
    if iscell(plot_styles)
        nstyles = length(plot_styles);
        
        for i = 1:nstyles
            if iscell(plot_styles{i})
                nprops(i) = length(plot_styles{i});
                
                for k = 1:nprops(i)
                    if iscell(plot_styles{i}{k})
                        error('each plotting property must be a string or number');
                    end
                end
            elseif ischar(plot_styles{i})
                nprops(i) = 1;
                % repack plot style
                plot_styles{i} = {plot_styles{i}};
            else
                error('plotting properties must be either a cell array or a string');
            end
        end    
    else
        error('plot_styles input argument must be a cell array containing plotting specifications for each spectrum, see LineSpec');
    end
        
    if nstyles < ns
        r = rem(ns,nstyles);
        nsm = ns-r;
        styles = repmat(plot_styles,[nsm/nstyles 1]);
    
        for i = 1:r
            styles{nsm+i} = plot_styles{i};
        end
    else
        styles = plot_styles;
    end    
end

% plot spectra so that top spectrum is first two columns of spectra and bottom
% spectrum is last two columns of spectra

%if isempty(get(gcf,'children')) 
%    set(gcf,'name','spectra');
%else
%    if ~strcmp(get(gcf,'name'),'spectra')
%        figure('name','spectra');
%    end
%end

hold on
for i = fliplr([1:ns])
    plot(spectra(:,i*2-1),spectra(:,i*2)+(ns-i)*spacing+translation,styles{i}{:});
end
hold off
axis tight;
    
% find(~any(isnan(alined_spec),2))
% s = [repmat({'-b'},[7 1]);repmat({'-r'},[7 1]);...
%                repmat({'-k'},[3 1]);repmat({'-b'},[3 1])];

return