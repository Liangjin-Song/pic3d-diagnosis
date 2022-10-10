%% plot the electron moment equation at the flux rope
% writen by Liangjin Song on 20210319
%%
clear;
%% parameters
indir='E:\Asym\Cold\data';
outdir='E:\Asym\Cold\out\Momentum';
prm=slj.Parameters(indir,outdir);
nx=prm.value.nx;
ny=prm.value.nz;
nz=prm.value.ny;
di=prm.value.di;

tt=100;

q=prm.value.qi;
m=prm.value.mi;
n0=384.620087;
vA=prm.value.vA;
wci=prm.value.wci;

x0=50;
dir=1;

Lx=nx/di;
Ly=ny/di;

xrange=[0,Lx];
yrange=[-10,10];
xrange=yrange;

pxt=prm.value.nz/2;
dpx=100;
%% read data
cd(indir)
E=pic3d_read_data('E',tt,nx,ny,nz);
B=pic3d_read_data('B',tt,nx,ny,nz);
Ve=pic3d_read_data('Vh',tt,nx,ny,nz);
Ne=pic3d_read_data('Nh',tt,nx,ny,nz);
Pe=pic3d_read_data('Ph',tt,nx,ny,nz);
% previous
pVe=pic3d_read_data('Vh',tt-1,nx,ny,nz);
pNe=pic3d_read_data('Nh',tt-1,nx,ny,nz);
% next
nVe=pic3d_read_data('Vh',tt+1,nx,ny,nz);
nNe=pic3d_read_data('Nh',tt+1,nx,ny,nz);

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
E.x=pic3d_simu_filter2d(E.x);
vb.x=pic3d_simu_filter2d(vb.x);
dp.x=pic3d_simu_filter2d(dp.x);
nvv.x=pic3d_simu_filter2d(nvv.x);
nv.x=pic3d_simu_filter2d(nv.x);

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
[~,lx]=get_line_data(E.y,Lx,Ly,x0,vA,dir);
% [lvb,~]=get_line_data(vb.y,Lx,Ly,x0,vA,dir);
% [ldp,~]=get_line_data(dp.y,Lx,Ly,x0,vA,dir);
% [lnvv,~]=get_line_data(nvv.y,Lx,Ly,x0,vA,dir);
% [lnv,~]=get_line_data(nv.y,Lx,Ly,x0,vA,dir);
le=E.y(:,pxt-dpx:pxt+dpx);
le=sum(le,2);
lvb=vb.y(:,pxt-dpx:pxt+dpx);
lvb=sum(lvb,2);
ldp=dp.y(:,pxt-dpx:pxt+dpx);
ldp=sum(ldp,2);
lnvv=nvv.y(:,pxt-dpx:pxt+dpx);
lnvv=sum(lnvv,2);
lnv=nv.y(:,pxt-dpx:pxt+dpx);
lnv=sum(lnv,2);
sm=lvb+ldp+lnvv+lnv;

%% figure
cd(outdir);
h1=figure;
p1=plot(lx,le,'--k','LineWidth',1.5); hold on
p2=plot(lx,lvb,'-r','LineWidth',1.5);
p3=plot(lx,ldp,'-g','LineWidth',1.5);
p4=plot(lx,lnvv,'-b','LineWidth',1.5);
p5=plot(lx,lnv,'-m','LineWidth',1.5);
p6=plot(lx,sm,'-k','LineWidth',1.5); hold off
xlabel('X [c/\omega_{pi}]')
ylabel('Ey')
xlim(xrange);
% title(['\Omega_{ci}t =',num2str(tt)]);
set(gca,'FontSize',14);
lh=legend([p1;p2;p3],'E','-V\times B','\nabla \cdot P /(qN)','FontSize',14);
set(lh,'box','off');
ah=axes('position',get(gca,'position'),'visible','off');
lh=legend(ah,[p6,p5,p4],'Sum','m/(qN)\partial (NV)/ \partial t','m/(qN) \nabla \cdot (N V V)','FontSize',14);
set(lh,'box','off');
% print(h1,'-dpng','-r300',['electron_moment_line_t',num2str(tt),'.png']);