ccc
Places={'buckfastleigh'};
Titles={'Buckfastleigh'};
figure('Position',[0 0 .25 .5])


load('./Roost_data/buckfastleigh/Altogether_error_surface.mat')

r2=reshape(r,5e2,5e2)/max(r);
pcolor(zx,zy,r2)
% caxis([0 1])
% colorbar
shading interp
axis equal
axis tight
j=1;
hold on
contour(zx,zy,r2,[0.1 0.2 0.3 0.4],'w','ShowText','on')
p1=plot(eval(['TabledataRoosts.',Places{j},'(1)']), ...
    eval(['TabledataRoosts.',Places{j},'(2)']), ...
    'ko',LineWidth=1,MarkerFaceColor='auto');
plot(eval(['TabledataRoosts.',Places{j},'(1)']),...
    eval(['TabledataRoosts.',Places{j},'(2)']),...
    'ko',LineWidth=1,MarkerFaceColor='auto');
p2=plot(Detector_position_vec(:,1),Detector_position_vec(:,2),'kx',LineWidth=1);
[a,b]=min(r);
p3=plot(zxvec(b),zyvec(b),'kd',LineWidth=1,MarkerFaceColor='auto');
plot(zxvec(b),zyvec(b),'kd',LineWidth=1,MarkerFaceColor='auto')

% [b,i]=sort(r);
% xs=zxvec(i(1:500));
% ys=zyvec(i(1:500));
% k = convhull(xs,ys);
% plot(xs(k), ys(k), '--w')
title(Titles{j})
xmean=sum(Detector_position_vec(:,1).*Data_prop);
ymean=sum(Detector_position_vec(:,2).*Data_prop);
p4=plot(xmean,ymean,'sk',LineWidth=1,MarkerFaceColor='auto');
plot(xmean,ymean,'sk',LineWidth=1,MarkerFaceColor='auto')
% L=legend([p1 p2 p3 p4],'Roost','Detectors','Minimum of $\rho$','Weighted mean','Location','eo','Orientation','vertical');
% set(L,"Box",'off')
xlabel('Eastings (m)')
ylabel('Northings (m)')


export_fig('../Pictures/Detection_points_buck.png','-r300')