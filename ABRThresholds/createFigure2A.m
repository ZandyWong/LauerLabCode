function [Magnitude,AvgBaselineResp]=createFigure2A(DataSet)
%Function Purpose: create Figure 2A of Lina/Lauer 2013 Paper
%Inputs: Data Set of time from 0 to max (preferably 30 ms) in one column and amplitudes of the ABR across that time period.   
%Outputs: Magnitude (peak-to-peak amplitude of any wave within a 8ms time period after the first 2ms)  
%Outputs: AvgBaseLineResp=average amplitude of the last 10ms (20-30ms) of the 30ms time period
%*Also graphs the time vs amplitude relationship. 
[m,~]=size(DataSet);
maxAmp=max(DataSet(3:11,2));
minAmp=min(DataSet(3:11,2));
Magnitude=maxAmp-minAmp;
AvgBaselineResp=mean(DataSet(m-10:m,2));
figure();
plot(DataSet(:,1), DataSet(:,2));
xlabel("Time (ms)");
ylabel("Magnitude (uV)");plot(DataSet(:,1), DataSet(:,2));
ABRShade=[2 10];
BaselineShade= [m-10 m-1];
hold on
patch([ABRShade(1) ABRShade(1), ABRShade(2) ABRShade(2)], [min(ylim) max(ylim) max(ylim) min(ylim)], [0.8 0.8 0.8]);
patch([BaselineShade(1) BaselineShade(1), BaselineShade(2) BaselineShade(2)], [min(ylim) max(ylim) max(ylim) min(ylim)], [0.8 0.8 0.8]);
plot(DataSet(:,1), DataSet(:,2),"Color",'b');
hold off
text(4.5,minAmp+0.5,'ABR');
text(m-7.5, minAmp+0.5, 'Baseline');
title("Figure A");

end