function slope = angle2tan_slope(angle)
% converts angles to tangent slopes

if all(size(angle) > 1) 
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
    
    if isequal(angle(a),-pi) | isequal(angle(a),pi)
        slope(a) = Inf;
    elseif isequal(angle(a),pi/2)
        slope(a) = 0;
    elseif isequal(angle(a),-pi/2)
        slope(a) = 0;
    else
        slope(a) = cos(angle(a))/(-sin(angle(a)));
    end
end

return