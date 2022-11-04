% writen by Liangjin Song on 20190215
%% parameters 
q=1; m=1;
Ex=0; Ey=0; Ez=0;
Bx=0; By=5; Bz=0;
x0=2; y0=0; z0=5;
vx0=0; vy0=0; vz0=1;
k=q/m;
t0=0.02;
nt=500;
e=zeros(1, nt);
for t=1:nt
%% motion equation 
vx=vx0; vy=vy0; vz=vz0;
[vx,vy,vz]=velocity(vx0,vy0,vz0,Ex,Ey,Ez,Bx,By,Bz,t0,k);

x=x0+vx*t0;
y=y0+vy*t0;
z=z0+vz*t0;

e(t) = 0.5*m*(vx.^2 + vy.^2 + vz.^2);

% h=line('Color',[0 0 1],'Marker','.','MarkerSize',20);
% if ~ishandle(h),return,end
% set(h,'xdata',x0,'ydata',y0,'zdata',z0);
% drawnow
plot3([x0,x],[y0,y],[z0,z],'-r','LineWidth',1);
hold on
pause(0.01);

vx0=vx;
vy0=vy;
vz0=vz;

x0=x;
y0=y;
z0=z;
xlabel('X');
ylabel('Y');
zlabel('Z');
% xlim([-0.5,2.5]);
% ylim([-1.5,1.5]);
% zlim([-0.5,2.5]);

% pause(0.5);
end


function [vx,vy,vz]=velocity(vx0,vy0,vz0,Ex,Ey,Ez,Bx,By,Bz,dt,qm)
%% calculate the particle's velocity
% writen by Liangjin Song on 20190215
vnx=vx0+qm*Ex*dt/2;
vny=vy0+qm*Ey*dt/2;
vnz=vz0+qm*Ez*dt/2;

vox=vnx+(vny*Bz-vnz*By)*qm*dt/2;
voy=vny+(vnz*Bx-vnx*Bz)*qm*dt/2;
voz=vnz+(vnx*By-vny*Bx)*qm*dt/2;

B=sqrt(Bx*Bx+By*By+Bz*Bz);
k=dt/(1+(qm*B*dt/2)^2);

vpx=vnx+(voy*Bz-voz*By)*k;
vpy=vny+(voz*Bx-vox*Bz)*k;
vpz=vnz+(vox*By-voy*Bx)*k;

vx=vpx+qm*Ex*dt/2;
vy=vpy+qm*Ey*dt/2;
vz=vpz+qm*Ez*dt/2;
end