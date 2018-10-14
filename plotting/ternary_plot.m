function ternary_plot(coords,chart,varargin)
% ternary_plot plots cartesian or ternary (ie 3-component) coordinates in
% coords onto a ternary (triangular) diagram.
% varargin = a comma-separated list packed into a cell array specifying how
% the points are plotted (ie color, style, size, etc.)

% [np,nd] = size(coords);

if any(any(coords < 0 | coords > 1))
    error('coordinates must be between 0 and 1');
end

% checking coordinates
if  any(size(coords) == 1) & any(size(coords) > 1) % if coords is a vector
    [nrow,ncol] = size(coords);
    
    if nrow == 1 % if row vector
        np = 1; 
        nd = ncol;
    else
        np = nrow; 
        nd = 1;
    end
elseif all(size(coords) > 1) & ndims(coords) == 2 % if coords is a matrix 
    [np,nd] = size(coords);
end

% checking coordinate chart type
if isempty(chart)
    chart = 'tern';
elseif ischar(chart)
    if ~strcmp(chart,{'cart';'tcart';'tern'})
        error('chart must be "cart","tcart",or "tern"');
    end
else
    error('chart must be "cart","tcart",or "tern"');
end
    
if nargin < 3
    pt_style = {'.k','markersize',20};
else
    pt_style = varargin;
end

% axes('FontSize',12,'FontWeight','bold',...
%     'Xlim',[0 1],'XTick',[0:0.1:1],'XMinorTick','off',...
%     'YTick',[],'YTickLabel','','YMinorTick','off');
% title('Ternary Plot','HorizontalAlignment','center','FontSize',20,'FontWeight','bold');

% set up ternary diagram (equilateral triangle):
% A is bottom left vertex, B is bottom right vertex, and C is the top
% vertex.
hold on;
A = [0 0];
B = [1 0];
C = [cos(pi/3) sin(pi/3)];
AB = [A;B];
AC = [A;C];
BC = [B;C];
line(AB(:,1),AB(:,2),'linestyle','-','color',[0 0 0],'linewidth',5);
line(BC(:,1),BC(:,2),'linestyle','-','color',[0 0 0],'linewidth',5);
line(AC(:,1),AC(:,2),'linestyle','-','color',[0 0 0],'linewidth',5);
plot(C(1),C(2),'dk','markersize',5,'MarkerFaceColor',[0 0 0]);
% maximum solubility of cholesterol line
maxchol = tern2cart([0.34 0 0.66;0 0.34 0.66],1);
line(maxchol(:,1),maxchol(:,2),'linestyle','-','color',[0 0 0],'linewidth',3);

% draw chart lines
switch chart
    case 'cart'
        i = [0.1:0.1:0.9]';
        AC = (1-i)*A + i*C;
        BC = (1-i)*B + i*C;
        X = [AC(:,1) BC(:,1)]';
        Y = [AC(:,2) BC(:,2)]'; 
        line(X,Y,'linestyle',':','color',[0 0 0]);
        text(BC(:,1),BC(:,2),[repmat('  ',9,1),num2str(i)],'HorizontalAlignment','left','FontSize',12,'FontWeight','bold');
        AB = (1-i)*A + i*B;
        CC = repmat(C,9,1);
        X = [AB(:,1) CC(:,1)]';
        Y = [AB(:,2) CC(:,2)]';
        line(X,Y,'linestyle',':','color',[0 0 0]);
%         for i = 0.1:0.1:0.9
%             Cint = [A(1)+i*(C(1)-A(1)) A(2)+i*(C(2)-A(2));B(1)+i*(C(1)-B(1)) B(2)+i*(C(2)-B(2))];
%             line(Cint(:,1),Cint(:,2),'linestyle',':','color',[0 0 0]);
%             text(Cint(2,1),Cint(2,2),['  ',num2str(i)],'HorizontalAlignment','left','FontSize',10);
%             Bint = [i*(B(1)-A(1)) i*(B(2)-A(2));C];
%             line(Bint(:,1),Bint(:,2),'linestyle',':','color',[0 0 0]);
%         end
    case 'tcart'
        i = [0.1:0.1:0.9]';
        AC = (1-i)*A + i*C;
        BC = (1-i)*B + i*C;
        X = [AC(:,1) BC(:,1)]';
        Y = [AC(:,2) BC(:,2)]'; 
        line(X,Y,'linestyle',':','color',[0 0 0]);
        text(BC(:,1),BC(:,2),[repmat('  ',9,1),num2str(i)],'HorizontalAlignment','left','FontSize',12,'FontWeight','bold');
        AB = (1-i)*A + i*B;
        CB = flipud(BC);% CB = (1-i)*C + i*B
        X = [AB(:,1) CB(:,1)]';
        Y = [AB(:,2) CB(:,2)]'; 
        line(X,Y,'linestyle',':','color',[0 0 0]);
