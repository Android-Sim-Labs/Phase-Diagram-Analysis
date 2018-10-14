function angle = slope2angle(slope)
% converts slopes to angles
% angle = -pi/2:pi/2

if all(size(slope) > 1) | ndims(slope) > 2
    error('angle must be a scalar or vector');
end

for s = 1:length(slope)
    if isequal(slope(s),Inf) 
        angle(s) = pi/2;
    elseif isequal(slope(s),-Inf);
        angle(s) = -pi/2;
    elseif isequal(slope(s),0)
        angle(s) = 0;
    else
        % atan return range = -pi/2:pi/2
        angle(s) = atan(slope(s));
    end
end

return