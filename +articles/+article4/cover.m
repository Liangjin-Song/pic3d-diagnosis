%%
clear;
%% parameters
indir = 'E:\Asym\cold2_ds1\data';
outdir = 'E:\Asym\cold2_ds1\out\Article\Paper4';
prm=slj.Parameters(indir,outdir);

yrange = [-3, 6];

%% read data
%% electric field
tt = 18;
Ez=prm.read('E',tt);
Ez=Ez.z/prm.value.vA;
ss = prm.read('stream', tt);

%% particle
id = uint64(1611735179);
%% read the particle
norm=0.5*prm.value.mi*prm.value.vA.^2;
prt=prm.read(['trajh_id',num2str(id)]);
den=prt.acceleration_direction(prm);
prt=prt.norm_energy(norm);
prt=prt.norm_electric_field(prm);

%% figure
f1=figure;
colordef black;
ax1 = axes;
h = slj.Plot.field2d(Ez, prm.value.lx, prm.value.lz, []);
set(h,'Location','North');
caxis(ax1, [-5,5]);
colormap(ax1, slj.Plot.mycolormap(0));
ylim(yrange);
set(gca,'XTicklabel',[], 'YTicklabel',[]);
box off
hidden off


pos = get(ax1, 'Position');
ax2 = axes('Position', pos');
slj.Plot.stream(ss,prm.value.lx,prm.value.lz,10,'-w');
hold on
trange0=1:6001;
cr=[0, max(prt.value.k(trange0))];
p=patch(prt.value.rx(trange0),prt.value.rz(trange0),[prt.value.k(trange0(1:end-1));NaN],'edgecolor','flat','facecolor','none');
set(p,'LineWidth',2);
caxis(ax2, cr);
colormap(ax2, 'jet');
ylim(yrange);
xlim([0,50]);
set(gca,'XTicklabel',[], 'YTicklabel',[]);
box off
axis off
hidden off
set(gcf, 'color','black');



%%
f2=figure;
vA=prm.value.vA;
vy=prt.value.vy/vA;
vz=prt.value.vz/vA;
vy=(vy(1:end-1)+vy(2:end))/2;
trange = trange0;
p=patch(vy(trange),vz(trange),[prt.value.k(trange(1):trange(end-1)); NaN],'edgecolor','flat','facecolor','none');
colormap('jet');
set(p,'LineWidth',3);
cb=colorbar;
% cb.Label.String='K_{ic}';
caxis([0,max(prt.value.k(trange))]);
xlabel('V_{\perp1}');
ylabel('V_{\perp2}');
set(gca,'FontSize', 12);
set(gcf,'color','black');

f3=figure;
name=['PVh_ts',num2str(tt/prm.value.wci),'_x1600-2000_y418-661_z0-1'];
precision=80;
extra.colormap='moon';
range = 2;
extra.xrange=[-range,range];
extra.yrange=[-range,range];
extra.log=true;
xrange=[41,42];
zrange=[1, 4];
yrange=[-100,100];
spc=prm.read(name);
spc=spc.subposition(xrange,yrange,zrange);
extra.xlabel='V_{\perp1}';
extra.ylabel='V_{\perp2}';
dst=spc.dstv(prm.value.vA,precision);
dst=dst.intgrtv(1);
slj.Plot.field2d(dst.value, dst.ll, dst.ll,extra);
set(gcf,'color','black');

cd(outdir);
