function [ xMin ] = InverseParabolicInterpolation( a, fa, b, fb, c, fc )
%
% Given three points and their function values performs an inverse
% parabolic step, i.e. after computing the parabola though these
% points returns the "x" coordinate that minimizes the parabola.
%
%  References:
%
%  Press, W.H. et al, 1992, Numerical recipes in FORTRAN: the art of
%  scientific computing (Cambridge University Press), Page 283.
% 
% Written by:
% -- 
% John L. Weatherwax, Ph.D.         12-07-2001
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
  
r = (b-c)*(fb-fa);
q = (b-a)*(fb-fc);
p = (b-a)*q - (b-c)*r;
q = 2.0*(q-r);
if q > 0, p = -p; end
q = abs(q);
if( q == 0 ) 
  error('Input points maybe numerically collinear.  Denominator q is zero.');
end
d = p/q;
xMin = b + d;