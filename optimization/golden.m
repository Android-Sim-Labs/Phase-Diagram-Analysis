function [ xmin, fxmin ] = golden(ax,bx,cx,func,tol)

R = 0.61803399;
C = 0.38196601; % = 1.0 - R;

x0 = ax;
x3 = cx;
if( abs(cx-bx) > abs(bx-ax) )
  x1 = bx;
  x2 = bx+C*(cx-bx);
else 
  x2 = bx;
  x1 = bx-C*(bx-ax);
end;
f1 = feval(func,x1);
f2 = feval(func,x2);

while( abs(x3-x0) > tol*(abs(x1)+abs(x2)) )
  if( f2 < f1 )
    x0 = x1;
    x1 = x2;
    x2 = R*x1+C*x3;
    f1 = f2;
    f2 = feval(func,x2);
   else 
    x3 = x2;
    x2 = x1;
    x1 = R*x2+C*x0;
    f2 = f1;
    f1 = feval(func,x1);
   end;
end;

if( f1 < f2 )
  fxmin = f1;
  xmin = x1;
else 
  fxmin = f2;
  xmin = x2;
end;