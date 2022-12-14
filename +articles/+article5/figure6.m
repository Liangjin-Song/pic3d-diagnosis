%% the particles' trajectories in Figure 2
clear;
%% parameters
indir = 'E:\Asym\cold2_ds1\data';
outdir = 'E:\Asym\cold2_ds1\out\Article\Paper5';
prm = slj.Parameters(indir, outdir);

%% particles' id
id4 = '835629679';
id5 = '983841419';

%% time
tt=30;
tt0=3001;
trange=2701:4001;

%% figures
f=figure('Position',[500,10,600,1000]);
ha=slj.Plot.subplot(4,2,[0.05,0.1],[0.1,0.04],[0.12,0.02]);

%%
vxy.xtick = -0.4:0.2:0.6;
vxy.xtkble = {'-0.4', '-0.2', '0', '0.2', '0.4', '0.6'};
vxy.ytick = -1:0.5:1;
vxy.ytkble = {'-1', '-0.5', '0', '0.5', '1'};
vxz.xtick = -0.4:0.2:0.6;
vxz.xtkble = {'-0.4', '-0.2', '0', '0.2', '0.4', '0.6'};
vxz.ytick = -1:0.5:1;
vxz.ytkble = {'-1', '-0.5', '0', '0.5', '1'};
vyz.xtick = 0:0.5:1.5;
vyz.xtkble = {'0', '0.5', '1', '1.5'};
vyz.ytick = -1:0.5:1;
vyz.ytkble = {'-1', '-0.5', '0', '0.5', '1'};
particle_information(ha, 1, prm, id4, trange, tt, tt0, vxy, vxz, vyz);

%% 
vxy.xtick = 0.2:0.4:1;
vxy.xtkble = {'0.2', '0.6', '1'};
vxy.ytick = -1:0.5:1;
vxy.ytkble = {'-1', '-0.5', '0', '0.5', '1'};
vxz.xtick = 0.2:0.4:1;
vxz.xtkble = {'0.2', '0.6', '1'};
vxz.ytick = -1:0.5:1;
vxz.ytkble = {'-1', '-0.5', '0', '0.5', '1'};
vyz.xtick = -1:0.5:0.5;
vyz.xtkble = {'-1', '-0.5', '0', '0.5'};
vyz.ytick = -1:0.5:1;
vyz.ytkble = {'-1', '-0.5', '0', '0.5', '1'};
particle_information(ha, 2, prm, id5, trange, tt, tt0, vxy, vxz, vyz);

%% label
annotation(f,'textbox',...
    [0.225000000000001 0.925000000745056 0.182499995057782 0.0349999992549419],...
    'String',{'Particle 4'},...
    'LineStyle','none',...
    'FontSize',16,...
    'FontName','Times New Roman');
annotation(f,'textbox',...
    [0.710000000000003 0.925000000745056 0.182499995057782 0.0349999992549419],...
    'String',{'Particle 5'},...
    'LineStyle','none',...
    'FontSize',16,...
    'FontName','Times New Roman');

annotation(f,'textbox',...
    [0.05 0.889000000655651 0.0774999981870254 0.0319999993443489],...
    'String',{'(a)'},...
    'LineStyle','none',...
    'FontSize',14,...
    'FontName','Times New Roman');
annotation(f,'textbox',...
    [0.526666666666667 0.888000000655651 0.0791666648040216 0.0319999993443489],...
    'String',{'(b)'},...
    'LineStyle','none',...
    'FontSize',14,...
    'FontName','Times New Roman');
annotation(f,'textbox',...
    [0.116666666666668 0.703000000655652 0.0774999981870254 0.0319999993443489],...
    'String',{'(c)'},...
    'LineStyle','none',...
    'FontSize',14,...
    'FontName','Times New Roman');
annotation(f,'textbox',...
    [0.595000000000003 0.702000000655652 0.0791666648040216 0.0319999993443489],...
    'String',{'(d)'},...
    'LineStyle','none',...
    'FontSize',14,...
    'FontName','Times New Roman');
annotation(f,'textbox',...
    [0.115000000000003 0.476000000655652 0.0774999981870254 0.0319999993443489],...
    'String',{'(e)'},...
    'LineStyle','none',...
    'FontSize',14,...
    'FontName','Times New Roman');
annotation(f,'textbox',...
    [0.595000000000004 0.476000000655652 0.0741666649530331 0.0319999993443489],...
    'String',{'(f)'},...
    'LineStyle','none',...
    'FontSize',14,...
    'FontName','Times New Roman');
annotation(f,'textbox',...
    [0.115000000000003 0.248000000655652 0.0791666648040216 0.0319999993443489],...
    'String',{'(g)'},...
    'LineStyle','none',...
    'FontSize',14,...
    'FontName','Times New Roman');
annotation(f,'textbox',...
    [0.595000000000004 0.248000000655652 0.0791666648040216 0.0319999993443489],...
    'String',{'(h)'},...
    'LineStyle','none',...
    'FontSize',14,...
    'FontName','Times New Roman');



