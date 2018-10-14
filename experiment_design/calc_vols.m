function vols = calc_vols(comps,Cs,Cd,Cc)
% comps is a matrix (# samples x 2) of the compositions of the samples to calculate the volumes of the stock solutions
% to get that composition

% Ms = molecular weight of sphingomyelin
% Cs = concentration mg/ml of sphingomyelin stock
% Md = molecular weight of DOPC
% Cd = concentration mg/ml of DOPC stock
% Mc = molecular weight of cholesterol
% Cc = concentration mg/ml of cholesterol stock

Ms = 731.09;
Md = 786.12;
Mc = 386.66;

for i=1:size(comps,1)
    A = [Cs Cd Cc; ((Cs/Ms)-(comps(i,1)*Cs/Ms)) -Cd*comps(i,1)/Md 0; -comps(i,2)*Cs/Ms -comps(i,2)*Cd/Md ((Cc/Mc)-(comps(i,2)*Cc/Mc))];
    B = [2; 0; 0];
    x = A\B;
    vols(i,:)=x';
end
vols=vols.*1000.0; %in microliters

%A = [7.5 31.9 10.2; ((7.5/731.09)-(0.9*7.5/731.09)) -31.9*0.9/786.12 0; -0.5*7.5/731.09 -0.5*31.9/786.12 ((10.2/386.66)-(0.5*10.2/386.66))]
%B = [2; 0; 0]
%x = A\B