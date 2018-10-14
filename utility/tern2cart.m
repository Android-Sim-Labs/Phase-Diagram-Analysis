function cart = tern2cart(tern,tcart_flag)
% tern2cart transforms the ternary coordinates in tern to cartesian
% coordinates outputted in cart
%
% tcart_flag must be 0 or 1:
% if 0, then cart = normal xy cartesian space coordinates
% if 1, then cart = 2D coordinates for ternary diagram space
% default is 0

[np,nd] = size(tern);

if ~isequal(nd,3)
    error('input coordinates must have three columns: [Xb Xa Xc]');
end

if any(any(tern < 0 | tern > 1))
    error('ternary coordinates must be between 0 and 1');
end

% sum of mole fractions must equal one
if all(sum(tern')) ~= 1
    error('sum of mole fractions must equal one');
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
    es = [1 0]; % [x y]
    ec = [cos(pi/3) sin(pi/3)]; % [x y]
    cart = tern(:,1)*es+tern(:,3)*ec;
    % A = [0 0];
    % B = [1 0];
    % C = [0.5 sin(pi/3)];
    % for i = 1:np
    %    Xb = tern(i,1);
    %    Xa = tern(i,2);
    %    Xc = tern(i,3);
    %    ptC_AC = [Xc*(C(1)-A(1)) Xc*(C(2)-A(2))];
    %    ptC_BC = [B(1)+Xc*(C(1)-B(1)) B(2)+Xc*(C(2)-B(2))];
    %    ptB_AB = [Xb*(B(1)-A(1)) Xb*(B(2)-A(2))];
    %    ptB_CB = [C(1)+Xb*(B(1)-C(1)) C(2)+Xb*(B(2)-C(2))];
    %    C1 = ptC_AC;
    %    C2 = ptC_BC;
    %    B1 = ptB_AB;
    %    B2 = ptB_CB;
        % equation for x and y given on the "mathworld" website for
        % line-line intersection
    %    X = det([det([C1(1) C1(2);C2(1) C2(2)]) C1(1)-C2(1); det([B1(1) B1(2);B2(1) B2(2)]) B1(1)-B2(1)])/det([C1(1)-C2(1) C1(2)-C2(2); B1(1)-B2(1) B1(2)-B2(2)]);
    %    Y = det([det([C1(1) C1(2);C2(1) C2(2)]) C1(2)-C2(2); det([B1(1) B1(2);B2(1) B2(2)]) B1(2)-B2(2)])/det([C1(1)-C2(1) C1(2)-C2(2); B1(1)-B2(1) B1(2)-B2(2)]); 
    %    cart(i,:) = [X Y];
    % end
else
    Xb = tern(:,1);
    Xa = tern(:,2);
    Xc = tern(:,3);
    X = Xb./(Xb+Xa);
    Y = Xc;
    cart = [X Y];
end 

return