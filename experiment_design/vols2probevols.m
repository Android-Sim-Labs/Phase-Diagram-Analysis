function probe_vols = vols2probevols(vols,probe_frac,Cp,Mp,Cs,Cd,Cc,Msolid,Mfluid)
% probe_vols = vols2probevols(vols,probe_frac,Cp,Mp,Cs,Cd,Cc,Msolid,Mfluid)
% vols is a matrix with size number sample x 3 containing the volumes of the lipid stocks to add
% for the desired sample
% probe_frac is the mole percent of lipid that is probe
% Cp is the concentration of the probe in mg/ml
% Mp is the molecular weight of the probe

% Msolid = molecular weight of solid-forming lipid at room temp
% Mfluid = molecular weight of fluid-forming lipid at room temp
% Mc = molecular weight of cholesterol

Ms = Msolid;
Md = Mfluid;
Mc = 386.66; 

lipid_amts(:,1) = (vols(:,1).*Cs)./Ms;
lipid_amts(:,2) = (vols(:,2).*Cd)./Md;
lipid_amts(:,3) = (vols(:,3).*Cc)./Mc;

lipid_amts = sum(lipid_amts,2);

probe_amts = probe_frac.*lipid_amts;
probe_vols = (probe_amts.*Mp)./Cp;

return