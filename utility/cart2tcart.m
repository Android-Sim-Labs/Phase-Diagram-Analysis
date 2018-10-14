function tcart = cart2tcart(cart)
% cart2tcart:  transforms normal cartesian coordinates into 2D cartesian
% coordinates for plotting on a ternary diagram space

[np,nd] = size(cart);

if nd ~= 2
    error('input coordinates must have two columns: [X Y]');
end

if any(any(cart < 0 | cart > 1))
    error('cartesian coordinates must be between 0 and 1');
end

tcart = tern2cart(cart2tern(cart),1);

return