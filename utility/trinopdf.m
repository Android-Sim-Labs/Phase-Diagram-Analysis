function P = trinopdf(x1,x2,N,p1,p2,p3)

for i = 1:x1+1
    for k = 1:x2+1
        P(i,k) = (factorial(N)/(factorial(i-1)*factorial(k-1)*factorial(N-(i-1)-(k-1))))*((p1^(i-1))*(p2^(k-1))*(p3^(N-(i-1)-(k-1))));
    end
end

return