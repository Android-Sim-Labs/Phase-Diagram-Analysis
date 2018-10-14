function pt = angle2pt(angle,varargin)
% converts angles to points
% points and angles defined on a unit circle
% angle = -pi:pi
% pt = [x y]

% like [X,Y] = pol2cart(THETA,RHO)

if all(size(angle) > 1) | ndims(angle) > 2
    error('angle must be a scalar or vector');
end

if isempty(varargin)
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
            pt(a,:) = [-1 0];
        elseif isequal(angle(a),pi/2)
            pt(a,:) = [0 1];
        elseif isequal(angle(a),-pi/2)
            pt(a,:) = [0 -1];
        elseif isequal(angle(a),0)
            pt(a,:) = [1 0];
        else
            pt(a,:) = [cos(angle(a)) sin(angle(a))];
        end
	end
else
    if isnumeric(varargin{1}) & isempty(varargin{2}) 
        if all(size(varargin{1}) == 1) % isscalar(varargin{1})
            r = varargin{1};
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
                    pt(a,:) = [-r 0];
                elseif isequal(angle(a),pi/2)
                    pt(a,:) = [0 r];
                elseif isequal(angle(a),-pi/2)
                    pt(a,:) = [0 -r];
                elseif isequal(angle(a),0)
                    pt(a,:) = [r 0];
                else
                    pt(a,:) = [r*cos(angle(a)) r*sin(angle(a))];
                end
			end
        elseif ismember(size(varargin{1}),[1 2;2 1],'rows')
            center = varargin{1};
            if size(center,1) == 2
                center = center'; % convert to column [x y] form
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
                    pt(a,:) = [-1 0];
                elseif isequal(angle(a),pi/2)
                    pt(a,:) = [0 1];
                elseif isequal(angle(a),-pi/2)
                    pt(a,:) = [0 -1];
                elseif isequal(angle(a),0)
                    pt(a,:) = [1 0];
                else
                    pt(a,:) = [cos(angle(a)) sin(angle(a))];
                end
            end
            pt = pt+repmat(center,length(angle),1);
        else
            error('second argument must be a scalar or an 1x2 or 2x1 point');
        end    
    elseif isnumeric(varargin{1}) & isnumeric(varargin{2})
        if all(size(varargin{1}) == 1)
            r = varargin{1};
            if ismember(size(varargin{2}),[1 2;2 1],'rows')
                center = varargin{2};
                if size(center,1) == 2
                    center = center'; % convert to column [x y] form
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
                        pt(a,:) = [-r 0];
                    elseif isequal(angle(a),pi/2)
                        pt(a,:) = [0 r];
                    elseif isequal(angle(a),-pi/2)
                        pt(a,:) = [0 -r];
                    elseif isequal(angle(a),0)
                        pt(a,:) = [r 0];
                    else
                        pt(a,:) = [r*cos(angle(a)) r*sin(angle(a))];
                    end
                end
                pt = pt+repmat(center,length(angle),1);
            else
                error('third argument must be nx2 or 2xn point(s)');
            end 
        else
            error('second argument must be a scalar');
        end
    else
        error('second argument must be numeric');
    end
end

return