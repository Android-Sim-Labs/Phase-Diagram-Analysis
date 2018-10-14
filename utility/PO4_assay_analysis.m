function  [C,std_C,gof] = PO4_assay_analysis(date,Vstds,Astds,varargin)
% PO4_assay_analysis plots the standard curve and processes sample absorbance data 
% to output the average nmoles of the samples and the PO4 concentration of the samples 
% varargin = Asample1,vol_sample1,Msample1,Asample2,vol_sample2,Msample2,etc...

hold on;
% Ms = 731.09;
% Md = 786.12;
% nmolesPO4 = [0:2:28]'*5.263;
nmolesPO4 = Vstds*5.263;
plot(Astds,nmolesPO4,'.k','markersize',10);
% i = find(isnan(standards));
% standards(i) = [];
% nmolesPO4(i) = [];
[fit_result,gof,output] = fit(Astds,nmolesPO4,'poly1');
plot(fit_result);
title(['PO4 assay ',date],'HorizontalAlignment','center','FontSize',12,'fontweight','bold');
xlabel('A820');
ylabel('nmolesPO4');
p1 = fit_result.p1;
p2 = fit_result.p2;

nsamples = length(varargin)/3;

for i = 1:nsamples
    Asamples(:,i) = varargin{i*3-2};
    Vsamples(i) = varargin{i*3-1};
    Msamples(i) = varargin{i*3};
    nmoles(:,i) = feval(fit_result,Asamples(:,i));
end

avg_Asamples = mean(Asamples);
avg_nmoles = mean(nmoles);
std_nmoles = std(nmoles);
C = ((avg_nmoles./Vsamples).*Msamples)/1000; % conc in mg/ml
std_C = ((std_nmoles./Vsamples).*Msamples)/1000;

% As = samples(:,1);
% Ad = samples(:,2);
% avg_As = mean(As);
% avg_Ad = mean(Ad);
% nms = feval(fit_result,As);
% nmd = feval(fit_result,Ad);
% avg_nms = mean(nms);
% avg_nmd = mean(nmd);
% std_nms = std(nms); % or std(nmolessm,1);
% std_nmd = std(nmd); % or std(nmolesdopc,1)
% Cs = avg_nms/vol_s; % volume of sm in microliters -> conc in mM
% Cd = avg_nmd/vol_d; % volume of dopc in microliters -> conc in mM
% Cs = (Cs*Ms)/1000; % conc in mg/ml
% Cd = (Cd*Md)/1000; % conc in mg/ml
% std_Cs = ((std_nms/vol_s)*Ms)/1000;
% std_Cd = ((std_nmd/vol_d)*Ms)/1000;

return