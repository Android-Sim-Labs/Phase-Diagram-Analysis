function slope = angle2slope(angle)
% converts angles to slopes
% angle = -pi:pi

if all(size(angle) > 1) | ndims(angle) > 2
    error('angle must be a scalar or vector');
end

for a = 1:length(angle)
    if angle(a) < -pi 
        % convert to angle range -pi:pi
        while angle(a) < -pi 
            angle(a) = angle(a)+pi;
        end
    end
    
    if angle(a) > pi 
        % convert to angle range -pi:pi
        while angle(a) > pi 
            angle(a) = angle(a)-pi;
        end
    end
    
    if isequal(angle(a),-pi) || isequal(angle(a),pi)
        slope(a) = 0;
    elseif isequal(angle(a),pi/2)
        slope(a) = Inf;
    elseif isequal(angle(a),-pi/2)
        slope(a) = -Inf;
    else
        slope(a) = tan(angle(a));
    end
end

return