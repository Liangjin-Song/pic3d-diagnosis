%% writen by Liangjin Song on 20201126
% plot the Vx as the function of position
clear;
%% parameter
indir='E:\PIC\wave-particle\data';
outdir='E:\PIC\wave-particle';

name='PVe_ts12000_x0-200_y0-1_z0-1';
norm=0.0125;
range=10;
%%
nx=200;
ny=1;
di=20;
Lx=nx/di;
Ly=ny/di;
cxs=[0,15];
% xp=53.27;
%%
cd(indir);
pve=pic3d_read_data(name);
lx=linspace(0,Lx,nx);
mv=max(abs(pve.vx));
lv=linspace(-mv,mv,500);
nv=length(lv);
fvr=zeros(nv,nx);
np=length(pve.id);
for i=1:np
    px=floor(pve.rx(i))+1;
    pv=round(((nv-1)/(2*mv))*(pve.vx(i)+mv)+1);
    fvr(pv,px)=fvr(pv,px)+1;
end
[X,Y]=meshgrid(lx,lv);
figure;
s=pcolor(X,Y,fvr);
colorbar;shading flat
colormap(mycolormap(1));
s.FaceColor = 'interp';
caxis(cxs);
xlabel('X [c/\omega_{pi}]');
ylabel('Ve_{||} [v_{A}]');
set(gca,'FontSize',16);
cd(outdir);
print('-dpng','-r300',[name,'_vx_rx.png']);