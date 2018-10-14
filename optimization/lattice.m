function [ xmin, fxmin ] = lattice( x, func )
% 
% Implements a lattice search on a discrete set of points finding the
% discrete minimum of the input function.
%
% Written by:
% -- 
% John L. Weatherwax, Ph.D.         01-01-2002
% MIT Lincoln Laboratory
% 244 Wood Street
% Lexington, MA 02420-9176 USA
% 
% email: weatherwax@ll.mit.edu
% Voice: (781) 981-5370       Fax: (781) 981-0721
%
% Please send comments and especially bug reports to the
% above email address.
%
%-----

% Insure that there are enough points in the search domain.  This
% number must be equal to a Fibonacci number.
  
% Psudocode:
% Pad original indices x with enough elements to make up the length
% of the array x equal to the next largest fibonacci number.
  
% The elements to sample the objective function from are taken from
% the location of the two previous fibonacci numbers.
  
% Based on the results from these function evaluations the intervals
% length is decreased and the above process is repeated.
  
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

% Place for loop over number of iterations dependent on the order
% of the fibonacci number corresponding to the length of the input
% array x.
while( abs(x3-x0) > 0.5*( abs(x1) + abs(x2) )*relErr + absErr )
  if( f2 < f1 )
    x0 = x1;
    x1 = x2;
    f1 = f2;
    x2 = % Pick correct placement of x2 % R*x1+C*x3;
    f2 = feval(func,x2);
   else 
    x3 = x2;
    x2 = x1;
    f2 = f1;
    x1 = % Pick correct placement of x1 % R*x2+C*x0;
    f1 = feval(func,x1);
   end;
end;

if( f1 < f2 )
  fxmin = f1;
  xmin  = x1;
else 
  fxmin = f2;
  xmin  = x2;
end;