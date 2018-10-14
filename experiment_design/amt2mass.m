function mass = amt2mass(amt,comps)
% comps is a matrix (# samples x 3 or 2) of the mole fractions of lipids
% to get that composition.  1st col = sm, 2nd col = dopc, 3rd col = chol
% amt = amt in mmoles of total lipid
% Ms = molecular weight of sphingomyelin
% Md = molecular weight of DOPC
% Mc = molecular weight of cholesterol

Ms = 731.09;
Md = 786.12;
Mc = 386.66;

N = comps.*amt;

mass = N*[Ms;Md;Mc];
mass = mass./1000; % in grams

return