%         for i = 0.1:0.1:0.9 
%             Cint = [A(1)+i*(C(1)-A(1)) A(2)+i*(C(2)-A(2));B(1)+i*(C(1)-B(1)) B(2)+i*(C(2)-B(2))];
%             line(Cint(:,1),Cint(:,2),'linestyle',':','color',[0 0 0]);
%             text(Cint(2,1),Cint(2,2),['  ',num2str(i)],'HorizontalAlignment','left','FontSize',10);
%             Bint = [B(1)+i*(A(1)-B(1)) B(2)+i*(A(2)-B(2));B(1)+i*(C(1)-B(1)) B(2)+i*(C(2)-B(2))];
%             line(Bint(:,1),Bint(:,2),'linestyle',':','color',[0 0 0]);
%         end
    case 'tern'
        i = [0.1:0.1:0.9]';
        AC = (1-i)*A + i*C;
        BC = (1-i)*B + i*C;
        X = [AC(:,1) BC(:,1)]';
        Y = [AC(:,2) BC(:,2)]'; 
        line(X,Y,'linestyle',':','color',[0 0 0]);
        text(BC(:,1),BC(:,2),[repmat('  ',9,1),num2str(i)],'HorizontalAlignment','left','FontSize',12,'FontWeight','bold');
        AB = (1-i)*A + i*B;
        CB = flipud(BC);% CB = (1-i)*C + i*B
        X = [AB(:,1) CB(:,1)]';
        Y = [AB(:,2) CB(:,2)]'; 
        line(X,Y,'linestyle',':','color',[0 0 0]);
        BA = flipud(AB);
        CA = flipud(AC);% CB = (1-i)*C + i*B
        X = [BA(:,1) CA(:,1)]';
        Y = [BA(:,2) CA(:,2)]'; 
        line(X,Y,'linestyle',':','color',[0 0 0]);
%         for i = 0.1:0.1:0.9 
%             Cint = [A(1)+i*(C(1)-A(1)) A(2)+i*(C(2)-A(2));B(1)+i*(C(1)-B(1)) B(2)+i*(C(2)-B(2))];
%             line(Cint(:,1),Cint(:,2),'linestyle',':','color',[0 0 0]);
%             text(Cint(2,1),Cint(2,2),['  ',num2str(i)],'HorizontalAlignment','left','FontSize',10);
%             Bint = [B(1)+i*(A(1)-B(1)) B(2)+i*(A(2)-B(2));B(1)+i*(C(1)-B(1)) B(2)+i*(C(2)-B(2))];
%             line(Bint(:,1),Bint(:,2),'linestyle',':','color',[0 0 0]);
%             Aint = [A(1)+i*(C(1)-A(1)) A(2)+i*(C(2)-A(2));A(1)+i*(B(1)-A(1)) A(2)+i*(B(2)-A(2))];
%             line(Aint(:,1),Aint(:,2),'linestyle',':','color',[0 0 0]);
%         end
    otherwise
        error('invalid chart type');
end

% plot coordinates onto ternary diagram
switch nd
    case 1
    case 2
        plot(coords(:,1),coords(:,2),pt_style{:});
    case 3
        tcart = tern2cart(coords,1);
        plot(tcart(:,1),tcart(:,2),pt_style{:});
    otherwise
        error('invalid number of composition dimensions');
end

% if nd == 3
%     es = [1 0]; % [x y]
%     ec = [cos(pi/3) sin(pi/3)]; % [x y]
%     tcart = coords(:,1)*es+coords(:,3)*ec;
%     plot(tcart(:,1),tcart(:,2),pt_style{:});
% end
% if nd == 2    
%     % change cartesian coordinates to ternary coordinates,
%     % coords: 1st col = Xplsm and 2nd col = Xchol
%     % tern = cart2tern(coords,1);    
%     plot(coords(:,1),coords(:,2),pt_style{:});
%     % ternary_plot(tern,pt_style{:});
% end

hold off;
return