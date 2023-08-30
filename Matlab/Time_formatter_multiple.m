ccc

Names={'260616','110716','250716','080816','220816','050916'};
Places={'buckfastleigh','braunton','buckfastleigh','gunnislake','high_marks_barn','buckfastleigh'};

TabledataTimes = readtable(['./Roost_data/Sunrise_sunset.xlsx']);
Sunset=datetime(TabledataTimes.Sunset, 'ConvertFrom','excel', 'Format','HH:mm:ss');
Sunset_upper=Sunset+minutes(90);
% Sunset=Sunset-minutes(90);

Time_interval=[Sunset Sunset_upper];
Time_interval_dec=days(timeofday(Time_interval));

%%
for j=1:length(Places)
    clc
    TabledataMaster = readtable(['./Roost_data/',Places{j},'/',Names{j},'_master.csv']);
    Tabledata = readtable(['./Roost_data/',Places{j},'/',Names{j},'_detectors.csv']);
    Detector_position_vec=[Tabledata.XCoordinate,Tabledata.YCoordinate];


    Call_times=days(TabledataMaster.TIME);

    l=1;
    Detectors={};
    for i=1:length(Call_times)
        Index=find(TabledataMaster.DATE(i)==TabledataTimes.Date);
        if (Time_interval_dec(Index,1)<=Call_times(i))&(Call_times(i)<= Time_interval_dec(Index,2))
            Detectors(l)=TabledataMaster.DetectorNumber(i);
            l=l+1;
        end
    end
    %%

    %     histogram(categorical(Detectors))
    %     hold on
    %     histogram(categorical(TabledataMaster.DetectorNumber))
    [Counts,Detector]=histcounts(categorical(Detectors));
    Counts=Counts';
    DetectorNumber=Detector';


    XCoordinate=[];
    YCoordinate=[];
    for i=1:length(DetectorNumber)
        Index=find(cellfun(@(C) ismember(DetectorNumber(i),C),Tabledata.DetectorNumber));
        XCoordinate(i,1)=Tabledata.XCoordinate(Index);
        YCoordinate(i,1)=Tabledata.YCoordinate(Index);
    end
    T=table(DetectorNumber,Counts,XCoordinate,YCoordinate);
    save(['./Roost_data/',Places{j},'/',Names{j},'_90min_calls.mat'],'T')

end
