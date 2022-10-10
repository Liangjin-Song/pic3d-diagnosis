%% writen by Liangjin Song on 20201126
% plot the distribution function
clear;
%% parameter
indir='E:\PIC\Cold-Ions\mie100\data';
outdir='E:\PIC\Cold-Ions\mie100\out\Distribution_Function';

name='PVl_ts99359_x2120-2143_y988-1014_z0-1';
norm=0.0125;
range=5;
%%
nx=4000;
ny=2000;
di=40;
Lx=nx/di;
Ly=ny/di;

% xp=53.27;
%%
cd(indir);
pve=pic3d_read_data(name);
% [pvl, pvr] = split_distribution_function(pve,xp,nx,ny,Lx,Ly);
% pve=pvl;
%% normalization
pve.vx=pve.vx/norm;
pve.vy=pve.vy/norm;
pve.vz=pve.vz/norm;
[fve,lv]=pic3d_get_distribution_function(pve);
for i=1:3
    plot_distribution_x_y_z(fve,lv,i,range,name,outdir);
end

function plot_distribution_x_y_z(fve,lv,sdir,range,name,outdir)
fve=sum(fve,sdir);
fve=reshape(fve,length(lv),length(lv))';
%% figure
[X,Y]=meshgrid(lv,lv);
figure;
s=pcolor(X,Y,fve);
colorbar;shading flat
colormap(mycolormap(1));
s.FaceColor = 'interp';
% set(h,'YTick',[1,2,3,4,5,6,7,8,9,10]','YTicklabel',{'10^1','10^2','10^3','10^4','10^5','10^6','10^7','10^8','10^9','10^{10}'});
hold on
plot([lv(1),lv(end)],[0,0],'--r','LineWidth',1);
plot([0,0],[lv(1),lv(end)],'--r','LineWidth',1);
hold off

if contains(name,'PVe')
    prt='Ve';
elseif contains(name,'PVl')
    prt='Vi';
elseif contains(name,'PVh')
    if contains(name,'PVhe')
        prt='Ve';
    else
        prt='Vic';
    end
end

if sdir==1
    xlabel([prt,'_{y} [V_A]']);
    ylabel([prt,'_{z} [V_A]']);
    suffix='_y-z';
elseif sdir==2
    xlabel([prt,'_{x} [V_A]']);
    ylabel([prt,'_{z} [V_A]']);
    suffix='_x-z';
elseif sdir==3
    xlabel([prt,'_{x} [V_A]']);
    ylabel([prt,'_{y} [V_A]']);
    suffix='_x-y';
end
xlim([-range,range]);
ylim([-range,range]);
set(gca,'FontSize',14);
cd(outdir)
print('-dpng','-r300',[name,suffix,'.png']);
end

function p = get_position(ll, pp)
% if i==1
%     p=ll(fix(pp))+(pp-fix(pp))*(ll(fix(pp)+1)-ll(fix(pp)));
% else
    p=(pp-1)*(ll(end)-ll(1))/(length(ll)-1)+ll(1);
% end
end

function [pvl, pvr] = split_distribution_function(pv,xp,nx,ny,Lx,Ly)
xx=linspace(0,Lx,nx);
yy=linspace(-Ly/2,Ly/2,ny);
np=length(pv.id);
idl=[];
vxl=[];
vyl=[];
vzl=[];
rxl=[];
ryl=[];
rzl=[];
idr=[];
vxr=[];
vyr=[];
vzr=[];
rxr=[];
ryr=[];
rzr=[];
% ll=yy;
ll=xx;
for i=1:np
    id=pv.id(i);
    vx=pv.vx(i);
    vy=pv.vy(i);
    vz=pv.vz(i);
    rx=pv.rx(i);
    ry=pv.ry(i);
    rz=pv.rz(i);
    p=get_position(ll, rx);
    if p<xp
        idl=[idl, id];
        vxl=[vxl, vx];
        vyl=[vyl, vy];
        vzl=[vzl, vz];
        rxl=[rxl, rx];
        ryl=[ryl, ry];
        rzl=[rzl, rz];
    else
        idr=[idr, id];
        vxr=[vxr, vx];
        vyr=[vyr, vy];
        vzr=[vzr, vz];
        rxr=[rxr, rx];
        ryr=[ryr, ry];
        rzr=[rzr, rz];
    end
end
pvl.id=idl;
pvl.vx=vxl;
pvl.vy=vyl;
pvl.vz=vzl;
pvl.rx=rxl;
pvl.ry=ryl;
pvl.rz=rzl;
pvr.id=idr;
pvr.vx=vxr;
pvr.vy=vyr;
pvr.vz=vzr;
pvr.rx=rxr;
pvr.ry=ryr;
pvr.rz=rzr;
end
