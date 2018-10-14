function tern = traj2tern(Xtraj,mixes,tcart_flag)
% traj2ternt transforms the compositional positions along a linear 
% trajectory given in "Xtraj" with end point mole fractions in "mixes" to 
% ternary coordinates outputted in "tern"
%
% tcart_flag must be 0 or 1:
% if 0, then cart = normal xy cartesian space coordinates
% if 1, then cart = 2D coordinates for ternary diagram space
% default is 0

if  isvector(Xtraj) % any(size(Xtraj) == 1) & any(size(Xtraj) > 1) 
    [nrow,ncol] = size(Xtraj);
    
    if nrow == 1
        Xtrak = Xtraj';
    end
    if any(Xtraj < 0) || any(Xtraj > 1)
        error('cartesian coordinates must be between 0 and 1');
    end
else % if Xtraj is not a vector
    error('first argument must be a vector specifying compositional positions along trajectory');
end

[nm,nd] = size(mixes);
if isequal(nm,2) && any(nd == [2 3]) % all(size(mixes) == [2 3])
    mix_cart = false;
    mix_tern = true;
    if isequal(nd,2)
        mix_cart = true;
        mix_tern = false;
    end
else
    error('size of input mixes matrix must be [2 3] [2 2]');
end
  
tcart = false;
if nargin > 2
    if tcart_flag ~= 0 && tcart_flag ~= 1
        error('second argument must be 0 or 1');
    else
        if tcart_flag == 1
            tcart = true;
        end
    end
end

if tcart
    if mix_cart
        cart = [1-Xtraj Xtraj]*mixes;
        tern = cart2tern(cart,1);
    end
    if mix_tern
        tern = [1-Xtraj Xtraj]*mixes;
    end
else
    if mix_cart
        cart = [1-Xtraj Xtraj]*mixes;
        tern = cart2tern(cart);
    end
    if mix_tern
        tern = [1-Xtraj Xtraj]*mixes;
    end
end 

return