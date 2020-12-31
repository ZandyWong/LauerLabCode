function [power] = Roex5(p,r,g,fs,Nf,k)
%The function Roex uses the power spectrum model developed by Glasberg and
%Moore to produce a model of the auditory filter based upon a rounded
%exponential function.  The function takes values of p,r, g [(f-fs)/fs],fs and Nf
%as its input.  The function produces the expected threshold for
%given normalized deviations in the center (signal) frequency based upon
%experimentally determined threshold data.  

% p determines the slope of the filter 
% r determines the shape of the tails
% Nf represents the power spectrun of the noise (dependant on frequency)
% k serves as a scaling coefficient
% g deviation in frequency
% fs frequency of the signal (center frequency)
% k = (thr w/out noise)/(thr w/ noise) = signal-to-masker ratio at the
% output of the filter required for threshold.

f = -0.04:0.01:0.1;
num = length(f);    

inf = 0.8;  %0.8 suggested by R. D. Patterson, I. Nimmo-Smith, R. Weber, and D. L. Milroy. The deterioration of hearing
            %with age: Frequency selectivity, the critical ratio, the audiogram, and speech threshold.
            %Journal of Acoustical Society of America, 1982.

gl = inf; % formerly 2/3
gh = inf;% formerly 2

tw0 =  2 * (((r-1)/p*(2+p*gh).*exp(-p*gh)+r*gh) + 2*(1-r)/p);%correct!

k = 13.32/46.1;

tw = 2 * (-(1-r)/p*(2+p*gh).*exp(-p*gh)+r*gh + (1-r)/p*(2+p*f).*exp(-p*f)-r*f);

tw = abs(tw);

ps = Nf*k*tw*fs; 

vpred = log10(ps)*10;

[XMAX,IMAX,XMIN,IMIN] = extrema(vpred);

XMAX;
IMAX;

shift = f(IMAX);

if length(shift) > 1
    if shift(1) < shift(2)
        a = 1;
    else
        a = 2
    end
else
    a = 1;
end

    
fix = abs(g) + shift(a);

twf = 2 * (-(1-r)/p*(2+p*gh).*exp(-p*gh)+r*gh + (1-r)/p*(2+p*fix).*exp(-p*fix)-r*fix);


twf = abs(twf);

ps = Nf*k*twf*fs; % transfer g scale to hz scale. 
power = log10(ps)*10 - XMAX(a);
end