function v = shift_vector(v,shift);
% shift must = either positive or negative integer

if any(size(v) == 1)
    lv = length(v);
    temp = zeros(size(v));
    i = [1:lv];
    si = i+shift;
    [c,ii,isi] = intersect(i,si);
    temp(ii) = v(isi);
    v = temp;
else
    error('first argument must be a vector');
end

return