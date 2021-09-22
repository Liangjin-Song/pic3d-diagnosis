%% writen by Liangjin Song on 20210424
%% plot the ion and cold ion distribution function
%% directory
indir='E:\PIC\Cold-Ions\mie100\data';
outdir='E:\PIC\Cold-Ions\mie100\out\Distribution_Function\All_Ions';
sdir=1;
%% the file name
name1='PVh_ts99359_x1539-1750_y986-1015_z0-1';
name2='PVl_ts99359_x1539-1750_y986-1015_z0-1';

%% normalization
norm=0.0125;
range=1.5;

%% read data
cd(indir);
pv1=pic3d_read_data(name1);
pv2=pic3d_read_data(name2);

%% normalization
pv1.vx=pv1.vx/norm;
pv1.vy=pv1.vy/norm;
pv1.vz=pv1.vz/norm;
pv2.vx=pv2.vx/norm;
pv2.vy=pv2.vy/norm;
pv2.vz=pv2.vz/norm;

%% get the distribution
[fv1,lv]=pic3d_get_distribution_function(pv1);
[fv2,~]=pic3d_get_distribution_function(pv2);
fv=fv1+fv2;
suf=plot_distribution_x_y_z(fv,lv,sdir,range);
cd(outdir);
print('-dpng','-r300',['Dsti_',name1(5:end),'_',suf,'.png']);

function suffix=plot_distribution_x_y_z(fve,lv,sdir,range)
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
prt='Vi';
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