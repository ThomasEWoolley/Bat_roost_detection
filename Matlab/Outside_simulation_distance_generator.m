ccc
load('./Roost_data/buckfastleigh/Simulated_outside_error_surface.mat')

[a,b]=min(r);
r2=r/max(r);
dx=max(Tabledata.XCoordinate)+1000-zxvec(b);
dy=mean(Tabledata.YCoordinate)-zyvec(b);



dxmean=max(Tabledata.XCoordinate)+1000-sum(Detector_position_vec(:,1).*Data_prop);
dymean=mean(Tabledata.YCoordinate)-sum(Detector_position_vec(:,2).*Data_prop);




[~,RoostIndexx]=min(abs(max(Tabledata.XCoordinate)+1000-zx));
[~,RoostIndexy]=min(abs(mean(Tabledata.YCoordinate)-zy));

% j=7;
dp=sqrt(dx^2+dy^2)
dm=sqrt(dxmean^2+dymean^2)
% 
% dmpx=sum(Detector_position_vec(:,1).*Data_prop)-zxvec(b);
% dmpy=sum(Detector_position_vec(:,2).*Data_prop)-zyvec(b);
% 
% dmp(j,1)=sqrt(dmpx^2+dmpy^2);

ind = sub2ind(size(zxvec),RoostIndexy,RoostIndexx);
% r2(ind)



Acrit(1)=sum(r2<r2(ind))./numel(r2)

% round([dp,dm,dmp]/1000,2)
% round([A1 A2 A3 Acrit]*100,2)