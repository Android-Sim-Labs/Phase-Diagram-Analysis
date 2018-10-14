function varargout = comps2vols(comps,MorN,x,Cs,Cd,Cc,Msolid,Mfluid)
% varargout = comps2vols(comps,MorN,x,Cs,Cd,Cc,Msolid,Mfluid)
% comps is a matrix (# samples x 3 or 2) of the mole fractions of lipids 
% to get that composition.  1st col = sm, 2nd col = dopc, 3rd col = chol
% MorN = 'mass' or 'amt' to keep constant
% x = scalar or vector = mass (mg) or amt(mmoles) per composition
% Cs = concentration mg/ml of sphingomyelin stock
% Cd = concentration mg/ml of DOPC stock
% Cc = concentration mg/ml of cholesterol stock

% Msolid = molecular weight of solid-forming lipid at room temp
% Mfluid = molecular weight of fluid-forming lipid at room temp
% Mc = molecular weight of cholesterol

Ms = Msolid;
Md = Mfluid;
Mc = 386.66; 

[nc,nd] = size(comps);
if nd ~= 3
    error('composition matrix must have 3 columns for ternary coordinates [X Y Z], if binary let one column be zeros');
end

Xs = comps(:,1);
Xd = comps(:,2);
Xc = comps(:,3);

if strcmp(MorN,'mass')
    mass = true;
    amt = false;
    if all(size(x) == 1) % isscalar, total mass for all comps constant
        M = repmat(x,nc,1);
    elseif any(size(x) == 1) % isvector, total mass for each comp varies
        M = x;
    else % ifmatrix
        error('third argument cannot be a matrix');
    end
%     M = M.*1000; % convert mass to milligrams
elseif strcmp(MorN,'amt')
    mass = false;
    amt = true;
    if all(size(x) == 1) % isscalar, total amt for all comps constant
        N = repmat(x,nc,1);
    elseif any(size(x) == 1) % isvector, total amt for each comp varies
        N = x;
    else % ifmatrix
        error('third argument cannot be a matrix');
    end
else
    error('second argument must be the string "mass" or "amt" specifying which to control or be constant');
end

if mass
%     for i = 1:nc
%         A = [Cs Cd Cc; (1-Xs(i))*Cs/Ms -Xs(i)*Cd/Md -Xs(i)*Cc/Mc; -Xd(i)*Cs/Ms (1-Xd(i))*Cd/Md -Xd(i)*Cc/Mc; -Xc(i)*Cs/Ms -Xc(i)*Cd/Md (1-Xc(i))*Cc/Mc];
%         B = [M(i); 0; 0; 0];
%         x = A\B;
%         vols(i,:) = x';
%     end
    
    N = M./(Xs*Ms + Xd*Md + Xc*Mc); 
    vols = (N*([Ms Md Mc]./[Cs Cd Cc])).*comps; 

%     N = M./(Xs.*Ms + Xd.*Md + Xc.*Mc);
% 	for i = 1:nc
%         n = comps(i,:).*N(i);
%         m = n.*[Ms Md Mc];
%         vols(i,:) = m./[Cs Cd Cc];
% 	end
end

if amt  
    vols = (N*([Ms Md Mc]./[Cs Cd Cc])).*comps;
    M = (comps*[Ms Md Mc]').*N;
    
% 	for i = 1:nc
%         n = comps(i,:).*N(i);
%         m = n.*[Ms Md Mc];
%         vols(i,:) = m./[Cs Cd Cc];
%         M(i,1) = sum(m);
% 	end
end

% for i=1:nc
%     A = [Cs/Ms Cd/Md Cc/Mc; (1-Xs(i))*Cs/Ms -Xs(i)*Cd/Md -Xs(i)*Cc/Mc; -Xd(i)*Cs/Ms (1-Xd(i))*Cd/Md -Xd(i)*Cc/Mc; -Xc(i)*Cs/Ms -Xc(i)*Cd/Md (1-Xc(i))*Cc/Mc];
%     B = [amt; 0; 0; 0];
%     x = A\B;
%     vols(i,:) = x';
% end

%A = [Cs Cd Cc; ((Cs/Ms)-(comps(i,1)*Cs/Ms)) -Cd*comps(i,1)/Md 0; -comps(i,2)*Cs/Ms -comps(i,2)*Cd/Md ((Cc/Mc)-(comps(i,2)*Cc/Mc))];
%B = [mass; 0; 0];
%x = A\B;
%vols(i,:)=x';

vols = vols.*1000.0; %convert from ml to ul

if mass
    varargout{1} = vols;
    varargout{2} = N;
end

if amt
    varargout{1} = vols;
    varargout{2} = M./1000; % convert mass to grams
end

return