%% save
cd(outdir);
% print('-dpng', '-r300', 'figure6.png');


%% particle information
function particle_information(ha, ip, prm, id, trange, tt, tt0, vxy, vxz, vyz)
norm=0.5*prm.value.mi*prm.value.vA.^2;
prt=prm.read(['trajh_id',id]);
prt=prt.norm_energy(norm);
prt=prt.norm_electric_field(prm);


fs = 10;
star=trange(1):100:trange(end);

pw = 5;

%%
hi = ha(ip);
axes(hi);
trange0=trange;
ss=prm.read('stream',tt);
cr=[0, max(prt.value.k(trange0))];
slj.Plot.stream(ss,prm.value.lx,prm.value.lz,20);
hold on
p=patch(prt.value.rx(trange0),prt.value.rz(trange0),[prt.value.k(trange0(1:end-1));NaN],'edgecolor','flat','facecolor','none');
caxis(cr);
colormap('jet');
cb=colorbar('AxisLocation','out', 'Location', 'northoutside');
pos = get(cb, 'Position');
pos(2) = pos(2) - 0.018;
set(cb,'FontSize', fs, 'Position', pos);

pos0 = get(hi, 'Position');
pos0(2) = pos0(2) - 0.005;
set(hi, 'Position', pos0);

xlim([0,50]);
ylim([-10,10]);
set(p,'LineWidth',2);
xlabel('X [c/\omega_{pi}]');
if ip == 1
    ylabel('Z [c/\omega_{pi}]');
end
set(gca,'FontSize', fs);

%%
hi = ha(ip + 2);
vA=prm.value.vA;
vx=prt.value.vx/vA;
vy=prt.value.vy/vA;
vz=prt.value.vz/vA;
vy=(vy(1:end-1)+vy(2:end))/2;
axes(hi);
p=patch(vx(trange),vy(trange),[prt.value.k(trange(1):trange(end-1)); NaN],'edgecolor','flat','facecolor','none');
colormap('jet');
set(p,'LineWidth',2);
caxis([0,max(prt.value.k(trange))]);
hold on
plot(vx(star),vy(star),'*k','LineWidth',pw);
plot(vx(tt0),vy(tt0),'*r','LineWidth',pw); % distribution position
plot(vx(star(1)),vy(star(1)),'*g','LineWidth',pw); % begin
plot(vx(star(end)),vy(star(end)),'*b','LineWidth',pw); % end
hold off
xlabel('Vic_x [V_A]');
if ip == 1
    ylabel('Vic_y [V_A]');
else
    set(hi,'YTicklabel',[]);
end
set(gca,'XTick',vxy.xtick,'Xticklabel',vxy.xtkble);
set(gca,'YTick',vxy.ytick,'Yticklabel',vxy.ytkble);
set(gca,'FontSize', fs);

%%
hi = ha(ip + 4);
axes(hi);
p=patch(vx(trange),vz(trange),[prt.value.k(trange(1):trange(end-1)); NaN],'edgecolor','flat','facecolor','none');
colormap('jet');
set(p,'LineWidth',2);
caxis([0,max(prt.value.k(trange))]);
hold on
plot(vx(star),vz(star),'*k','LineWidth',pw);
plot(vx(tt0),vz(tt0),'*r','LineWidth',pw); % distribution position
plot(vx(star(1)),vz(star(1)),'*g','LineWidth',pw); % begin
plot(vx(star(end)),vz(star(end)),'*b','LineWidth',pw); % end
hold off
xlabel('Vic_x [V_A]');
if ip == 1
    ylabel('Vic_z [V_A]');
else
    set(hi,'YTicklabel',[]);
end
set(gca,'XTick',vxz.xtick,'Xticklabel',vxz.xtkble);
set(gca,'YTick',vxz.ytick,'Yticklabel',vxz.ytkble);
set(gca,'FontSize', fs);

%%
hi = ha(ip + 6);
axes(hi);
p=patch(vy(trange),vz(trange),[prt.value.k(trange(1):trange(end-1)); NaN],'edgecolor','flat','facecolor','none');
colormap('jet');
set(p,'LineWidth',2);
caxis([0,max(prt.value.k(trange))]);
hold on
plot(vy(star),vz(star),'*k','LineWidth',pw);
plot(vy(tt0),vz(tt0),'*r','LineWidth',pw); % distribution position
plot(vy(star(1)),vz(star(1)),'*g','LineWidth',pw); % begin
plot(vy(star(end)),vz(star(end)),'*b','LineWidth',pw); % end
hold off
xlabel('Vic_y [V_A]');
if ip == 1
    ylabel('Vic_z [V_A]');
else
    set(hi,'YTicklabel',[]);
end
set(gca,'XTick',vyz.xtick,'Xticklabel',vyz.xtkble);
set(gca,'YTick',vyz.ytick,'Yticklabel',vyz.ytkble);
set(gca,'FontSize', fs);
end