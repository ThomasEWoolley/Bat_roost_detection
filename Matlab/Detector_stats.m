ccc
warning off
NoD=[];
Xvals=[];
cols=[];
Names={'260616','110716','250716','080816','220816','050916'};
Places={'buckfastleigh','braunton','buckfastleigh','gunnislake','high_marks_barn','buckfastleigh'};
RealPlaces={'Buckfastleigh','Braunton','Gunnislake','High Marks Barn','Mean'};
RealNames={'26th June','11th July','25th July','8th August','22th August','5th September'};

for i=1:6
    Tabledata = readtable(['./Roost_data/',Places{i},'/',Names{i},'_master.csv'],'VariableNamingRule','modify');
    [m,~]=size(Tabledata);

    disp(['Bat count ',num2str(m)]);

    Tabledata = readtable(['./Roost_data/',Places{i},'/',Names{i},'_detectors.csv'],'VariableNamingRule','modify');
    [m,~]=size(Tabledata);
    disp(['Number of detectors ',num2str(m)]);
end


%%

ccc
NoD=[];
Xvals=[];
cols=[];
Names={'260616','110716','250716','080816','220816','050916'};
Places={'buckfastleigh','braunton','buckfastleigh','gunnislake','high_marks_barn','buckfastleigh'};
RealPlaces={'Buckfastleigh','Braunton','Gunnislake','High Marks Barn','Mean'};
RealNames={'26th June','11th July','25th July','8th August','22th August','5th September'};
Colr=[1 0 0
    0 1 0
    1 0 0
    0 0 1
    0 0 0
    1 0 0];

for i=1:6
    Tabledata = readtable(['./Roost_data/',Places{i},'/',Names{i},'_detectors.csv']);
    NoD=[NoD;Tabledata.NumberOfDays];
    Xvals=[Xvals; repmat(num2str(i),length(Tabledata.NumberOfDays),1)];
    cols=[cols;repmat(Colr(i,:),length(Tabledata.NumberOfDays),1)];
end
Xvals = cellstr(Xvals);

close all
clc
figure('Position',[0 0.1 .4 2/3])
for i=1:6
    p(i)=plot(nan,'o','Color',Colr(i,:),'MarkerFaceColor',Colr(i,:));
    hold on
end
p(7)=plot(nan,'o','Color',[0 0 0],'linewidth',1);
hold off

vs = violinplot(NoD, Xvals,'ViolinColor',Colr);
ylabel('Number of days active');
xlabel('Survey start date');
% legend(p([1 2 4 5 7]),RealPlaces,'Location','bestoutside')
xticks(1:6)
xticklabels(RealNames)

export_fig('../Pictures/Active_days.png','-r300')


%%
ccc
counts=[];
Xvals=[];
cols=[];
Names={'260616','110716','250716','080816','220816','050916'};
Places={'buckfastleigh','braunton','buckfastleigh','gunnislake','high_marks_barn','buckfastleigh'};
RealPlaces={'Buckfastleigh','Braunton','Gunnislake','High Marks Barn','Mean'};
RealNames={'26th June','11th July','25th July','8th August','22th August','5th September'};
Colr=[1 0 0
    0 1 0
    1 0 0
    0 0 1
    0 0 0
    1 0 0];

for i=1:6
    Tabledata = readtable(['./Roost_data/',Places{i},'/',Names{i},'_master.csv']);
    Names2=Tabledata.INFILE;
    Names2=cell2mat(Names2);
    Names2=str2num(Names2(:,1:8));
    [uc, ~, idc] = unique( Names2 ) ;
    counts = [counts;accumarray( idc, ones(size(idc)) )];


    Xvals=[Xvals; repmat(num2str(i),length(accumarray( idc, ones(size(idc)) )),1)];
    cols=[cols;repmat(Colr(i,:),length(accumarray( idc, ones(size(idc)) )),1)];
end
Xvals = cellstr(Xvals);

close all
clc
figure('Position',[0 0.1 .4 2/3])
for i=1:6
    p(i)=plot(nan,'o','Color',Colr(i,:),'MarkerFaceColor',Colr(i,:));
    hold on
end
p(7)=plot(nan,'o','Color',[0 0 0],'linewidth',1);
hold off

vs = violinplot(counts, Xvals,'ViolinColor',Colr);
xticklabels(RealNames)
% legend(p([1 2 4 5 7]),RealPlaces,'Location','bestoutside')
ylabel('Number of passes recorded');
xlabel('Survey start date');
export_fig('../Pictures/Number_of_passes.png','-r300')


%%
ccc
Xvec=[];
Yvec=[];
Xvals=[];
cols=[];
Names={'260616','110716','250716','080816','220816','050916'};
Places={'buckfastleigh','braunton','buckfastleigh','gunnislake','high_marks_barn','buckfastleigh'};
RealPlaces={'Buckfastleigh','Braunton','Gunnislake','High Marks Barn','Mean'};
Titles={{'Buckfastleigh';'26th June'},{'Braunton';'11th July'},{'Buckfastleigh';'25th July'},...
    {'Gunnislake';'8th August'},{'High Marks Barn';'22th August'},{'Buckfastleigh','5th September'}};
