function varargout = potential_ball(varargin)
% plot potential surface on a sphere
% uniaxial only...could work with chiral term Re(D210)
if isempty(varargin)
    c = input('input [c20 c22 c40 c42 c44]\n');
else
    c = varargin{:};
end
a1 = sqrt(3.0/2.0);
a2 = sqrt(5.0/8.0);
a3 = sqrt(35.0/32.0);
for n = 1:101
    for m = 1:201
        t1 = sin((n-1)*pi/100); % sin(theta)
        t12 = t1*t1;
        t2 = cos((n-1)*pi/100); % cos(theta)
        t22 = t2*t2;
        t3 = sin((m-1)*pi/100); % sin(phi)
        t4 = cos((m-1)*pi/100); % cos(phi)
        t5 = cos((m-1)*pi/50); % cos(2 phi)
        t6 = cos((m-1)*pi/25);  % cos(4 phi)
        % ----- Re(D200)
        u = c(1)*(3.0*t22-1.0)/2.0;
        % ----- Re(D202)
        u = u+c(2)*a1*t12*t5;
        % ----- Re(D400)
        u = u+c(3)*((35.0*t22-30.0)*t22+3.0)/8.0;
        % ----- Re(D402)
        u = u+c(4)*a2*t12*(7.0*t22-1.0)*t5;
        % ----- Re(D404)
        u = u+c(5)*a3*t12*t12*t6;
        % relative probability is exp(-U)
        % don't need that extra sin(theta) for these plots (?)
        u = exp(u);
        % convert to cartesian coordinates for matlab
        X(n,m) = u*t1*t4;
        Y(n,m) = u*t1*t3;
        Z(n,m) = u*t2;
    end
end
t1 = max(X(:));% max(max(X))
t2 = max(Y(:));% max(max(Y))
t3 = max(Z(:));% max(max(Z))
t4 = max([t1 t2 t3]); % normalize so largest prob. is 1.0
X = X/t4;
Y = Y/t4;
Z = Z/t4;
colormap(gray);
surfl(X,Y,Z,[1,0,0]); % light source along +x axis
shading flat;
axis([-.6,.6,-.6,.6,-.6,.6]); % slightly larger so can see axes
axis off;
hold on;
plot3([-1.2 0 0 0 0],[0 0 -1.2 0 0],[0 0 0 0 1.2],'k'); 
% plots a line +x to origin to +y to origin to +z in solid black
hold off;
text(-1.3,0,0,'X') % this is for bug in matlab
text(0,-1.3,0,'Y')
text(0,0,1.3,'Z')
return