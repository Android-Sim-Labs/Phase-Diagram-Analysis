function angle = pt2angle(pts,varargin)
% converts points to angles
% if varargin is empty, angles defined on a unit circle
% if varargin is a point, angles defined from that point
% angle = -pi:pi
% pt = [x y]

% like [THETA,RHO] = cart2pol(X,Y);

if any(size(pts) == 2)
    if size(pts,1) == 2
        pts = pts'; % convert to column [x y] form
    end 
    
    np = size(pts,1);
else
    error('pts must be a nx2 or 2xn matrix of points');
end

if isempty(varargin)
	for p = 1:np
        pt = pts(p,:)./norm(pts(p,:));% normalize to unit circle
        x = pt(1);
        y = pt(2);
        
        if isequal(x,0) & isequal(y,0)
            error('point can not be origin');
        end
        
        angle(p,1) = atan2(y,x);
%         [theta,rho] = cart2pol(x,y);
	end
else
    if isnumeric(varargin{1})
        if ismember(size(varargin{1}),[1 2;2 1],'rows')
            center = varargin{1};
            if size(center,1) == 2
                center = center'; % convert to column [x y] form
            end
            pts = pts-repmat(center,np,1);
            for p = 1:np
                pt = pts(p,:)./norm(pts(p,:));% normalize to unit circle
                x = pt(1);
                y = pt(2);
            
                if isequal(x,center(1)) & isequal(y,center(2))
                    error('point can not be origin or center');
                end
            
                angle(p,1) = atan2(y,x);
%                 [theta,rho] = cart2pol(x,y);
            end
        else
            error('second argument must be 1x2 or 2x1 point');
        end
    else
        error('second argument must be numeric');
    end
end

return