function d = pt2lin_dist(pt,lin)

if all(size(lin) == [2 2])
    if size(pt,1) == 2
        % pt is column vector
        ptA = lin(:,1);
        ptB = lin(:,2);
%         x0 = pt(1);
%         y0 = pt(2);
%         x1 = lin(1,1);
%         y1 = lin(2,1);
%         x2 = lin(1,2);
%         y2 = lin(2,2);
    end

    if size(pt,2) == 2
        % pt is row vector
        pt = pt';
        ptA = lin(1,:)';
        ptB = lin(2,:)';
%         x0 = pt(1);
%         y0 = pt(2);
%         x1 = lin(1,1);
%         y1 = lin(1,2);
%         x2 = lin(2,1);
%         y2 = lin(2,2);
       
    end

    if all(diff(lin) == [0 0])
        d = norm(pt-ptA);
%         d = sqrt(((x0-x1)^2)+(y0-y1)^2);
    else
        d = abs(det([(ptB-ptA) (ptA-pt)]))/norm(ptB-ptA);
%         d = -((x2-x1)*(y1-y0)-(x1-x0)*(y2-y1))/sqrt(((x2-x1)^2)+(y2-y1)^2);
    end
else
    error('line must be a 2x2 matrix specifying a line by 2 points');
end

% if all(size(lin) == [2 3])
%     x0 = pt;
%     x1 = lin(1,:);
%     x2 = lin(2,:);
%     d = norm(cross(x2-x1,x1-x0))/norm(x2-x1);
% else
%     error('line must be a 2x3 matrix specifying a line by 2 points');
% end

return