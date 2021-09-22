%% plot distribution with x direction
% writen by Liangin Song on 20200112
%%
clear;
%%
% parameters
indir='E:\PIC\Cold-Ions\data';
outdir='E:\PIC\Cold-Ions\out\distribution';
name='PVh_ts28000_x0-1199_y395-405_z0-1';
norm=0.025;
dir=3;
nx=1200;
ny=800;
di=20;
%%
Lx=nx/di;
Ly=ny/di;
xx=0:Lx/nx:Lx-Lx/nx;
%% read and set data
cd(indir);
pdf=pic3d_read_data(name);
[pv,lv]=set_dist_x(pdf,norm,nx,dir);
%% plot figure
[X,Y]=meshgrid(xx,lv);
s=pcolor(X,Y,pv);
h=colorbar;
shading flat
s.FaceColor = 'interp';
colormap('hsv');
% set(h,'YTick',[1,2,3,4,5,6,7,8,9,10]','YTicklabel',{'10^1','10^2','10^3','10^4','10^5','10^6','10^7','10^8','10^9','10^{10}'});
hold off
xlabel('X [c/\omega_{pi}]');
if dir==1
    ylabel('Vic_{x} [V_A]');
    suffix='_x';
elseif dir==2
    ylabel('Vic_{y} [V_A]');
    suffix='_y';
elseif dir==3
    ylabel('Vic_{z} [V_A]');
    suffix='_z';
end
% xlim(range);
% ylim(range);
set(gca,'FontSize',14);
cd(outdir)

%% set the distribution function along x direction
function [pv,lv]=set_dist_x(pdf,norm,nx,dir)
%% normalization
pdf.vx=pdf.vx/norm;
pdf.vy=pdf.vy/norm;
pdf.vz=pdf.vz/norm;
mv=ceil(max([max(abs(pdf.vx));max(abs(pdf.vy));max(abs(pdf.vz))])+0.1);
nv=100;
lv=linspace(-mv,mv,nv);
sv=-mv:2*mv/nv:mv;
%% the number of particles
np=length(pdf.vx);
pv=zeros(nv,nx);
%% set the function
for s=1:np
    [nx,ny,nz]=velocity_index(pdf.vx(s),pdf.vy(s),pdf.vz(s),sv);
    if dir==1
        pv(nx,floor(pdf.rx(s))+1)=pv(nx,floor(pdf.rx(s))+1)+1;
    elseif dir==2
        pv(ny,floor(pdf.rx(s))+1)=pv(ny,floor(pdf.rx(s))+1)+1;
    elseif dir==3
        pv(nz,floor(pdf.rx(s))+1)=pv(nz,floor(pdf.rx(s))+1)+1;
    end
end
end