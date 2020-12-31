function [out] = ERB(p,r,fs)

out = 2 * fs *(((1-r)./p) * (2-(2+p)*exp(-p)) + r);

end
    

