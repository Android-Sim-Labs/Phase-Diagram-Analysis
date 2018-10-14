function int_pt = line_line_int(lina,linb)
% equation for x and y given on the "mathworld" website for
% line-line intersection

if all(size(lina) == 2) & ndims(lina) == 2
    % line a (lina) contains points (x1,y1) and (x2,y2)
    x1 = lina(1,1);
    y1 = lina(1,2);
    x2 = lina(2,1);
    y2 = lina(2,2);
else
    error('line must be a 2x2 matrix [x1 y1;x2 y2] specifying 2 points on line');
end
    
if all(size(linb) == 2) & ndims(linb) == 2
    % line b (linb) contains points (x3,y3) and (x4,y4)
    x3 = linb(1,1);
    y3 = linb(1,2);
    x4 = linb(2,1);
    y4 = linb(2,2);
else
    error('line must be a 2x2 matrix [x1 y1;x2 y2] specifying 2 points on line');
end

warning off;
x = det([det([x1 y1; x2 y2]) x1-x2; det([x3 y3; x4 y4]) x3-x4])/det([x1-x2 y1-y2; x3-x4 y3-y4]);
y = det([det([x1 y1; x2 y2]) y1-y2; det([x3 y3; x4 y4]) y3-y4])/det([x1-x2 y1-y2; x3-x4 y3-y4]);
warning on;
int_pt = [x y];

if any(~isfinite(int_pt));
    int_pt = [];
end

return