function v = ptxpt(pa,pb)
% point x point function for circle analysis

Lab = sqrt(2-2*dot(pa,pb));
v = (Lab)^2 * sqrt((1/Lab)^2 - 1/4);