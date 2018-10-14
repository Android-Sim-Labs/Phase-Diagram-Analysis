function amt = comps2amt(comps,mass,Msolid,Mfluid)
% comps is a matrix (# samples x 3 or 2) of the mole fractions of lipids
% to get that composition.  1st col = sm, 2nd col = dopc, 3rd col = chol
% amt = amt in mmoles of total lipid
% Msolid = molecular weight of solid-forming lipid at room temp
% Mfluid = molecular weight of fluid-forming lipid at room temp
% Mc = molecular weight of cholesterol

Ms = Msolid;
Md = Mfluid;
Mc = 386.66; 

mass = mass.*1000; % in milligrams

Xs = comps(:,1);
Xd = comps(:,2);
Xc = comps(:,3);

amt = mass./(Ms.*Xs + Md.*Xd + Mc.*Xc); % in millimoles

return