ccc

Names={'260616','110716','250716','080816','220816','050916'};
Places={'buckfastleigh','braunton','buckfastleigh','gunnislake','high_marks_barn','buckfastleigh'};

for j=5:6;
Tabledata = readtable(['./Roost_data/',Places{j},'/',Names{j},'_master.csv'],'VariableNamingRule','modify');
[m,~]=size(Tabledata);

for i=1:m
    DATE{i,1}=[Tabledata.INFILE{i}([7,8]),'/',Tabledata.INFILE{i}([5,6]),'/',Tabledata.INFILE{i}([1:4])];
end
T=table(DATE);
writetable(T,['./Roost_data/',Places{j},'/',Names{j},'_Dates.xlsx'])
end
