function [ ax, bx, cx, fa, fb, fc ] = nr_mnbrak(ax,bx,func)
% NR_MNBRAK - returns points which bracket a minimum of the function
% 
% Given a function func, and given distinct initial points ax and bx, 
% this routine searches in the downhill direction (defined by the function 
% as evaluated at the initial points) and returns new points ax, bx, cx, 
% which bracket a minimum of the function.  Also returned are the 
% function values at the three points.

% Note: The use of the same name ax, and bx on both the input and the
% output of this function requires that both values are COPIED into
% the functions workspace.  In general elements listed as inputs only are 
% simply read and not copied. 
%
% Written by:
% -- 
% John L. Weatherwax                2004-12-11 
% 
% email: wax@alum.mit.edu
% 
% Please send comments and especially bug reports to the
% above email address.
% 
%-----


GOLD = 1.618034;
G_LIMIT = 100.0;
TINY = 1.d-20;

fa = feval(func,ax);
fb = feval(func,bx);
if( fb > fa )
  dum = ax;
  ax = bx;
  bx = dum;
  dum = fb;
  fb = fa;
  fa = dum;
end;
cx = bx+GOLD*(bx-ax);
fc = feval(func,cx);

while( fb >= fc )
  r=(bx-ax)*(fb-fc);
  q=(bx-cx)*(fb-fa);
  % u=bx-((bx-cx)*q-(bx-ax)*r)/(2.0*(sign(q-r)+eps)*max(abs(q-r),TINY));
  u=bx-((bx-cx)*q-(bx-ax)*r)/(2.0*SIGN(max(abs(q-r),TINY),q-r));
  ulim = bx+G_LIMIT*(cx-bx);
  if( (bx-u)*(u-cx) > 0.0 )
    fu = feval(func,u);
    if( fu < fc )
      ax = bx;
      fa = fb;
      bx = u;
      fb = fu;
      return;
    elseif( fu > fb )
      cx = u;
      fc = fu;
      return;
    end;
  u=cx+GOLD*(cx-bx);
  fu = feval(func,u);
  elseif( (cx-u)*(u-ulim) > 0.0 )
    fu = feval(func,u);
    if( fu < fc )
      bx = cx;
      cx=u;
      u=cx+GOLD*(cx-bx);
      fb = fc;
      fc = fu;
      fu = feval(func,u);
    end;
   elseif( (u-ulim)*(ulim-cx) >= 0.0 )
     u=ulim;
     fu = feval(func,u);
   else 
     u=cx+GOLD*(cx-bx);
     fu = feval(func,u);
   end;
   ax = bx;
   bx = cx;
   cx = u;
   fa = fb;
   fb = fc;
   fc = fu;
end;