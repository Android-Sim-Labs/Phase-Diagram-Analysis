function [x1,x2] = quad_formula(a,b,c)
% quadratic formula
x1 = (-b+sqrt(b^2-4*a*c))/2*a;
x2 = (-b-sqrt(b^2-4*a*c))/2*a;