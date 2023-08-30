ccc
D=81.7;
dt=1;
T=1:dt:90*60;
N=600;
Stepsx=sqrt(2*D*dt)*randn(N,length(T));
Stepsy=sqrt(2*D*dt)*randn(N,length(T));

Trajx=cumsum(Stepsx,2);
Trajx=[zeros(N,1) Trajx];
Trajy=cumsum(Stepsy,2);
Trajy=[zeros(N,1) Trajy];
% histogram2(Trajx(:,end),Trajy(:,end),[20,20],'Normalization','pdf','facecolor','r');
% m=max(max(max(abs(Trajx),abs(Trajy))));
% axis(m*[-1 1 -1 1])
% [x,y]=meshgrid(linspace(-m,m),linspace(-m,m));
%
% f=@(x,y,t)1/(4*pi*D*t)*exp(-1/(4*D*t)*((x.^2+y.^2)));
% hold on
% surf(x,y,f(x,y,T(end)),ones(size(x)))
% alpha 0.5
% shading interp
Tabledata = load(['./Roost_data/buckfastleigh/260616_90min_calls.mat']);
Tabledata=Tabledata.T;
TabledataRoosts = readtable(['./Roost_data/roosts.csv']);

zx=max(Tabledata.XCoordinate)+1000;
zy=mean(Tabledata.YCoordinate);
hold on

Trajx=Trajx+zx;
Trajy=Trajy+zy;

plot(Trajx',Trajy')
plot(zx,zy,'ko')
plot(Tabledata.XCoordinate,Tabledata.YCoordinate,'kx')
viscircles([Tabledata.XCoordinate,Tabledata.YCoordinate],15,'Color','k','LineWidth',1);
for i=1:height(Tabledata)
       text(Tabledata.XCoordinate(i)+100,Tabledata.YCoordinate(i),num2str(i))
end
axis equal
axis tight

%%
Counts=[];
for i=1:height(Tabledata)
Detect_logic=(Trajx-Tabledata.XCoordinate(i)).^2+(Trajy-Tabledata.YCoordinate(i)).^2<=15^2;
Counts(i,1)=sum(Detect_logic(:));
% plot(Trajx(Detect_logic),Trajy(Detect_logic))
end
XCoordinate=Tabledata.XCoordinate;
YCoordinate=Tabledata.YCoordinate;
T=table(Counts,XCoordinate,YCoordinate)
save('./Roost_data/buckfastleigh/Simulated_trajectories.mat',"T")