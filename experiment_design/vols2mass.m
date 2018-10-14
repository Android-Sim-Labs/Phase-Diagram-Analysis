function mass = vols2mass(vols,Cs,Cd,Cc,Msolid,Mfluid) 
% vols is a matrix (# samples x 3 or 2) of volumes in microliters of the lipid stocks 
% to get that composition.  1st col = sm, 2nd col = dopc, 3rd col = chol
% Cs = concentration mg/ml of sphingomyelin stock
% Cd = concentration mg/ml of DOPC stock
% Cc = concentration mg/ml of cholesterol stock

% Msolid = molecular weight of solid-forming lipid at room temp
% Mfluid = molecular weight of fluid-forming lipid at room temp
% Mc = molecular weight of cholesterol

Ms = Msolid;
Md = Mfluid;
Mc = 386.66; 

mass = (vols./1000)*[Cs;Cd;Cc];
mass = mass./1000; % in grams

return