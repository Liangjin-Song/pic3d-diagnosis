%% plot the electron moment equation at the flux rope
% writen by Liangjin Song on 20210319
%%
clear;
%% parameters
indir='E:\PIC\Cold-Ions\mie100\data';
outdir='E:\PIC\Cold-Ions\mie100\out\Overview\range';
nx=4000;
ny=2000;
nz=1;
di=40;

tt=31;

q=-0.0013;
m=0.04159;
n0=384.620087;
vA=0.0125;
wci=0.000312;

x0=53.3;
dir=1;

Lx=nx/di;
Ly=ny/di;

xrange=[0,Lx];
yrange=[-Ly/2,Ly/2];
xrange=yrange;

%% read data
cd(indir)
E=pic3d_read_data('E',tt,nx,ny,nz);
B=pic3d_read_data('B',tt,nx,ny,nz);
Ve=pic3d_read_data('Ve',tt,nx,ny,nz);
Ne=pic3d_read_data('Ne',tt,nx,ny,nz);
Pe=pic3d_read_data('Pe',tt,nx,ny,nz);
% previous
pVe=pic3d_read_data('Ve',tt-1,nx,ny,nz);
pNe=pic3d_read_data('Ne',tt-1,nx,ny,nz);
% next
nVe=pic3d_read_data('Ve',tt+1,nx,ny,nz);
nNe=pic3d_read_data('Ne',tt+1,nx,ny,nz);

%% calculation of electron moment equation
%% - V cross B
vb.x=B.y.*Ve.z-B.z.*Ve.y;
vb.y=B.z.*Ve.x-B.x.*Ve.z;
vb.z=B.x.*Ve.y-B.y.*Ve.x;

%% 1/(qn) nabla dot P
[dp.x,dp.y,dp.z]=calc_divergence_pressure(Pe.xx,Pe.xy,Pe.xz,Pe.yy,Pe.yz,Pe.zz,1);
dp.x=dp.x./(q*Ne);
dp.y=dp.y./(q*Ne);
dp.z=dp.z./(q*Ne);

%% m/(qn) nabla dot nvv
[nvv.x,nvv.y,nvv.z]=calc_divergence_pressure(Ne.*Ve.x.*Ve.x,Ne.*Ve.x.*Ve.y,Ne.*Ve.x.*Ve.z,Ne.*Ve.y.*Ve.y,Ne.*Ve.y.*Ve.z,Ne.*Ve.z.*Ve.z,1);
nvv.x=(m/q)*nvv.x./Ne;
nvv.y=(m/q)*nvv.y./Ne;
nvv.z=(m/q)*nvv.z./Ne;

%% m/(qn) partial (nv) / partial t
nv.x=wci*(nNe.*nVe.x-pNe.*pVe.x)/2;
nv.y=wci*(nNe.*nVe.y-pNe.*pVe.y)/2;
nv.z=wci*(nNe.*nVe.z-pNe.*pVe.z)/2;
nv.x=(m/q)*nv.x./Ne;
nv.y=(m/q)*nv.y./Ne;
nv.z=(m/q)*nv.z./Ne;

%% filter
E.y=pic3d_simu_filter2d(E.y);
vb.y=pic3d_simu_filter2d(vb.y);
dp.y=pic3d_simu_filter2d(dp.y);
nvv.y=pic3d_simu_filter2d(nvv.y);
nv.y=pic3d_simu_filter2d(nv.y);

E.z=pic3d_simu_filter2d(E.z);
vb.z=pic3d_simu_filter2d(vb.z);
dp.z=pic3d_simu_filter2d(dp.z);
nvv.z=pic3d_simu_filter2d(nvv.z);
nv.z=pic3d_simu_filter2d(nv.z);

%% get the line
[le,lx]=get_line_data(E.z,Lx,Ly,x0,vA,dir);
[lvb,~]=get_line_data(vb.z,Lx,Ly,x0,vA,dir);
[ldp,~]=get_line_data(dp.z,Lx,Ly,x0,vA,dir);
[lnvv,~]=get_line_data(nvv.z,Lx,Ly,x0,vA,dir);
[lnv,~]=get_line_data(nv.z,Lx,Ly,x0,vA,dir);
sum=lvb+ldp+lnvv+lnv;

%% figure
cd(outdir);
h1=figure;
p1=plot(lx,le,'--k','LineWidth',1.5); hold on
p2=plot(lx,lvb,'-r','LineWidth',1.5);
p3=plot(lx,ldp,'-g','LineWidth',1.5);
p4=plot(lx,lnvv,'-b','LineWidth',1.5);
p5=plot(lx,lnv,'-m','LineWidth',1.5);
p6=plot(lx,sum,'-k','LineWidth',1.5); hold off
xlabel('X [c/\omega_{pi}]')
ylabel('Ez')
xlim(xrange);
title(['\Omega_{ci}t =',num2str(tt)]);
set(gca,'FontSize',14);
lh=legend([p1;p2;p3],'E','-Ve\times B','\nabla \cdot Pe /(qeNe)','FontSize',14);
set(lh,'box','off');
ah=axes('position',get(gca,'position'),'visible','off');
lh=legend(ah,[p6,p5,p4],'Sum','me/(qeNe)\partial (NeVe)/ \partial t','me/(qeNe) \nabla \cdot (Ne Ve Ve)','FontSize',14);
set(lh,'box','off');
print(h1,'-dpng','-r300',['electron_moment_line_t',num2str(tt),'.png']);