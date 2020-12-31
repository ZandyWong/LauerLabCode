function error = roexfit(file, name)
%This program is a function derivative of the Roexrun script.  The input of
%the program must be the file name of the threshold data in the form of 
%name = load('mydata.m').  The second input is the name of the excel file that
%will be created (in the form of x = 'name.xls').  The program outputs the error between the
%calculated filter values and the data values given.  The function also 
%displays two graphs.  One graph depicts the Roex filter as well as the relative
%threshold data values.  The other depicts how well the filter approximates the 
%best fit for the data values.  The program will output an excel file with
%the name given in the format: 1st column: normalized deviation, 2nd column: Relative threshold values, 3rd column: values of Roex to approximate fit against threshold data values, 4th column: 1st row: ERB values, 2nd row: degree of error.

global notch thr nf kval

notch = zeros(6,1);%Lower edge of the spectral notch listed from largest to smallest
thr = zeros(6,1);% Thresholds association with above lowre edge frequencies
nf = zeros(6,1);% Values of the power spectrum. 
sa = zeros(6,1);% Absolute threshold for frequency 

notch = file(:,1);
t = file(:,2);
nf = file(:,3);
sa = file(1,4);


kval = sa ./ t(6);

max = 1;
index = 0;

%used to find the maximum threshold level
for i = 0:5
    if max < t(i + 1)
       max = t(i + 1);
    else
        index = i;
    end;
end;

thr = t - max;%defines thresholds relative to maximum (relative dB)
gn = abs(notch(6) - notch)/notch(6); %defines normalized deviation

%plots relative threshold values and holds
plot(gn,thr, 'o');
hold;

x = [25, 0.15];% initial parameter estimations for the Roex filter

[x,fval] = fminsearch(@fit,x);% searches for the minimum 

g = -0.5:0.01:0.5;%needed for filter graph 
gu = 0:0.01:0.5;%neede for approx. graph

nf2 = mean(nf); %may need to be changed based upon ones evaluation of the 
%values for the power of the noise gathered at all octaves and
%attenuations.

%plots filter
plot(g, Roex5(x(1),x(2),g,notch(6),nf2,kval), 'g');
xlabel('Normalized Deviation (fc - loweredge/fc)');
ylabel('Relative Threshold (dB)');
title('Auditory Filter Shape')

figure;

%plots approxmation of filter to threshold data values
plot(gn,t,'p');
hold;
plot(gu, Roex5(x(1),x(2),gu,notch(6),nf2,kval)+ max, 'r');
xlabel('Normalized Deviation (fc - loweredge/fc)')
ylabel('Threshold (dB)')
title('Approximation of the Filter to Threshold Values')
hold;

%Used to create the excel file
rt = Roex5(x(1),x(2),g,notch(6),nf2,kval)';
f = g';

ERBVALUE = ERB(x(1),x(2),notch(6))

o = zeros(101,4);
o(:,1) = f;
o(:,2) = rt;
o(:,3) = rt + max;
o(1,4) = ERBVALUE;
o(2,4) = fval;


xlswrite(name, o, 'Thresholds', 'A1');
%Output the error
error = fval