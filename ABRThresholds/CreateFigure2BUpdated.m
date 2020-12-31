function CreateFigure2BUpdated(Figure2Data)
%inputs: data with three columns, first column is stimulus level (dB SPL),
%second column is max magnitude for that stimulus, third column is avg
%baseline response for that stimulus level
%output: graph showing relatioship of stimulus level vs magnitude
TwoThresholdCriteria=2*std(Figure2Data(:,3));
FigureTwoB=plot(Figure2Data(:,1), Figure2Data(:,2),'-o');
set(FigureTwoB,'markerfacecolor',get(FigureTwoB,'color'))
xlim([0 90]);
hold on
yline(TwoThresholdCriteria,'-.b');
plot(Figure2Data(:,1), Figure2Data(:,2),'o','color','blue')
hold off
xlabel("Stimulus Level (dB SPL)");
ylabel("Magnitude (uV)");
legend({'ABR Magnitude','2 SD Threshold Critereon','Baseline'},'Location','northwest');
end