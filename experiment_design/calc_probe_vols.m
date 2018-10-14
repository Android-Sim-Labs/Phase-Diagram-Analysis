function probe_vols = calc_probe_vols(vols,probe_frac,Cs,Cd,Cc,Cp,Mp)
% vols is a matrix with size number sample x 3 containing the volumes of the lipid stocks to add
% for the desired sample
% probe_frac is the mole percent of lipid that is probe
% Cp is the concentration of the probe in mg/ml
% Mp is the molecular weight of the probe

Ms = 731.09;
Md = 786.12;
Mc = 386.66;

lipid_amts(:,1) = (vols(:,1).*Cs)./Ms;
lipid_amts(:,2) = (vols(:,2).*Cd)./Md;
lipid_amts(:,3) = (vols(:,3).*Cc)./Mc;

lipid_amts = sum(lipid_amts,2);

probe_amts = probe_frac.*lipid_amts;
probe_vols = (probe_amts.*Mp)./Cp;

return