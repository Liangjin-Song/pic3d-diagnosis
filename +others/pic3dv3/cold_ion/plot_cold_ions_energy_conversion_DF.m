%% plot the J dot E
% writen by Liangjin Song on 20210318
%%
clear;
%% parameters
indir='E:\PIC\Cold-Ions\mie100\data';
outdir='E:\PIC\Cold-Ions\mie100\out\Line\Energy';
nx=4000;
ny=2000;
nz=1;
di=40;

tt=31;

qi=0.0013;
n0=384.620087;
vA=0.0125;
norm=n0*vA*vA;

x0=0;
dir=0;

Lx=nx/di;
Ly=ny/di;

xrange=[0,Lx];
yrange=[-Ly/2,Ly/2];
range=[32,42];

cd(indir);
Nic=pic3d_read_data('Nh',tt,nx,ny,nz);
Vic=pic3d_read_data('Vh',tt,nx,ny,nz);
Ni=pic3d_read_data('Nl',tt,nx,ny,nz);
Vi=pic3d_read_data('Vl',tt,nx,ny,nz);
Ne=pic3d_read_data('Ne',tt,nx,ny,nz);
Ve=pic3d_read_data('Ve',tt,nx,ny,nz);
Nice=pic3d_read_data('Nhe',tt,nx,ny,nz);
Vice=pic3d_read_data('Vhe',tt,nx,ny,nz);
E=pic3d_read_data('E',tt,nx,ny,nz);
B=pic3d_read_data('B',tt,nx,ny,nz);

JicEx=Nic.*Vic.x.*E.x;
JicEy=Nic.*Vic.y.*E.y;
JicEz=Nic.*Vic.z.*E.z;
JicE=JicEx+JicEy+JicEz;

JiEx=Ni.*Vi.x.*E.x;
JiEy=Ni.*Vi.y.*E.y;
JiEz=Ni.*Vi.z.*E.z;
JiE=JiEx+JiEy+JiEz;

[lbz,lx]=get_line_data(B.z,Lx,Ly,x0,1,dir);

[ljicex,~]=get_line_data(JicEx,Lx,Ly,x0,norm,dir);
[ljicey,~]=get_line_data(JicEy,Lx,Ly,x0,norm,dir);
[ljicez,~]=get_line_data(JicEz,Lx,Ly,x0,norm,dir);
[ljice,~]=get_line_data(JicE,Lx,Ly,x0,norm,dir);

[ljiex,~]=get_line_data(JiEx,Lx,Ly,x0,norm,dir);
[ljiey,~]=get_line_data(JiEy,Lx,Ly,x0,norm,dir);
[ljiez,~]=get_line_data(JiEz,Lx,Ly,x0,norm,dir);
[ljie,~]=get_line_data(JiE,Lx,Ly,x0,norm,dir);


%% energy conversin for cold ions
h1=figure;
yyaxis left
plot(lx,ljicex,'-m','LineWidth',1.5); hold on
plot(lx,ljicey,'-b','LineWidth',1.5);
plot(lx,ljicez,'-g','LineWidth',1.5);
plot(lx,ljice,'-k','LineWidth',1.5); hold off
xlim(range);
xlabel('X [c/\omega_{pi}]');
ylabel('Jic \cdot E');
set(gca,'ycolor','k');

yyaxis right
plot(lx,lbz,'-r','LineWidth',1.5);
xlim(range);
ylabel('Bz')
legend('Jic_xE_x','Jic_yE_y','Jic_zE_z','Sum','Bz');
set(gca,'FontSize',14);
set(gca,'ycolor','r');
title(['\Omega_{ci}t=',num2str(tt)]);
cd(outdir);
print(h1,'-dpng','-r300',['cold_ions_energy_conversion_t',num2str(tt),'_DF.png']);

%% energy conversin for ions
h2=figure;
yyaxis left
plot(lx,ljiex,'-m','LineWidth',1.5); hold on
plot(lx,ljiey,'-b','LineWidth',1.5);
plot(lx,ljiez,'-g','LineWidth',1.5);
plot(lx,ljie,'-k','LineWidth',1.5); hold off
xlabel('X [c/\omega_{pi}]');
ylabel('Ji \cdot E');
set(gca,'ycolor','k');

yyaxis right
plot(lx,lbz,'-r','LineWidth',1.5);
ylabel('Bz')
legend('Ji_xE_x','Ji_yE_y','Ji_zE_z','Sum','Bz');
set(gca,'ycolor','r');

title(['\Omega_{ci}t=',num2str(tt)]);
xlim(range);
set(gca,'FontSize',14);
cd(outdir);
print(h2,'-dpng','-r300',['cold_ions_energy_conversion_t',num2str(tt),'_JiE_DF.png']);

