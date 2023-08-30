ccc
Names={'260616','110716','250716','080816','220816','050916'};
Places={'buckfastleigh','braunton','buckfastleigh','gunnislake','high_marks_barn','buckfastleigh'};
TabledataRoosts = readtable(['./Roost_data/roosts.csv']);
for j=5

    Tabledata = load(['./Roost_data/',Places{j},'/',Names{j},'_90min_calls.mat']);
    Tabledata=Tabledata.T;
    mx=min(Tabledata.XCoordinate);
    my=min(Tabledata.YCoordinate);
    Mx=max(Tabledata.XCoordinate);
    My=max(Tabledata.YCoordinate);
    Area=range(Tabledata.XCoordinate).*range(Tabledata.YCoordinate)/1e6;
    dxdy=Area/500^2;

   
load('./Roost_data/high_marks_barn/220816_error_surface_half.mat')
     Xlimit=(max(Tabledata.XCoordinate)+min(Tabledata.XCoordinate))/2;
IDs=Tabledata.XCoordinate<Xlimit;
Tabledata=Tabledata(IDs,:);


    [a,b]=min(r);
    r2=r/max(r);
    dx=eval(['TabledataRoosts.',Places{j},'(1)'])-zxvec(b);
    dy=eval(['TabledataRoosts.',Places{j},'(2)'])-zyvec(b);

    dp(j,1)=sqrt(dx^2+dy^2)

    dxmean=eval(['TabledataRoosts.',Places{j},'(1)'])-sum(Detector_position_vec(:,1).*Data_prop);
    dymean=eval(['TabledataRoosts.',Places{j},'(2)'])-sum(Detector_position_vec(:,2).*Data_prop);

    dm(j,1)=sqrt(dxmean^2+dymean^2)

    dmpx=sum(Detector_position_vec(:,1).*Data_prop)-zxvec(b);
    dmpy=sum(Detector_position_vec(:,2).*Data_prop)-zyvec(b);

    dmp(j,1)=sqrt(dmpx^2+dmpy^2);


    [~,RoostIndexx]=min(abs(eval(['TabledataRoosts.',Places{j},'(1)'])-zx));
    [~,RoostIndexy]=min(abs(eval(['TabledataRoosts.',Places{j},'(2)'])-zy));

    % zxvec(RoostIndexx,RoostIndexy)
    % zyvec(RoostIndexy,RoostIndexx)

    ind = sub2ind(size(zxvec),RoostIndexy,RoostIndexx);
    % r2(ind)
    round(r2(ind),2)

    Acrit(j,1)=sum(r2<r2(ind))./numel(r2)

Areacrit(j,1)=round(sum(r2<r2(ind))*dxdy,2)

end
