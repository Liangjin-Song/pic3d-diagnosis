%% plot the energy dissipation line
%% writen by Liangjin Song on 20210411
%%
clear;
%% parameters
indir='E:\PIC\Cold-Ions\mie100\data';
outdir='E:\PIC\Cold-Ions\mie100\out\Overview\Energy\';

nx=4000;
ny=2000;
nz=1;
di=40;
norm=0.0013*384.620087*0.0125*0.0125;

x0=0;
dir=0;

Lx=nx/di;
Ly=ny/di;
yrange=[30,70];

tt=31;
nt=length(tt);

%% read data
cd(indir);
E=pic3d_read_data('E',tt,nx,ny,nz);
E.x=pic3d_simu_filter2d(E.x);
E.y=pic3d_simu_filter2d(E.y);
E.z=pic3d_simu_filter2d(E.z);
B=pic3d_read_data('B',tt,nx,ny,nz);
J=pic3d_read_data('J',tt,nx,ny,nz);
Vi=pic3d_read_data('Vl',tt,nx,ny,nz);
Vic=pic3d_read_data('Vh',tt,nx,ny,nz);
Ve=pic3d_read_data('Ve',tt,nx,ny,nz);
Vice=pic3d_read_data('Vhe',tt,nx,ny,nz);
Ve.x=Ve.x+Vice.x;
Ve.y=Ve.y+Vice.y;
Ve.z=Ve.z+Vice.z;

%% J dot (Vic cross B)
Vic=calc_cross(Vic, B);
Vic=calc_add(E, Vic);
Vic=J.x.*Vic.x+J.y.*Vic.y+J.z.*Vic.z;

%% J dot (Vi cross B)
Vi=calc_cross(Vi, B);
Vi=calc_add(E, Vi);
Vi=J.x.*Vi.x+J.y.*Vi.y+J.z.*Vi.z;

%% J dot (Vi cross B)
Ve=calc_cross(Ve, B);
Ve=calc_add(E, Ve);
Ve=J.x.*Ve.x+J.y.*Ve.y+J.z.*Ve.z;

%% get line
[lic, ll]=get_line_data(Vic,Lx,Ly,x0,norm,dir);
[li, ~]=get_line_data(Vi,Lx,Ly,x0,norm,dir);
[le, ~]=get_line_data(Ve,Lx,Ly,x0,norm,dir);

f=figure;
plot(ll,lic,'-k','LineWidth',2); hold on
plot(ll,li,'-r','LineWidth',2);
plot(ll,le,'-b','LineWidth',2); hold off
xlim(yrange);
ylabel('J \cdot (E + V \times B)');
xlabel('Z [c\omega_{pi}]');
legend('Cold Ion','Ion','Electron','Location','Best');
set(gca,'FontSize',16);
cd(outdir);
