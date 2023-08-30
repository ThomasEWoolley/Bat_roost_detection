clc
close all
Probs=r./sum(r);
Probs_square=reshape(Probs,5e2,5e2);
[ss,si]=sort(Probs);
maxindex=find(cumsum(ss)<0.8,1,'last');

Log_ind=nan(size(zxvec));
Log_ind(si(1:maxindex))=1;
% Log_ind=logical(Log_ind);

pcolor(zxvec,zyvec,Probs_square.*Log_ind)
shading interp
hold on
    p1=plot(eval(['TabledataRoosts.',Places{j},'(1)']), ...
        eval(['TabledataRoosts.',Places{j},'(2)']), ...
        'ko',LineWidth=1,MarkerFaceColor='auto');
    plot(eval(['TabledataRoosts.',Places{j},'(1)']),...
        eval(['TabledataRoosts.',Places{j},'(2)']),...
        'ko',LineWidth=1,MarkerFaceColor='auto');
