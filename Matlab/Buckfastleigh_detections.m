ccc

TabledataMaster = readtable(['./Roost_data/buckfastleigh/260616_master.csv']);
[m,~]=size(TabledataMaster);
Species = 'RHFE';

Species_indices=strfind(TabledataMaster.MANUALID, Species);
Species_indices=cellfun(@max,Species_indices)>0;
SpeciesTable=TabledataMaster(Species_indices,:);

[a,b]=histcounts(categorical(SpeciesTable.DetectorNumber));
a=a/sum(a);

TabledataDetectors = readtable(['./Roost_data/buckfastleigh/260616_detectors.csv']);
for i=1:length(b)
Logic_index=strcmp(TabledataDetectors.DetectorNumber,b(i));
Z(i,:)=[TabledataDetectors.XCoordinate(Logic_index) TabledataDetectors.YCoordinate(Logic_index)];
end

figure('Position',[0 0.1 .5 .5])


TabledataRoosts = readtable(['./Roost_data/roosts.csv']);

plot(TabledataDetectors.XCoordinate,TabledataDetectors.YCoordinate,'rx')
hold on
viscircles(Z,a'*1000,'Color','k','LineWidth',1)
        [Z,R] = arcgridread(['./Roost_data/buckfastleigh/hedges.asc']);
        M=isnan(Z);
        mapshow(M+3/4,R,'DisplayType','image')
plot3(TabledataRoosts.buckfastleigh(1),TabledataRoosts.buckfastleigh(2),100,'ro')
axis equal
axis tight
xlabel('Eastings (m)')
ylabel('Northings (m)')

export_fig('../Pictures/Buckfastleight_circles.png','-r300')