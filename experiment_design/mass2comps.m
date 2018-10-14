function comps = mass2comps(mass,amt,Msolid,Mfluid)
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

M = [Ms Md Mc;1 1 1];

% X*[Ms Md Mc]' = mass./amt;
for i = 1:length(mass)
    X = M\[mass(i)/amt(i);1];
%     X = lsqlin(M,[mass(i)/amt(i);1],[],[],[],[],0,1);
    comps(i,:) = X';
end

return