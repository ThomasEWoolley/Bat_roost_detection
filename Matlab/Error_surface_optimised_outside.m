ccc

Loader = load(['./Roost_data/buckfastleigh/Simulated_trajectories.mat']);
Tabledata=Loader.T;


f3=@(r,xi,yi,zx,zy,D,t)r.^2./(4.*D.*t).*exp(-1./(4.*D.*t).*((xi-zx).^2+(yi-zy).^2));

tic



TabledataRoosts = readtable(['./Roost_data/roosts.csv']);
Detector_position_vec=[Tabledata.XCoordinate,Tabledata.YCoordinate];
Data_prop=Tabledata.Counts/sum(Tabledata.Counts);

zx=linspace(min(Detector_position_vec(:,1)),max(Detector_position_vec(:,1))+3000,5e2);
zy=linspace(min(Detector_position_vec(:,2)),max(Detector_position_vec(:,2)),5e2);


[zxvec,zyvec]=meshgrid(zx,zy);


Detec=[];
parfor jj=1:length(Detector_position_vec)
    fun=@(t)f3(15,Detector_position_vec(jj,1),Detector_position_vec(jj,2),reshape(zxvec,1,numel(zxvec)),reshape(zyvec,1,numel(zyvec)),81.7,t);

    Detec(jj,:)=integral(fun,1,90*60,'ArrayValued',true);
end
Proportions=Detec./repmat(sum(Detec),length(Detector_position_vec),1);
Data_prop_vec=repmat(Data_prop,1,numel(zxvec));
r=sum((Proportions-Data_prop_vec).^2);

toc

save('./Roost_data/buckfastleigh/Simulated_outside_error_surface.mat')