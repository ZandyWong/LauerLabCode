function CreateFigure2BfromAmpandTime(SetA,SetB,SetC, SetD, SetE)
%Purpose of function: takes in multiple datasets with time and amplitude,
%gets figure 2A for each set and then graphs Figure 2B overall for across
%the averages of the whole set.
%Inputs: sets with time (0-30ms), amplitude
%Outputs: graphs plotting time/amplitude relationship, overall graph
%graphing stimulus level and magnitude relationship

%Combines smaller set into one big set
StoredSet=vertcat(SetA,SetB,SetC,SetD,SetE);
Magnitudes=[];%creates empty arrays to store magnitudes and avgbaselineresponse
AvgBaseLineRespo=[];
[rows,~]=size(StoredSet);
for i=1:31:rows %iterates through whole set, step size of 30 to get the start of each dataset.
   [Mag, AvgBLRespo]=createFigure2A(StoredSet(i:i+30,:));%gets magnitude and avg baseline response from that one set of data (ex. just SetA)
    Magnitudes=[Magnitudes; Mag]; %adds magnitude and avg baseline response to separate arrays
    AvgBaseLineRespo=[AvgBaseLineRespo; AvgBLRespo]; 
end
R=input('What are the stimulus levels for the sets you entered? (please list them in the order you entered them: ','s'); %asks for the stimulus levels
StimulusLevelB = str2num(R); %stores stimulus levels
StimulusLevelC=[];
[~,numColumns]=size(StimulusLevelB); 
for i=1:numColumns %flips it from one row to one column
    StimulusLevelC=[StimulusLevelC; StimulusLevelB(1,i)];
end
OverallSorted = sortrows([StimulusLevelC Magnitudes AvgBaseLineRespo]);%sorts it from lowest to highest for baseline response
CreateFigure2BUpdated(OverallSorted); %graphs Figure 2B of Lina/Lauer paper with 2 SD threshold criteria and all of the averages for all inputs.

end