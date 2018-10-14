function tern = cart2tern(cart,tcart_flag)
% tern = cart2tern(cart,tcart_flag)
% transforms cartesian coordinates in cart into ternary coordinates
% outputted into tern
%
% tcart_flag must be a 0 or 1:
% if 0 then cart = normal xy cartesian space coordinates
% if 1 then cart = 2D coords for space within ternary diagram space
% default is 0

[np,nd] = size(cart);

if nd ~= 2
    error('input coordinates must have two columns: [X Y]');
end

if any(any(cart < 0 | cart > 1))
    error('cartesian coordinates must be between 0 and 1');
end
    
tcart = false;

if nargin > 1
    if tcart_flag ~= 0 && tcart_flag ~= 1
        error('second argument must be 0 or 1');
    else
        if tcart_flag == 1
            tcart = true;
        end
    end
end

if tcart
    X = cart(:,1);
    Y = cart(:,2);
    Xc = Y./sin(pi/3);
    Xb = X-(Xc.*cos(pi/3));
    Xa = 1-Xb-Xc;
    tern = [Xb Xa Xc]; % sm dopc chol
%     A = [0 0];
%     B = [1 0];
%     C = [0.5 sin(pi/3)];
%     for i = 1:np
%         % slope for line parallel to side AC = (A(2)-C(2))/(A(1)-C(1))
%         m = sin(pi/3)/0.5;
%         % for y = 0
%         X = cart(i,1);
%         Y = cart(i,2);
%         Xb = X-(Y/m);
%         Xc = Y/sin(pi/3);
%         Xa = 1-Xb-Xc;
%         tern(i,:) = [Xb Xa Xc]; % sm dopc chol
%     end
else
    X = cart(:,1);
    Y = cart(:,2);
    Xb = X.*(1-Y);
    Xa = (1-X).*(1-Y);
    Xc = Y; 
    tern = [Xb Xa Xc];
end

% sum of mole fractions must equal one
if all(sum(tern')) ~= 1
    error('sum of mole fractions must equal one, cartesian point lies outside Gibbs triangle');
end

return