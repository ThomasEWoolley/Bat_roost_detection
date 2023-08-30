ccc

f1=@(r,theta,xi,yi,D,t)1./(4*pi.*D.*t).*exp(-1./(4.*D.*t).*((xi+r.*cos(theta)).^2+(yi+r.*sin(theta)).^2));
1-integral2(@(r,theta)f1(r,theta,0,0,80,90*60).*r,0,3000,0,2*pi);