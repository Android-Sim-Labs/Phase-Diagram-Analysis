function mass = comps2mass(comps,amt,Msolid,Mfluid)
% comps is a matrix (# samples x 3 or 2) of the mole fractions of lipids
% to get that composition.  1st col = sm, 2nd col = dopc, 3rd col = chol
% amt = amt in mmoles of total lipid
% Msolid = molecular weight of solid-forming lipid at room temp
% Mfluid = molecular weight of fluid-forming lipid at room temp
% Mc = molecular weight of cholesterol

Ms = Msolid;
Md = Mfluid;
Mc = 386.66; 

N = comps.*amt;
% Ns = N(:,1);
% Nd = N(:,2);
% Nc = N(:,3);

mass = N*[Ms;Md;Mc];
mass = mass./1000; % in grams

return