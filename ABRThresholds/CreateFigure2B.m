function CreateFigure2B(Figure2Data)
%inputs: set of data with stimulus level in first column, min amplitude in
%second column, max amplitude in third column, average baseline response of that stimulus level in the fourth column 
ABRMagnitude=Figure2Data(:,3)-Figure2Data(:,2);
StdDev=std(Figure2Data(:,4));
TwoThresholdCriteria=StdDev*2;
FigureTwoB=plot(Figure2Data(:,1), ABRMagnitude,'-o');
set(FigureTwoB,'markerfacecolor',get(FigureTwoB,'color'))
xlim([0 90]);
hold on
yline(TwoThresholdCriteria,'-.b');
plot(Figure2Data(:,1), Figure2Data(:,4),'o','color','blue')
hold off
xlabel("Stimulus Level (dB SPL)");
ylabel("Magnitude (uV)");
legend({'ABR Magnitude','2 SD Threshold Critereon','Baseline'},'Location','northwest');
end