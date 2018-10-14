function amt = vols2amt(vols,Cs,Cd,Cc,Msolid,Mfluid)
% vols2amt calculates the amt of lipid per sample given the experimental
% volume of each stock added to the samples
%
% vols = [sm dopc chol]

% molecular weight of lipid (mg/mmol]
% Msolid = molecular weight of solid-forming lipid at room temp
% Mfluid = molecular weight of fluid-forming lipid at room temp
% Mc = molecular weight of cholesterol

Ms = Msolid;
Md = Mfluid;
Mc = 386.66; 

amt = (vols/1000)*([Cs Cd Cc]./[Ms Md Mc])'; % in mmoles

% for i = 1:size(vols,1)
%     Ns = ((vols(i,1)/1000)*Cs)/Ms; % number of moles in mmol
%     Nd = ((vols(i,2)/1000)*Cd)/Md; % number of moles in mmol
%     Nc = ((vols(i,3)/1000)*Cc)/Mc; % number of moles in mmol
%     N(i,1) = Ns+Nd+Nc;
% end
% 
% amt = N;

return