RealNames={'26th June','11th July','25th July','8th August','22th August','5th September'};
Colr=[1 0 0
    0 1 0
    1 0 0
    0 0 1
    0 0 0
    1 0 0];
Roostxs=[274257 248450	274257	243550	273750 274257];
Roostys=[66207  137850	66207	72450	52750  66207];

N=0;

figure('Position',[0 0 1 1])
for i=1:6
    % Tabledata = readtable(['./Roost_data/',Places{i},'/',Names{i},'_detectors.csv']);
    Tabledata = load(['./Roost_data/',Places{i},'/',Names{i},'_90min_calls.mat']);
    Tabledata=Tabledata.T;
    % Xvec=[Xvec;Tabledata.XCoordinate];
    % Yvec=[Yvec;Tabledata.YCoordinate];
    % Xvals=[Xvals; repmat(num2str(i),length(Tabledata.NumberOfDays),1)];
    % cols=[cols;repmat(Colr(i,:),length(Tabledata.NumberOfDays),1)];

    subplot(2,3,i)
    if N==0&i==2
        [Z,R] = arcgridread(['./Roost_data/',Places{i},'/hedges.asc']);
        M=isnan(Z);
        se = offsetstrel('ball',50,50);
        dilatedI = imdilate(double(~M),se);
        mapshow(~(dilatedI-min(dilatedI(:)))+3/4,R,'DisplayType','image')
    elseif N==0
        [Z,R] = arcgridread(['./Roost_data/',Places{i},'/hedges.asc']);
        M=isnan(Z);
        mapshow(M+3/4,R,'DisplayType','image')
    end
    hold on
    plot(Tabledata.XCoordinate-Roostxs(i)*N,Tabledata.YCoordinate-Roostys(i)*N,'x','Color',Colr(i,:))

viscircles([Tabledata.XCoordinate-Roostxs(i)*N,Tabledata.YCoordinate-Roostys(i)*N],Tabledata.Counts/sum(Tabledata.Counts)*1000,'Color','k','LineWidth',1);


    mx=min(Tabledata.XCoordinate);
    my=min(Tabledata.YCoordinate);
    Mx=max(Tabledata.XCoordinate);
    My=max(Tabledata.YCoordinate);
    Area=range(Tabledata.XCoordinate).*range(Tabledata.YCoordinate)/1e6
    NoDetectors=size(Tabledata)
    NoCalls=sum(Tabledata.Counts)

    plot(Roostxs(i)-Roostxs(i)*N,Roostys(i)-Roostys(i)*N,'o','Color',Colr(i,:))
    title(Titles{i})
    
    axis equal
    axis([mx Mx my My])
    % axis tight
    ylabel('Northings (m)');
xlabel('Eastings (m)');
    set(gca,'fontsize',20)
end
export_fig('../Pictures/Detector_map.png','-r300')


%%
ccc
Xvec=[];
Yvec=[];
Xvals=[];
cols=[];
Names={'260616','110716','250716','080816','220816','050916'};
Places={'buckfastleigh','braunton','buckfastleigh','gunnislake','high_marks_barn','buckfastleigh'};
RealPlaces={'Buckfastleigh','Braunton','Gunnislake','High Marks Barn','Mean'};
Titles={{'Buckfastleigh';'26th June'},{'Braunton';'11th July'},{'Buckfastleigh';'25th July'},...
    {'Gunnislake';'8th August'},{'High Marks Barn';'22th August'},{'Buckfastleigh','5th September'}};
RealNames={'26th June','11th July','25th July','8th August','22th August','5th September'};
Colr=[1 0 0
    0 1 0
    1 0 0
    0 0 1
    0 0 0
    1 0 0];
Roostxs=[274257 248450	274257	243550	273750 274257];
Roostys=[66207  137850	66207	72450	52750  66207];

N=0;

for i=1:6
    Tabledata = readtable(['./Roost_data/',Places{i},'/',Names{i},'_detectors.csv']);
    Xvec=[Xvec;Tabledata.XCoordinate-Roostxs(i)];
    Yvec=[Yvec;Tabledata.YCoordinate-Roostys(i)];
    Xvals=[Xvals; repmat(num2str(i),length(Tabledata.NumberOfDays),1)];
    cols=[cols;repmat(Colr(i,:),length(Tabledata.NumberOfDays),1)];

end
Xvals = cellstr(Xvals);
Rvec=sqrt(Xvec.^2+Yvec.^2);

close all
clc
figure('Position',[0 0.1 .4 2/3])
for i=1:6
    p(i)=plot(nan,'o','Color',Colr(i,:),'MarkerFaceColor',Colr(i,:));
    hold on
end
p(7)=plot(nan,'o','Color',[0 0 0],'linewidth',1);
hold off

vs = violinplot(Rvec, Xvals,'ViolinColor',Colr);
xticklabels(RealNames)
% legend(p([1 2 4 5 7]),RealPlaces,'Location','bestoutside')
ylabel('Distance between detector and roost (m)');
xlabel('Survey start date');
export_fig('../Pictures/Detector_roost_distance.png','-r300')