function  v = split_vector(v,split)
% v = vector
% split = indices of split positions

if any(size(v) == 1)
    lv = length(v);
    ls = length(split);
    temp = repmat(NaN,size(v));
    temp(end+ls) = NaN;
    split = sort(split);
    iv = 1;
    n = 1;
    while iv <= lv
        if any(iv == split)
            n = n+1;  
        end
        temp(n) = v(iv);
        iv = iv+1;
        n = n+1; 
    end
    v = temp;       
%     i = [1:lv];
%     nots = setxor(i,split); % or nots = setdiff(i,split)
%     temp(nots) = v(nots); 
else
    error('first argument must be a vector');
end

return