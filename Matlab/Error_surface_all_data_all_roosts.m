ccc

Names={'260616','110716','250716','080816','220816','050916'};
Places={'buckfastleigh','braunton','buckfastleigh','gunnislake','high_marks_barn','buckfastleigh'};

for j=1:length(Places)


    TabledataRoosts = readtable(['./Roost_data/roosts.csv']);
    Tabledata = load(['./Roost_data/',Places{j},'/',Names{j},'_all_calls.mat']);
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
    save(['./Roost_data/',Places{j},'/',Names{j},'_error_surface_all_calls.mat'])

end


function r=rho(Data_prop,Detector_position_vec,zx,zy)
% f1=@(r,theta,xi,yi,zx,zy,D,t)1./(4*pi.*D.*t).*exp(-1./(4.*D.*t).*((xi+r.*cos(theta)-zx).^2+(yi+r.*sin(theta)-zy).^2));
f3=@(r,xi,yi,zx,zy,D,t)r.^2./(4.*D.*t).*exp(-1./(4.*D.*t).*((xi-zx).^2+(yi-zy).^2));

Detec=nan(length(Detector_position_vec),1);
for j=1:length(Detector_position_vec)
    % Detec(j)=integral3(@(r,theta,t)f1(r,theta,Detector_position_vec(j,1),Detector_position_vec(j,2),zx,zy,80,t).*r,0,15,0,2*pi,0.01,90*60);
    Detec(j)=integral(@(t)f3(15,Detector_position_vec(j,1),Detector_position_vec(j,2),zx,zy,81.7,t),0.01,90*60);
end
Proportions=Detec/sum(Detec);
r=sum((Data_prop-Proportions).^2);
end
