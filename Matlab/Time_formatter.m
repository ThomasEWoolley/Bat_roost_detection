ccc
TabledataTimes = readtable(['./Roost_data/Sunrise_sunset.xlsx']);
TabledataMaster = readtable('./Roost_data/buckfastleigh/260616_master.csv');
Tabledata = readtable('./Roost_data/buckfastleigh/260616_detectors.csv');
Detector_position_vec=[Tabledata.XCoordinate,Tabledata.YCoordinate];
%%
% hours(TabledataTimes.Sunrise)
Sunset=datetime(TabledataTimes.Sunset, 'ConvertFrom','excel', 'Format','HH:mm:ss');
Sunset_upper=Sunset+minutes(90);
Time_interval=[Sunset Sunset_upper];

Time_interval_dec=days(timeofday(Time_interval));
Call_times=days(TabledataMaster.TIME);

l=1;
for i=1:length(Call_times)
    Index=find(TabledataMaster.DATE(i)==TabledataTimes.Date);
    if (Time_interval_dec(Index,1)<=Call_times(i))&(Call_times(i)<= Time_interval_dec(Index,2))
        Detectors(l)=TabledataMaster.DetectorNumber(i);
        l=l+1;
    end
end
%%

histogram(categorical(Detectors))
hold on
histogram(categorical(TabledataMaster.DetectorNumber))
[Counts,Detector]=histcounts(categorical(Detectors))
Counts=Counts';
DetectorNumber=Detector';



for i=1:length(DetectorNumber)
    Index=find(cellfun(@(C) ismember(DetectorNumber(i),C),Tabledata.DetectorNumber));
    XCoordinate(i,1)=Tabledata.XCoordinate(Index);
    YCoordinate(i,1)=Tabledata.YCoordinate(Index);
end
T=table(DetectorNumber,Counts,XCoordinate,YCoordinate);
save('buckfastleigh_data_table.mat','T')
% %%
% 
% ccc
% X=timeofday(datetime({'19:13:24', '20:43:24'}));
% Xdec=days(X);
% test=days(timeofday(datetime('20:43:25')));
% (Xdec(1)<=test)&(test<=Xdec(2))
