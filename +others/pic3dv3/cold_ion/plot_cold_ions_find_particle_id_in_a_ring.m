%% writen by Liangjin Song on 20210422
%% find the particles' id in ring
close(gcf);clear;
%% parameters
indir='E:\PIC\Cold-Ions\mie100\data';
name='PVh_ts99359_x999-1243_y988-1013_z0-1';
norm=0.0125;
range=0.35;
sdir=3;
%% the centre of the circle
x0=-0.03;
y0=0.03;
%% radius of the circle
r=2.5;
%% the width of the ring
dr=10;

%% read data
cd(indir);
pve=pic3d_read_data(name);
pve.vx=pve.vx/norm;
pve.vy=pve.vy/norm;
pve.vz=pve.vz/norm;
[fve,lv]=pic3d_get_distribution_function(pve);
plot_distribution_x_y_z(fve,lv,sdir,range,name);

%% find the particle's id
% the number of particles
np=length(pve.id);
id=[];
for i=1:np
    if sdir==1
        k=sqrt((pve.vy(i)-x0)^2+(pve.vz(i)-y0)^2);
    elseif sdir==2
        k=sqrt((pve.vx(i)-x0)^2+(pve.vz(i)-y0)^2);
    elseif sdir==3
        k=sqrt((pve.vx(i)-x0)^2+(pve.vy(i)-y0)^2);
    end
    if k>r && k<(r+dr)
        id=[id;pve.id(i)];
    end
end


function plot_distribution_x_y_z(fve,lv,sdir,range,name)
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
end