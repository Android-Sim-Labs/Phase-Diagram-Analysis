function [ res ] = SIGN( a, b )
%
% Implements the FORTRAN SIGN function.
% 
% Written by:
% -- 
% John L. Weatherwax, Ph.D.         12-05-2001
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

if( b >= 0.0 )
  res = abs(a);
else
  res = -abs(a);
end
