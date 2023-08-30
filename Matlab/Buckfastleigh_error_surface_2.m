ccc
TabledataRoosts = readtable(['./Roost_data/roosts.csv']);
Tabledata = load('buckfastleigh_data_table.mat');
Tabledata=Tabledata.T;
Detector_position_vec=[Tabledata.XCoordinate,Tabledata.YCoordinate];
Data_prop=Tabledata.Counts/sum(Tabledata.Counts);

zx=linspace(min(Detector_position_vec(:,1)),max(Detector_position_vec(:,1)),5e2);
zy=linspace(min(Detector_position_vec(:,2)),max(Detector_position_vec(:,2)),5e2);


[zxvec,zyvec]=meshgrid(zx,zy);


tic

%%
r=nan(numel(zxvec),1);
parfor i=1:numel(zxvec)

    r(i)=rho(Data_prop,Detector_position_vec,zxvec(i),zyvec(i));


end


toc

%%
close all

figure('Position',[0 0 0.5 0.5])
r2=reshape(r,5e2,5e2)/max(r);
pcolor(zx,zy,r2)
colorbar
shading interp
axis equal
axis tight

hold on
contour(zx,zy,r2,[0.05 0.1 0.2],'w','ShowText','on')
p1=plot(TabledataRoosts.buckfastleigh(1),TabledataRoosts.buckfastleigh(2),'ko',LineWidth=1,MarkerFaceColor='auto');
plot(TabledataRoosts.buckfastleigh(1),TabledataRoosts.buckfastleigh(2),'wo',LineWidth=1,MarkerFaceColor='auto');
p2=plot(Detector_position_vec(:,1),Detector_position_vec(:,2),'kx',LineWidth=1);
[a,b]=min(r);
p3=plot(zxvec(b),zyvec(b),'kd',LineWidth=1,MarkerFaceColor='auto');
plot(zxvec(b),zyvec(b),'wd',LineWidth=1,MarkerFaceColor='auto')

% [b,i]=sort(r);
% xs=zxvec(i(1:500));
% ys=zyvec(i(1:500));
% k = convhull(xs,ys);
% plot(xs(k), ys(k), '--w')

xmean=sum(Detector_position_vec(:,1).*Data_prop);
ymean=sum(Detector_position_vec(:,2).*Data_prop);
p4=plot(xmean,ymean,'sk',LineWidth=1,MarkerFaceColor='auto');
plot(xmean,ymean,'sw',LineWidth=1,MarkerFaceColor='auto')
L=legend([p1 p2 p3 p4],'Roost','Detectors','Minimum of $\rho$','Weighted mean','Location','eo','Orientation','vertical');
set(L,"Box",'off')
xlabel('Eastings (m)')
ylabel('Northings (m)')



function r=rho(Data_prop,Detector_position_vec,zx,zy)
f1=@(r,theta,xi,yi,zx,zy,D,t)1./(4*pi.*D.*t).*exp(-1./(4.*D.*t).*((xi+r.*cos(theta)-zx).^2+(yi+r.*sin(theta)-zy).^2));
f3=@(r,xi,yi,zx,zy,D,t)r.^2./(4.*D.*t).*exp(-1./(4.*D.*t).*((xi-zx).^2+(yi-zy).^2));

Detec=nan(length(Detector_position_vec),1);
for j=1:length(Detector_position_vec)
    % Detec(j)=integral3(@(r,theta,t)f1(r,theta,Detector_position_vec(j,1),Detector_position_vec(j,2),zx,zy,80,t).*r,0,15,0,2*pi,0.01,90*60);
    Detec(j)=integral(@(t)f3(15,Detector_position_vec(j,1),Detector_position_vec(j,2),zx,zy,81.7,t),0.01,90*60);
end
Proportions=Detec/sum(Detec);
r=sum((Data_prop-Proportions).^2);
end
