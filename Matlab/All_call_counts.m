ccc

Names={'260616','110716','250716','080816','220816','050916'};
Places={'buckfastleigh','braunton','buckfastleigh','gunnislake','high_marks_barn','buckfastleigh'};


for j=1:length(Places)
    clc
    TabledataMaster = readtable(['./Roost_data/',Places{j},'/',Names{j},'_master.csv']);
    Tabledata = readtable(['./Roost_data/',Places{j},'/',Names{j},'_detectors.csv']);
    Detector_position_vec=[Tabledata.XCoordinate,Tabledata.YCoordinate];


    [Counts,Detector]=histcounts(categorical(TabledataMaster.DetectorNumber));
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
    save(['./Roost_data/',Places{j},'/',Names{j},'_all_calls.mat'],'T')

end
