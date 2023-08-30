ccc

Names={'260616','110716','250716','080816','220816','050916'};
Places={'buckfastleigh','braunton','buckfastleigh','gunnislake','high_marks_barn','buckfastleigh'};
Titles={{'Buckfastleigh';'26th June'},{'Braunton';'11th July'},{'Buckfastleigh';'25th July'},...
    {'Gunnislake';'8th August'},{'High Marks Barn';'22th August'},{'Buckfastleigh','5th September'}};
figure('Position',[0 0 1 1])
MS=10;
for j=1:length(Places)
    % load(['./Roost_data/',Places{j},'/',Names{j},'_error_surface_all_calls.mat'])
    % load(['./Roost_data/',Places{j},'/',Names{j},'_error_surface_90min_calls.mat'])
    load(['./Roost_data/',Places{j},'/',Names{j},'_error_surface_90min_optimised.mat'])
    % load(['./Roost_data/',Places{j},'/',Names{j},'_error_surface_pm90min_calls.mat'])


    subplot(2,3,j)
    r2=reshape(r,5e2,5e2)/max(r);
    pcolor(zx,zy,r2)
    % caxis([0 1])
    % colorbar
    shading interp
    axis equal
    axis tight
colormap(flipud(parula))
    hold on
    contour(zx,zy,r2,[0.1 0.2 0.3 0.4],'w','ShowText','on')
    p1=plot(eval(['TabledataRoosts.',Places{j},'(1)']), ...
        eval(['TabledataRoosts.',Places{j},'(2)']), ...
        'ko',LineWidth=1,MarkerFaceColor='auto',MarkerSize=MS);
    plot(eval(['TabledataRoosts.',Places{j},'(1)']),...
        eval(['TabledataRoosts.',Places{j},'(2)']),...
        'ko',LineWidth=1,MarkerFaceColor='auto',MarkerSize=MS);
    p2=plot(Detector_position_vec(:,1),Detector_position_vec(:,2),'kx',LineWidth=1);
    [a,b]=min(r);
    p3=plot(zxvec(b),zyvec(b),'kd',LineWidth=1,MarkerFaceColor='auto',MarkerSize=MS);
    plot(zxvec(b),zyvec(b),'kd',LineWidth=1,MarkerFaceColor='auto',MarkerSize=MS);


title(Titles{j})
    xmean=sum(Detector_position_vec(:,1).*Data_prop);
    ymean=sum(Detector_position_vec(:,2).*Data_prop);
    p4=plot(xmean,ymean,'sk',LineWidth=1,MarkerFaceColor='auto',MarkerSize=MS);
    plot(xmean,ymean,'sk',LineWidth=1,MarkerFaceColor='auto',MarkerSize=MS);
% d=sqrt((xmean-zxvec(b))^2+(ymean-zyvec(b))^2);
% viscircles([xmean,ymean],d,'Color','w','LineWidth',1,'LineStyle','--');
% viscircles([zxvec(b),zyvec(b)],d,'Color','w','LineWidth',1,'LineStyle','--');
if j==6
    % abbeyinn = [274052, 67160]
plot(274052, 67160,'sk',MarkerSize=MS,MarkerFaceColor='k');
end
    % L=legend([p1 p2 p3 p4],'Roost','Detectors','Minimum of $\rho$','Weighted mean','Location','eo','Orientation','vertical');
    % set(L,"Box",'off')
    xlabel('Eastings (m)')
    ylabel('Northings (m)')
end

export_fig('../Pictures/Detection_points.png','-r300')