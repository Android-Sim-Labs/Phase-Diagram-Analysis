function ternary_plot_3d(xy,z,imethod,varargin)
% ternary_plot_3d plots mulitple 3-dimensional surfaces in ternary space
% stacked on top of each other or maybe a volume plot (hmmm...)
% varargin = a comma-separated list packed into a cell array specifying how
% the points are plotted (ie color, style, size, etc.)

% checking input arguments
if all(size(xy) > 1) & ndims(xy) == 2 % if xy is a matrix
    if any(any(xy < 0 | xy > 1))
        error('xy coordinates must be between 0 and 1');
    end
    
    [nxyp,nxyd] = size(xy);
    
    if isequal(nxyd,3)
        xy = tern2cart(xy,1); % convert ternary to ternary cartesian coordinates for plotting
    elseif isequal(nxyd,2)
%         xy = cart2tcart(xy); % convert normal cartesian to ternary cartesian
    else
        error('xy coordinates must be in cartesian form [x y] or ternary form [s d c]');
    end                       
else
    error('xy coordinates must be in cartesian form [x y] or ternary form [s d c]');
end

if  any(size(z) == 1) & any(size(z) > 1) % if z is a vector
    [nzp,nzd] = size(z);
    
    if isequal(nzp,1) % if row vector
        z = z'; % convert to column vector
        nzp = nzd; 
        nzd = 1;
    end
    
    if ~isequal(nzp,nxyp)
        error('number of xy points must equal number of z values');
    end
elseif all(size(z) > 1) & ndims(z) == 2 % if z is a matrix
    [nzp,nzb] = size(z);
    
    if ~isequal(nzp,nxyp)
        error('number of xy points must equal number of z values');
    end                      
else
    error('z coordinates must be a vector of values at each row of xy');
end

if isempty(imethod)
    imethod = 'linear'; % default interpolation method
else
    if ~any(strcmp(imethod,{'linear';'cubic';'nearest';'v4'}))
        error('interpolation method must be one of those used by griddata');
    end
end
        
if nargin < 4
    pt_style = {'.k','markersize',20};
else
    pt_style = varargin;
end

% find minimum z value so to know where to place ternary diagram at bottom
% of z surface
minz = min(z);
minx = min(xy(:,1));
maxx = max(xy(:,1));
miny = min(xy(:,2));
maxy = max(xy(:,2));

if minz > 0
    zd = 0;
else
    zd = minz-1;
end

% set up ternary diagram (equilateral triangle) on z = 0 plane
% A is bottom left vertex, B is bottom right vertex, and C is the top
% vertex
% ternary diagram is plotted on a cartesian background where the x-axis
% goes from 0 to 1 and y-axis goes from 0 to 1
A = [0 0];
B = [1 0];
C = [0.5 sin(pi/3)];
AB = [A;B];
AC = [A;C];
BC = [B;C];

% plot z surface
[yi,xi] = meshgrid(linspace(miny,maxy)',linspace(minx,maxx)');
zi = griddata(xy(:,1),xy(:,2),z,xi,yi,imethod);
% surf(xi,yi,zi);
hold on
% plot3(xy(:,1),xy(:,2),z,pt_style{:});
% contour3(xi,yi,zi,40);
contourf(xi,yi,zi,40);
hold off

hold on
title('Ternary Plot 3d','HorizontalAlignment','center','FontSize',20,'fontweight','bold');
line(AB(:,1),AB(:,2),[zd;zd],'linestyle','-','color',[0 0 0],'linewidth',5);
line(BC(:,1),BC(:,2),[zd;zd],'linestyle','-','color',[0 0 0],'linewidth',5);
line(AC(:,1),AC(:,2),[zd;zd],'linestyle','-','color',[0 0 0],'linewidth',5);
plot3(C(1),C(2),zd,'dk','markersize',5,'MarkerFaceColor',[0 0 0]);

for i = 0.1:0.1:0.9
    Cint = [i*(C(1)-A(1)) i*(C(2)-A(2));B(1)+i*(C(1)-B(1)) B(2)+i*(C(2)-B(2))];
    line(Cint(:,1),Cint(:,2),[zd;zd],'linestyle',':','color',[0 0 0]);
    text(Cint(2,1),Cint(2,2),zd,['  ',num2str(i)],'HorizontalAlignment','left','FontSize',10);
    Bint = [B(1)+i*(A(1)-B(1)) B(2)+i*(A(2)-B(2));B(1)+i*(C(1)-B(1)) B(2)+i*(C(2)-B(2))];
    line(Bint(:,1),Bint(:,2),[zd;zd],'linestyle',':','color',[0 0 0]);
    Aint = [A(1)+i*(C(1)-A(1)) A(2)+i*(C(2)-A(2));A(1)+i*(B(1)-A(1)) A(2)+i*(B(2)-A(2))];
    line(Aint(:,1),Aint(:,2),[zd;zd],'linestyle',':','color',[0 0 0]);
end

hold off
return