function int_pts = boundary_line_int(bdy,m,pt,varargin)
% determines the intersection points of a line with the boundary
% m = slope of line
% pt = point on the line

% declare line in point-slope form
lin = inline('m*(x-x1)+y1','m','x','x1','y1');

if ~isequal(size(pt,2),2)
    error('pt must be of form [x y]');
end

x1 = pt(1);
y1 = pt(2);
    
if isequal(m,Inf) || isequal(m,-Inf) || m > 1e5 || m < -1e5
    x = [x1;x1];
    y = [0;1];
elseif isequal(m,0) || (m > -1e-5 && m < 1e-5)
    x = [0;1];
    y = [y1;y1];
elseif m > 0 
    x = [0;1];
    y = lin(m,x,x1,y1);
elseif m < 0
    x = [1;0];
    y = lin(m,x,x1,y1);
else
    if isnan(m)
        error('slope is NaN');
    else
        error('slope undefined but not NaN');
    end
end
    
[xi,yi] = polyxpoly(bdy(:,1),bdy(:,2),x,y,'unique');

if isempty([xi yi])
    int_pts = [];
elseif isscalar(xi) & isscalar(yi)
    int_pts = [xi yi];
else
    % int_pts = [xi yi];
    pt1 = [xi(1) yi(1)];
    pt2 = [xi(2) yi(2)];
    
    if yi(1) > yi(2) % Xchol of pt1 > Xchol pt2, so pt1 = Lo
        int_pts = [pt2;pt1]; 
    elseif yi(1) < yi(2) % Xchol of pt1 < Xchol pt2, so pt1 = Ld
        int_pts = [pt1;pt2];
    else
        if xi(1) > xi(2) % Xsm of pt1 > Xsm pt2, so pt1 = Lo
            int_pts = [pt2;pt1];
        elseif xi(1) < xi(2) % Xsm of pt1 < Xsm pt2, so pt1 = Ld
            int_pts = [pt1;pt2];
        else
            error('intersection points of boundary and tie line are the same');
        end
    end
    
%     if isempty(int_pt) & isequal(length(p),2)
%         p1 = bdypt2b(bdy,pt1);
%         p2 = bdypt2b(bdy,pt2)
%         
%         if p1 > p(1) & p1 < p(2)
%             int_pts = [pt1;pt2];
%         elseif p1 < p(1) | p1 > p(2)
%             int_pts = [pt2;pt1];
%         elseif p2 > p(1) & p2 < p(2)
%             int_pts = [pt1;pt2];
%         elseif p2 < p(1) | p2 > p(2)
%             int_pts = [pt2;pt1];
%         else
%             error('boundary parameter for intersection points of the tie line with the boundary are not between 0 and 1');
%         end
%     elseif isempty(int_pt) & isequal(length(p),1)
%         if yi(1) > yi(2) % Xchol of pt1 > Xchol pt2, so pt1 = Lo
%             int_pts = [pt2;pt1]; % Xchol of pt1 < Xchol pt2, so pt1 = Ld
%         elseif yi(1) < yi(2)
%             int_pts = [pt1;pt2];
%         else
%             if xi(1) > xi(2) % Xsm of pt1 > Xsm pt2, so pt1 = Lo
%                 int_pts = [pt2;pt1];
%             elseif xi(1) < xi(2) % Xsm of pt1 > Xsm pt2, so pt1 = Lo
%                 int_pts = [pt1;pt2];
%             else
%                 error('intersection points of boundary and tie line are the same');
%             end
%         end
%     else
%         if norm(int_pt-pt1) <= norm(int_pt-pt2)
%             int_pts = [pt1;pt2];
%         else
%             int_pts = [pt2;pt1];
%         end
%     end
end

return