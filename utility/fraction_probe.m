function [fpa,fpb] = fraction_probe(kp,fb)

%kp = x(1); % kp defined as into beta phase
%fa = x(2);

if any(size(kp) > 1) & any(size(kp) == 1)
    if size(kp,1) == 1 % if row vector
        kp = kp'; % convert to column vector
    end
else
    error('kp must be a vector');
end

if any(size(fb) > 1) & any(size(fb) == 1)
    if size(fb,2) == 1 % if column vector
        fb = fb'; % convert to row vector
    end
    
    fa = 1-fb;
    fa = repmat(fa,length(kp),1);
else
    error('fraction of alpha phase must be a vector');
end

fpa = (fa./(fa+(kp*fb)));
fpb = ((kp*fb)./(fa+(kp*fb)));

return