%% cold ions current
Jic.x=Nic.*Vic.x;
Jic.y=Nic.*Vic.y;
Jic.z=Nic.*Vic.z;
[ljicx,~]=get_line_data(Jic.x,Lx,Ly,x0,n0*vA,dir);
[ljicy,~]=get_line_data(Jic.y,Lx,Ly,x0,n0*vA,dir);
[ljicz,~]=get_line_data(Jic.z,Lx,Ly,x0,n0*vA,dir);
h3=figure;
yyaxis left
plot(lx,ljicx,'-m','LineWidth',1.5); hold on
plot(lx,ljicy,'-b','LineWidth',1.5);
plot(lx,ljicz,'-k','LineWidth',1.5); hold off
xlabel('X [c/\omega_{pi}]');
ylabel('Jic');
set(gca,'ycolor','k');

yyaxis right
plot(lx,lbz,'-r','LineWidth',1.5);
ylabel('Bz')
legend('Jic_x','Jic_y','Jic_z','Bz');
set(gca,'ycolor','r');

title(['\Omega_{ci}t=',num2str(tt)]);
xlim(range);
set(gca,'FontSize',14);
cd(outdir);
print(h3,'-dpng','-r300',['cold_ions_energy_conversion_t',num2str(tt),'_Jic_DF.png']);

%% ions current
Ji.x=Ni.*Vi.x;
Ji.y=Ni.*Vi.y;
Ji.z=Ni.*Vi.z;
[ljix,~]=get_line_data(Ji.x,Lx,Ly,x0,n0*vA,dir);
[ljiy,~]=get_line_data(Ji.y,Lx,Ly,x0,n0*vA,dir);
[ljiz,~]=get_line_data(Ji.z,Lx,Ly,x0,n0*vA,dir);
h4=figure;
yyaxis left
plot(lx,ljix,'-m','LineWidth',1.5); hold on
plot(lx,ljiy,'-b','LineWidth',1.5);
plot(lx,ljiz,'-k','LineWidth',1.5); hold off
xlabel('X [c/\omega_{pi}]');
ylabel('Ji');
set(gca,'ycolor','k');

yyaxis right
plot(lx,lbz,'-r','LineWidth',1.5);
ylabel('Bz')
legend('Ji_x','Ji_y','Ji_z','Bz');
set(gca,'ycolor','r');

title(['\Omega_{ci}t=',num2str(tt)]);
xlim(range);
set(gca,'FontSize',14);
cd(outdir);
print(h4,'-dpng','-r300',['cold_ions_energy_conversion_t',num2str(tt),'_Ji_DF.png']);

%% electric field
[lex,~]=get_line_data(E.x,Lx,Ly,x0,vA,dir);
[ley,~]=get_line_data(E.y,Lx,Ly,x0,vA,dir);
[lez,~]=get_line_data(E.z,Lx,Ly,x0,vA,dir);
h5=figure;
yyaxis left
plot(lx,lex,'-m','LineWidth',1.5); hold on
plot(lx,ley,'-b','LineWidth',1.5);
plot(lx,lez,'-k','LineWidth',1.5); hold off
xlabel('X [c/\omega_{pi}]');
ylabel('Electric field');
set(gca,'ycolor','k');

yyaxis right
plot(lx,lbz,'-r','LineWidth',1.5);
ylabel('Bz')
legend('Ex','Ey','Ez','Bz');
set(gca,'ycolor','r');

title(['\Omega_{ci}t=',num2str(tt)]);
xlim(range);
set(gca,'FontSize',14);
cd(outdir);
print(h5,'-dpng','-r300',['cold_ions_energy_conversion_t',num2str(tt),'_E_DF.png']);

%% the ExB drift
eb.x=E.y.*B.z; %-E.z.*B.y;
eb.y=E.z.*B.x-E.x.*B.z;
eb.z=E.x.*B.y-E.y.*B.x;
b2=B.x.^2+B.y.^2+B.z.^2;
eb.x=eb.x./b2;
eb.y=eb.y./b2;
eb.z=eb.z./b2;
[lebx,~]=get_line_data(eb.x,Lx,Ly,x0,vA,dir);
[lvix,~]=get_line_data(Vi.x,Lx,Ly,x0,vA,dir);
[lvicx,~]=get_line_data(Vic.x,Lx,Ly,x0,vA,dir);
[lvicex,~]=get_line_data(Vice.x,Lx,Ly,x0,vA,dir);
[lvex,~]=get_line_data(Ve.x,Lx,Ly,x0,vA,dir);
h6=figure;
yyaxis left
plot(lx,lvix,'-m','LineWidth',1.5); hold on
plot(lx,lvicx,'-b','LineWidth',1.5);
plot(lx,lvex,'-g','LineWidth',1.5);
% plot(lx,lvicex,'--g','LineWidth',1.5);
plot(lx,lebx,'-k','LineWidth',1.5); hold off
ylim([0,1]);
xlabel('X [c/\omega_{pi}]');
ylabel('Velocity');
set(gca,'ycolor','k');

yyaxis right
plot(lx,lbz,'-r','LineWidth',1.5);
ylabel('Bz')
legend('Vi_x','Vic_x','Ve_x','(E\times B /B^2)_x','Bz');
set(gca,'ycolor','r');

title(['\Omega_{ci}t=',num2str(tt)]);
xlim(range);
set(gca,'FontSize',14);
cd(outdir);
print(h6,'-dpng','-r300',['cold_ions_energy_conversion_t',num2str(tt),'_Velocity_DF.png']);