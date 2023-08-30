ccc

f1=@(r,theta,xi,yi,D,t)1./(4*pi.*D.*t).*exp(-1./(4.*D.*t).*((xi+r.*cos(theta)).^2+(yi+r.*sin(theta)).^2));

x=linspace(0,100,100);
plot(x,f1(0,0,x,0,80,1));
% annotation('doublearrow',[.55 .65],.5*[1 1])
xline(10)
xline(20)

xline(60)
xline(70)
xlabel('Space (m)')
ylabel('$\phi(x,0,1)$')

%%

ccc

f1=@(r,theta,xi,yi,D,t)1./(4*pi.*D.*t).*exp(-1./(4.*D.*t).*((xi+r.*cos(theta)).^2+(yi+r.*sin(theta)).^2));

x=linspace(0,100,100);
y=linspace(0,100,100);
[xvec,yvec]=meshgrid(x,y);
pcolor(x,y,f1(0,0,xvec,yvec,80,1));
colormap(flipud(parula))
shading interp
viscircles([20 20],15,'LineStyle','--','color','k','LineWidth',1)
viscircles([60 60],15,'LineStyle','--','color','b','LineWidth',1)
% annotation('doublearrow',[.55 ,.65],.5*[1 1])
% xline(10)
% xline(20)

% xline(60)
% xline(70)
xlabel('Space (m)')
ylabel('Space (m)')
text(20,20,'$\Omega_1$','color','k')
text(60,60,'$\Omega_2$','color','k')
colorbar
caxis([0 1e-3])
axis equal
axis tight
set(gca,'FontSize',12)
export_fig('../Pictures/Integration_approximation.png','-r300')