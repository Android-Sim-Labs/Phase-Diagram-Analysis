function int_pts = circle_line_int(center,r,varargin)
% circle is unit circle by default
% line is given as a 2x2 matrix specifying 2 points on the line

% determines the intersection points of a line with the unit circle
% m = slope of line
% pt = point on the line

if nargin < 2
    error('not enough input arguments');
else
    if ischar(varargin{1})
        switch varargin{1}
            case 'pt-m'
                if isempty(varargin{2})
                    error('please specify the slope of the line');
                else
                    m = varargin{2};
                end
                if isempty(varargin{3})
                    error('please specify the pt of the line');
                else
                    pt = varargin{3};
                end
                
                % declare line in point-slope form
				lin = inline('m*(x-x1)+y1','m','x','x1','y1');
				
				if ~isequal(size(pt,2),2)
                    error('pt must be of form [x y]');
				end
				
				x1 = pt(1);
				y1 = pt(2);
                    
				if isequal(m,Inf) | isequal(m,-Inf);
                    x2 = x1;
                    y2 = y1+1;
				elseif isequal(m,0)
                    x2 = x1+1;
                    y2 = y1;
                else  
                    x2 = x1+1;
                    y2 = lin(m,x2,x1,y1);
				end
            case '2pts'
                if isempty(varargin{2})
                    error('please specify the 2 points of the line');
                else
                    lin = varargin{2};
                end
                if all(size(lin) == 2) & ndims(lin) == 2
                    % line (lin) contains points (x1,y1) and (x2,y2)
                    x1 = lin(1,1);
                    y1 = lin(1,2);
                    x2 = lin(2,1);
                    y2 = lin(2,2);
                else
                    error('line must be a 2x2 matrix [x1 y1;x2 y2] specifying 2 points on line');
                end
            otherwise
                error('first input argument must be the form of the line: either "pt-m" or "2pts"');
        end
    else
        error('first input argument must be the form of the line: either "pt-m" or "2pts"');
    end
end      

% the following is from this website:  http://astronomy.swin.edu.au/~pbourke/geometry/sphereline/
x3 = center(1);
y3 = center(2);
a = (x2 - x1)^2 + (y2 - y1)^2;
b = 2*((x2 - x1)*(x1 - x3) + (y2 - y1)*(y1 - y3));
c = x3^2 + y3^2 + x1^2 + y1^2 - 2*(x3*x1 + y3*y1) - r^2;
u1 = (-b + sqrt(b^2 - 4*a*c))/(2*a);
u2 = (-b - sqrt(b^2 - 4*a*c))/(2*a);
num = b^2 - 4*a*c;
x = x1 + u1*(x2 - x1);
y = y1 + u1*(y2 - y1);
p1 = [x y];
x = x1 + u2*(x2 - x1);
y = y1 + u2*(y2 - y1);
p2 = [x y];

if num < 0 % no intersection
    int_pts = [];
elseif num == 0 % tangent intersection
    int_pts = p1;
elseif num > 0 % 2 intersections
    if strcmp(varargin{1},'2pts')
        if norm(p1-[x1 y1]) < norm(p2-[x1 y1])
            int_pts(1,:) = p1;
            int_pts(2,:) = p2;
        else
            int_pts(1,:) = p2;
            int_pts(2,:) = p1;
        end
    else
        int_pts(1,:) = p1;
        int_pts(2,:) = p2;
    end
end

% equation for intersection points given on the "mathworld" website for
% circle-line intersection
% dx = x2-x1;
% dy = y2-y1;
% dr = sqrt(dx^2+dy^2);
% D = det([x1 x2; y1 y2]);
%     
% if sign(dy) == 0
%     sdy = 1;
% else
%     sdy = sign(dy);
% end
%  
% p2 = [(D*dy+sdy*dx*sqrt(dr^2-D^2))/dr^2 (-D*dx+abs(dy)*sqrt(dr^2-D^2))/dr^2];
% p1 = [(D*dy-sdy*dx*sqrt(dr^2-D^2))/dr^2 (-D*dx-abs(dy)*sqrt(dr^2-D^2))/dr^2];
% 
% if dr^2-D^2 < 0 % no intersection
%     int_pts = [];
% elseif dr^2-D^2 == 0 % tangent intersection
%     int_pts = p1;
% elseif dr^2-D^2 > 0 % 2 intersections
%     if strcmp(varargin{1},'2pts')
%         if norm(p1-[x1 y1]) < norm(p2-[x1 y1])
%             int_pts(1,:) = p1;
%             int_pts(2,:) = p2;
%         else
%             int_pts(1,:) = p2;
%             int_pts(2,:) = p1;
%         end
%     else
%         int_pts(1,:) = p1;
%         int_pts(2,:) = p2;
%     end
% end

return