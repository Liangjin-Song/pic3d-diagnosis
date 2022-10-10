%% the difussion region
% writen by Liangjin Song on 20201217
%
% ExB drift and velocity
%%
indir='E:\PIC\Cold-Ions\data';
outdir='E:\PIC\Cold-Ions\out';
nx=1200;
ny=800;
nz=1;
di=20;

tt=36;
z0=29;
dir=1;
norm=0.025;
Lx=nx/di;
Ly=ny/di;
% xrange=[-Ly/2,Ly/2];
xrange=[-5,5];

%% read data
cd(indir);
E=pic3d_read_data('E',tt,nx,ny,nz);
B=pic3d_read_data('B',tt,nx,ny,nz);
Ve=pic3d_read_data('Ve',tt,nx,ny,nz);
Vi=pic3d_read_data('Vl',tt,nx,ny,nz);
Vic=pic3d_read_data('Vh',tt,nx,ny,nz);
Vice=pic3d_read_data('Vhe',tt,nx,ny,nz);

%% convection electric field
Ee=pic3d_cross(Ve,B);
Ei=pic3d_cross(Vi,B);
Eic=pic3d_cross(Vic,B);
Eice=pic3d_cross(Vice,B);

% E.y=pic3d_simu_filter2d(E.y);
% Ee.y=pic3d_simu_filter2d(Ee.y);
% Ei.y=pic3d_simu_filter2d(Ei.y);
% Eic.y=pic3d_simu_filter2d(Eic.y);
% Eice.y=pic3d_simu_filter2d(Eice.y);

%% get the line
[le,lx]=get_line_data(E.y,Lx,Ly,z0,norm,dir);
[lee,~]=get_line_data(-Ee.y,Lx,Ly,z0,norm,dir);
[lei,~]=get_line_data(-Ei.y,Lx,Ly,z0,norm,dir);
[leic,~]=get_line_data(-Eic.y,Lx,Ly,z0,norm,dir);
[leice,~]=get_line_data(-Eice.y,Lx,Ly,z0,norm,dir);

%% figure
h=figure;
plot(lx,le,'k','LineWidth',2); hold on
% plot(lx,lee,'g','LineWidth',2); 
plot(lx,lei,'r','LineWidth',2);
plot(lx,leic,'m','LineWidth',2);
% plot(lx,leice,'b','LineWidth',2); hold off
xlim(xrange);
xlabel('Z [c/\omega_{pi}]','fontsize',14);
ylabel('Ey [B_0 V_A]','fontsize',14);
legend('Ey','-(Vi\times B)_y','-(Vic \times B)_y','fontsize',14);
% legend('Ey','Ve\times B','Vi\times B','Vic \times B','Vice \times B','fontsize',14);
set(gca,'FontSize',14);
cd(outdir);
