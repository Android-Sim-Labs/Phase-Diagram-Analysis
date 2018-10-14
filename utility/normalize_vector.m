function vorm = normalize_vector(vorm)
% vorm = vector or matrix, if matrix, then function operates on column
% vectors

if all(size(vorm) == 1) || ndims(vorm) > 2 % if scalar or multi-dimensional array
    error('argument must be a vector or matrix');
elseif all(size(vorm) > 1) % if 2D matrix
    [nr,nc] = size(vorm);
    
    for i = 1:nc
        temp(i) = norm(vorm(:,i));
    end
    
    vorm = vorm./repmat(temp,nr,1);
elseif any(size(vorm) == 1) % if vector
    vorm = vorm/norm(vorm);
end

return