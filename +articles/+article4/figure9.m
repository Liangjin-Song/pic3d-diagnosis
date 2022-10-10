%%
% figure9
% a particle performing meandering motion
%%
clear;
%% parameters
indir = 'E:\Asym\cold2_ds1\data';
outdir = 'E:\Asym\cold2_ds1\out\Article';
prm=slj.Parameters(indir,outdir);
datdir = 'E:\Asym\cold2_ds1\out\Article\data';

%% figure proterties
fontsize = 14;

%% particle's id
id = uint64(1103913861);

%% time
tt=18;
tt0=1801;
trange=1301:3701;
star=trange(1):100:trange(end);

%% read the particle
norm=0.5*prm.value.mi*prm.value.vA.^2;
prt=prm.read(['trajh_id',num2str(id)]);
den=prt.acceleration_direction(prm);
prt=prt.norm_energy(norm);
prt=prt.norm_electric_field(prm);



%% figure size
f=figure('Position',[300,100,900,700]);
ha=slj.Plot.subplot(2,2,[0.11,0.11],[0.1,0.03],[0.1,0.05]);

%% plot distribution function
axes(ha(4));
name=['PVh_ts',num2str(tt/prm.value.wci),'_x800-1200_y418-661_z0-1'];
precision=80;
extra.colormap='moon';
range = 2;
extra.xrange=[-range,range];
extra.yrange=[-range,range];
extra.log=true;
xrange=[24.5,25.5];
zrange=[1, 4];
yrange=[-100,100];
spc=prm.read(name);
spc=spc.subposition(xrange,yrange,zrange);
extra.xlabel='Vicy';
extra.ylabel='Vicz';
dst=spc.dstv(prm.value.vA,precision);
dst=dst.intgrtv(1);
slj.Plot.field2d(dst.value, dst.ll, dst.ll,extra);
hold on
ttp = find(prt.value.time == tt);
plot(prt.value.vy(ttp)/prm.value.vA, prt.value.vz(ttp)/prm.value.vA,'b*', 'LineWidth', 5);

%% trajectory in x-z plane
axes(ha(1));
dh=0.05;
trange0=1:trange(end);
trange0=trange;
ss=prm.read('stream',tt);
cr=[0, max(prt.value.k(trange0))];
slj.Plot.stream(ss,prm.value.lx,prm.value.lz,20);
hold on
p=patch(prt.value.rx(trange0),prt.value.rz(trange0),[prt.value.k(trange0(1:end-1));NaN],'edgecolor','flat','facecolor','none');
caxis(cr);
colormap('jet');
cb=colorbar;
cb.Label.FontSize=fontsize;
xlim([15,35]);
ylim([-8,8]);
xlabel('X [c/\omega_{pi}]');
ylabel('Z [c/\omega_{pi}]');
set(p,'LineWidth',3);
xx = [24.5,25.5];
zz = [1,4];
hold on
plot([xx(1),xx(2)],[zz(1), zz(1)], '-k', 'LineWidth', 2);
plot([xx(1),xx(2)],[zz(2), zz(2)], '-k', 'LineWidth', 2);
plot([xx(1),xx(1)],[zz(1), zz(2)], '-k', 'LineWidth', 2);
plot([xx(2),xx(2)],[zz(1), zz(2)], '-k', 'LineWidth', 2);

%% trajector in y-z plane
axes(ha(3));
vA=prm.value.vA;
vy=prt.value.vy/vA;
vz=prt.value.vz/vA;
vy=(vy(1:end-1)+vy(2:end))/2;
% y position
nvy=length(vy);
ry=zeros(nvy+1,1);
for i=1:nvy
    ry(i+1)=ry(i)+vy(i)*0.02;
end
p=patch(ry(trange),prt.value.rz(trange),[prt.value.k(trange(1):trange(end-1)); NaN],'edgecolor','flat','facecolor','none');
colormap('jet');
set(p,'LineWidth',3);
cb=colorbar;
cb.Label.FontSize=fontsize;
caxis([0,max(prt.value.k(trange))]);

hold on;
plot(ry(star),prt.value.rz(star),'*k','LineWidth',8);
plot(ry(tt0),prt.value.rz(tt0),'*r','LineWidth',8);
plot(ry(star(1)),prt.value.rz(star(1)),'*g','LineWidth',8); % begin
plot(ry(star(end)),prt.value.rz(star(end)),'*b','LineWidth',8); % end
hold off
xlabel('Y [c/\omega_{pi}]');
ylabel('Z [c/\omega_{pi}]');
set(gca,'XTick',-40:10:0, 'XTicklabel',{'-40', '-30', '-20', '-10', '0'}, ...
    'YTick', -2:2:4, 'YTicklabel', {'-2', '0', '2', '4'});
set(gca,'FontSize',fontsize);

%% vy-vz
axes(ha(2));
p=patch(vy(trange),vz(trange),[prt.value.k(trange(1):trange(end-1)); NaN],'edgecolor','flat','facecolor','none');
colormap('jet');
set(p,'LineWidth',3);
cb=colorbar;
% cb.Label.String='K_{ic}';
cb.Label.FontSize=fontsize;
caxis([0,max(prt.value.k(trange))]);
hold on
plot(vy(star),vz(star),'*k','LineWidth',8);
plot(vy(tt0),vz(tt0),'*r','LineWidth',8); % distribution position
plot(vy(star(1)),vz(star(1)),'*g','LineWidth',8); % begin
plot(vy(star(end)),vz(star(end)),'*b','LineWidth',8); % end
hold off
xlabel('Vicy');
ylabel('Vicz');
set(gca,'XTick',-2:1, 'XTicklabel', {'-2', '-1', '0', '1'}, ...
    'YTick', -2:2, 'YTicklabel', {'-2', '-1', '0', '1', '2'});
set(gca,'FontSize',fontsize);


colormap(ha(4), slj.Plot.mycolormap(1));


%% panel label
fontsize=fontsize + 2;
annotation(f,'textbox',...
    [0.0433333333333333 0.903285715307507 0.0549999986920092 0.0485714275496347],...
    'String',{'(a)'},...
    'LineStyle','none',...
    'FontSize',fontsize);
annotation(f,'textbox',...
    [0.524444444444444 0.914714286736074 0.0549999986920092 0.0485714275496347],...
    'String',{'(b)'},...
    'LineStyle','none',...
    'FontSize',fontsize);
annotation(f,'textbox',...
    [0.0422222222222222 0.427571429593221 0.0538888876140118 0.0485714275496347],...
    'String',{'(c)'},...
    'LineStyle','none',...
    'FontSize',fontsize);
annotation(f,'textbox',...
    [0.524444444444445 0.427571429593221 0.0549999986920092 0.0485714275496347],...
    'String',{'(d)'},...
    'LineStyle','none',...
    'FontSize',fontsize);



%% save figure
cd(outdir);
% print(f,'-dpng','-r300','figure9.png');
print(f,'-depsc','-painters','figure9.eps');