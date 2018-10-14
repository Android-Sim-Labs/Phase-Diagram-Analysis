function V = gaussianfxn(x,xdata)

V = x(1)*exp(-((xdata-x(2))/x(3)).^2);