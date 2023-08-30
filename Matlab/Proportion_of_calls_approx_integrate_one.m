ccc
% f=@(x,y,D,t)1./(4*pi.*D.*t)*exp(-1/(4.*D.*t)*(x.^2+y.^2));
f1=@(r,theta,xi,yi,D,t)1./(4*pi.*D.*t).*exp(-1./(4.*D.*t).*((xi+r.*cos(theta)).^2+(yi+r.*sin(theta)).^2));
f2=@(r,theta,xi,yi,D,t)1./(4*pi.*D.*t).*exp(-1./(4.*D.*t).*((xi).^2+(yi).^2));
f3=@(r,xi,yi,D,t)r.^2./(4.*D.*t).*exp(-1./(4.*D.*t).*((xi).^2+(yi).^2));
xi=0:10:1000;
t=1:0.1:60;
[xi_vec,t_vec]=meshgrid(xi,t);
x=-100:1:100;
y=-100:1:100;
[x_vec,y_vec]=meshgrid(x,y);

parfor i=1:numel(xi_vec)
Full_int(i)=integral2(@(r,theta)f1(r,theta,xi_vec(i),0,80,t_vec(i)).*r,0,15,0,2*pi);
% Approx_int(i)=integral2(@(r,theta)f2(r,theta,xi_vec(i),0,80,t_vec(i)).*r,0,15,0,2*pi);
Approx_int(i)=f3(15,xi_vec(i),0,80,t_vec(i));
end
z=abs(Full_int-Approx_int);
zmat=reshape(z,length(t),length(xi));

%%
close all
% figure('position',[0 0 1 0.9])
% subplot(2,3,1)
% pcolor(x,y,f2(0,0,x_vec,y_vec,80,1))
% shading interp
% hold on
% contour(x,y,f2(0,0,x_vec,y_vec,80,1),5,'w')
% colorbar
% % caxis([1e-6 1e-3])
% title('$t=$1s')
% xlabel('Space (m)')
% ylabel('Space (m)')
% axis equal
% axis tight
% 
% subplot(2,3,2)
% pcolor(x,y,f2(0,0,x_vec,y_vec,80,30))
% shading interp
% hold on
% contour(x,y,f2(0,0,x_vec,y_vec,80,30),5,'w')
% colorbar
% % caxis([1e-6 1e-3])
% title('$t=$30s')
% xlabel('Space (m)')
% ylabel('Space (m)')
% axis equal
% axis tight
% 
% subplot(2,3,3)
% pcolor(x,y,f2(0,0,x_vec,y_vec,80,60))
% shading interp
% hold on
% contour(x,y,f2(0,0,x_vec,y_vec,80,60),5,'w')
% colorbar
% % caxis([1e-6 1e-3])
% title('$t=$60s')
% xlabel('Space (m)')
% ylabel('Space (m)')
% axis equal
% axis tight

% subplot(2,3,[4:5])
% figure('position',[0 0 .6 .4])
% subplot(1,2,1)
figure('position',[0 0 .3 .4])
pcolor(log(zmat))
colormap(flipud(parula))
shading interp
colorbar
caxis([-10 0])
ylabel('Time (s)')
xlabel('Distance from roost (m)')
export_fig('../Pictures/Accuracy_1.png','-r300')
xi=linspace(0, 3000,30);
parfor i=1:length(xi)
Full_time_int(i)=integral3(@(r,theta,t)f1(r,theta,xi(i),0,80,t).*r,0,15,0,2*pi,0.01,90*60);
Approx_time_int(i)=integral(@(t)f3(15,xi(i),0,80,t),0.01,90*60);
end

% subplot(1,2,2)
figure('position',[0 0 .3 .4])
plot(xi,Full_time_int/sum(Full_time_int),'o')
hold on
plot(xi,Approx_time_int/sum(Approx_time_int),'x')
legend('$F_i$','$\tilde{F}_i$','Location','ne')
xlabel('Distance of detector from roost (m)')
ylabel('Proportion of calls detected')


export_fig('../Pictures/Accuracy_2.png','-r300')
