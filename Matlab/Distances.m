ccc
Names={'260616','110716','250716','080816','220816','050916'};
Places={'buckfastleigh','braunton','buckfastleigh','gunnislake','high_marks_barn','buckfastleigh'};
TabledataRoosts = readtable(['./Roost_data/roosts.csv']);
for j=1:length(Places)

    Tabledata = load(['./Roost_data/',Places{j},'/',Names{j},'_90min_calls.mat']);
    Tabledata=Tabledata.T;
    mx=min(Tabledata.XCoordinate);
    my=min(Tabledata.YCoordinate);
    Mx=max(Tabledata.XCoordinate);
    My=max(Tabledata.YCoordinate);
    Area=range(Tabledata.XCoordinate).*range(Tabledata.YCoordinate)/1e6;
    dxdy=Area/500^2;

    load(['./Roost_data/',Places{j},'/',Names{j},'_error_surface_90min_calls.mat'])
    [a,b]=min(r);
    r2=r/max(r);
    dx=eval(['TabledataRoosts.',Places{j},'(1)'])-zxvec(b);
    dy=eval(['TabledataRoosts.',Places{j},'(2)'])-zyvec(b);

    dp(j,1)=sqrt(dx^2+dy^2);

    dxmean=eval(['TabledataRoosts.',Places{j},'(1)'])-sum(Detector_position_vec(:,1).*Data_prop);
    dymean=eval(['TabledataRoosts.',Places{j},'(2)'])-sum(Detector_position_vec(:,2).*Data_prop);

    dm(j,1)=sqrt(dxmean^2+dymean^2);

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

    A1(j,1)=sum(r2<0.1)./numel(r2);
    A2(j,1)=sum(r2<0.2)./numel(r2);
    A3(j,1)=sum(r2<0.3)./numel(r2);
    Acrit(j,1)=sum(r2<r2(ind))./numel(r2);

Areacrit(j,1)=round(sum(r2<r2(ind))*dxdy,2);

end

load('./Roost_data/buckfastleigh/Altogether_error_surface.mat')
j=1;
[a,b]=min(r);
r2=r/max(r);
dx=eval(['TabledataRoosts.',Places{j},'(1)'])-zxvec(b);
dy=eval(['TabledataRoosts.',Places{j},'(2)'])-zyvec(b);



dxmean=eval(['TabledataRoosts.',Places{j},'(1)'])-sum(Detector_position_vec(:,1).*Data_prop);
dymean=eval(['TabledataRoosts.',Places{j},'(2)'])-sum(Detector_position_vec(:,2).*Data_prop);




[~,RoostIndexx]=min(abs(eval(['TabledataRoosts.',Places{j},'(1)'])-zx));
[~,RoostIndexy]=min(abs(eval(['TabledataRoosts.',Places{j},'(2)'])-zy));

j=7;
dp(j,1)=sqrt(dx^2+dy^2);
dm(j,1)=sqrt(dxmean^2+dymean^2);

dmpx=sum(Detector_position_vec(:,1).*Data_prop)-zxvec(b);
dmpy=sum(Detector_position_vec(:,2).*Data_prop)-zyvec(b);

dmp(j,1)=sqrt(dmpx^2+dmpy^2);

ind = sub2ind(size(zxvec),RoostIndexy,RoostIndexx);
% r2(ind)


A1(j,1)=sum(r2<0.1)./numel(r2);
A2(j,1)=sum(r2<0.2)./numel(r2);
A3(j,1)=sum(r2<0.3)./numel(r2);
Acrit(j,1)=sum(r2<r2(ind))./numel(r2);

round([dp,dm,dmp]/1000,2)
round([A1 A2 A3 Acrit]*100,2)
%%
close all
x=linspace(0,2000);
figure('Position',[0 0.1 1/3 1/2])
plot(dmp(1:6),dp(1:6),'dk','LineWidth',1)
[f,stats]=fit(dmp(1:6),dp(1:6),'poly1');
p12 = predint(f,x,0.9,'functional','off');
hold on
plot(f)
plot(x,p12,'k--')
axis([0 2000 0 2000])
legend('Data','Line of best fit','$90\%$ prediction interval')
% plot(dmp(1:6),dm(1:6),'sb')
% plot(dmp(1:6),Acrit(1:6),'ok')
% xlabel('Prediction error')
% ylabel('Centre of Calls error')
xlabel({'Distance between Centre of';'Calls and Predicted roost (m)'})
ylabel({'Distance between Predicted';'roost and actual roost (m)'})
export_fig('../Pictures/Prediction_centre_distance.png','-r300')
