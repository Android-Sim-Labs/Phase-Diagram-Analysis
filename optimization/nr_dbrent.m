function [xmin,fmin] = nr_dbrent(f, fp, ax, bx, cx, tol)
%NR_DBRENT - Brent's Method for Minimization.
%
%  [ xmin, fmin ] = dbrent(f, fp, ax, bx, cx, tol)
%
%  Given a function f and its derivative function df, and given a 
%  bracketing triplet of abscissas ax, bx and cx [ such that bx is 
%  between ax and cx, and fx(b) is less than both f(ax) and f(cx), 
%  this routine isolates the minimum to a fractional precision of about 
%  TOL using Brent's method that uses derivatives. The abscissa of the 
%  minimum is returned in xmin, and the minimum function value is returned 
%  in fmin.
%
%  References:
%
%  Press, W.H. et al, 1992,  Numerical recipes in FORTRAN: the art of 
%     scientific computing (Cambridge University Press), Chapter 10.2
%
%  Description of variables:
%
%    a, b   the minimum is bracketed between a and b
%    x      point with the least function value found so far
%    w      point with the second least function value found so far
%    v      previous value of w
%    u      point at which the function was evaluated most recently
%    xm     midpoint between a and b (the function is not evaluated there)
%
%    Note: these points are not necessarily all distinct.
%
%    e      movement from best current value in the last iteration step
%    etemp  movement from the best current value in the second last
%           iteration step
%
%  General principles:
%
%    - The parabola is fitted trough the points x, v and w
%    - To be acceptable the parabolic step must
%        (i)  fall within the bounding interval (a,b)
%        (ii) imply a movement from the best current value x that is
%             *less* than half the movement of the *step before last*
%    - The code never evaluates the function less than a distance tol1
%      from a point already evaluated or from a known bracketing point
%

VERBOSE = 1;              % Print steps taken for the solution.
ITMAX = 100;              % max number of iterations
ZEPS = 1e-10;             % absolute error tolerance

% initialization
e = 0;
if ax < cx
  a = ax; b = cx;
else
  a = cx; b = ax;
end;
v = bx; w = v; x = w;
fx = feval(f,x);  fv = fx; fw = fv;
dx = feval(fp,x); dv = dx; dw = dx;

for iter = 1:ITMAX,
  if( VERBOSE ) 
    fprintf(1, 'k=%4d, |a-b|=%e\n', iter, abs(a-b));
  end
  xm = 0.5*(a+b);
  tol1 = tol*abs(x) + ZEPS;
  tol2 = 2*tol1;
  % Stopping criterion: equivalent to: max(x-a, b-x) <= tol2
  if( abs(x-xm) <= tol2-0.5*(b-a) )
    xmin = x;
    fmin = fx;
    return;
  end
  if( abs(e) > tol1 )
     d1 = 2.0*(b-a);
     d2 = d1;
     if( dw ~= dx ) 
       d1 = (w-x)*dx/(dx-dw); % Secant method with one point.
     end
     if( dv ~= dx ) 
       d2 = (v-x)*dx/(dx-dv); % And the other.
     end
     u1 = x+d1;
     u2 = x+d2;
     ok1 = (a-u1)*(u1-b) > 0.0 & dx*d1 <= 0.0;
     ok2 = (a-u2)*(u2-b) > 0.0 & dx*d2 <= 0.0;
     olde=e;
     e=d;
     if( ok1 | ok2 )
       if( ok1 & ok2 )
         if( abs(d1) < abs(d2) ) d = d1; else d = d2; end
       else 
         if( ok1 ) d = d1; else d = d2; end
       end
       if( abs(d) <= abs(0.5*olde) )
         u=x+d;
         if( u-a < tol2 | b-u < tol2 ) d = SIGN(tol1,xm-x); end
       else
         if( dx >= 0.0 ) e = a-x; else e = b-x; end
         d = 0.5*e;
       end
     else
       if( dx >= 0.0 ) e = a-x; else e = b-x; end	       	      	
       d = 0.5*e; 
     end 
  else
    if( dx >= 0.0 ) e = a-x; else e = b-x; end	       	      	
    d = 0.5*e; 
  end                                   % End if( abs(e) > tol1 )
  if( abs(d) >= tol1 )
    u = x+d;
    fu = feval(f,u);
  else
    %
    % u is too close to x: put u farther apart
    %
    u = x + SIGN(tol1,d);
    fu = feval(f,u);
    if( fu > fx ) 
      xmin = x;
      fx = fu;
    end 
  end
  du = feval(fp,u);
 if( fu <= fx )
   %
   % u is better than x: x becomes new boundary
   %
   if( u >= x ) a = x; else b = x; end
   v = w; fv = fw; dv = dw;
   w = x; fw = fx; dw = dx;
   x = u; fx = fu; dx = du;
 else
   %
   % x is better than u: u becomes new boundary
   %
   if( u < x ) a = u; else b = u; end
   if( fu <= fw | w == x )
     v = w; fv = fw; dv = dw;
     w = u; fw = fu; dw = du;
   else
     if( fu <= fv | v == x | v == w )
       v = u; fv = fu; dv = du;
     end
   end
 end
end                                             % End for loop.
error('Too many iterations in dbrent.');