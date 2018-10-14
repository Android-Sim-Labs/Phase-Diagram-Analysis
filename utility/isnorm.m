function torf = isnorm(vorm)
% vorm = vector or matrix, if matrix, then function operates on column
% vectors

if all(size(vorm) == 1) | ndims(vorm) > 2 % if scalar or multi-dimensional array
    error('argument must be a vector or matrix');
elseif all(size(vorm) > 1) % if matrix
    [nr,nc] = size(vorm);
    
    for i = 1:nc
        temp(i) = norm(vorm(:,i));
    end
    
    if all(round(temp*1000)/1000 == 1)
        torf = true;
    else
        torf = false;
    end
elseif any(size(vorm) == 1) % if vector
    vorm = norm(vorm);
    
    if isequal(round(vorm*1000)/1000,1)
        torf = true;
    else
        torf = false;
    end
end

return