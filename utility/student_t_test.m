function [t,prob] = student_t_test(m,v)

for i = 1:5
sd(i) = sqrt(((std(i)^2)+(std(i+1)^2)/18)*(1/5));
t(i) = (Kp(i+1)-Kp(i))/sd(i);
prob(i) = betainc(18/(18+(t(i)^2)),9,0.5);
end