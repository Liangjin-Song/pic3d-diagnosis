%% the particles' trajectories in Figure 2
clear;
%% parameters
indir = 'E:\Asym\cold2_ds1\data';
outdir = 'E:\Asym\cold2_ds1\out\Article\Paper5';
prm = slj.Parameters(indir, outdir);

%% particles' id
id1 = '1595262401';
id2 = '1543344803';
id3 = '1615483884';

%% time
tt=30;
tt0=3001;
trange=2001:5501;

%% figures
f=figure('Position',[500,10,1000,800]);
ha=slj.Plot.subplot(3,3,[0.08,0.07],[0.1,0.04],[0.1,0.02]);

%%
YZ.xtick = 0:10:40;
YZ.xtkble = {'0', '10', '20', '30', '40'};
YZ.ytick = -1.5:0.5:0;
YZ.ytkble = {'-1.5', '-1', '-0.5', '0'};
vyz.xtick = 0:0.5:1.5;
vyz.xtkble = {'0', '0.5', '1', '1.5'};
vyz.ytick = -1:0.5:1;
vyz.ytkble = {'-1', '-0.5', '0', '0.5', '1'};
particle_information(ha, 1, prm, id1, trange, tt, tt0, YZ, vyz);

%% 
YZ.xtick = -45:10:-15;
YZ.xtkble = {'-45', '-35', '-25', '-15'};
YZ.ytick = -0.5:0.5:2;
YZ.ytkble = {'-0.5', '0', '0.5', '1', '1.5', '2'};
vyz.xtick = -1:0.5:0;
vyz.xtkble = {'-1', '-0.5', '0'};
vyz.ytick = -1:0.5:1;
vyz.ytkble = {'-1', '-0.5', '0', '0.5', '1'};
particle_information(ha, 2, prm, id2, trange, tt, tt0, YZ, vyz);

%% 
YZ.xtick = -45:10:-15;
YZ.xtkble = {'-45', '-35', '-25', '-15'};
YZ.ytick = -2:2:4;
YZ.ytkble = {'-2', '-1', '0', '1', '2'};
vyz.xtick = -2:1:1;
vyz.xtkble = {'-2', '-1', '0', '1'};
vyz.ytick = -1.5:1:1.5;
vyz.ytkble = {'-1.5', '-0.5', '0.5', '1.5'};
particle_information(ha, 3, prm, id3, trange, tt, tt0, YZ, vyz);


%% label
annotation(f,'textbox',...
    [0.172 0.934000001005828 0.121499996677041 0.0462499989941716],...
    'String',{'Particle 1'},...
    'LineStyle','none',...
    'FontSize',18,...
    'FontName','Times New Roman');
annotation(f,'textbox',...
    [0.486000000000001 0.932750001005828 0.121499996677041 0.0462499989941716],...
    'String',{'Particle 2'},...
    'LineStyle','none',...
    'FontSize',18,...
    'FontName','Times New Roman');
annotation(f,'textbox',...
    [0.805 0.930250001005828 0.121499996677041 0.0462499989941716],...
    'String',{'Particle 3'},...
    'LineStyle','none',...
    'FontSize',18,...
    'FontName','Times New Roman');
annotation(f,'textbox',...
    [0.04 0.870250001005828 0.0564999986141921 0.0462499989941716],...
    'String',{'(a)'},...
    'LineStyle','none',...
    'FontSize',18,...
    'FontName','Times New Roman');
annotation(f,'textbox',...
    [0.363 0.869000001005828 0.0574999985843897 0.0462499989941716],...
    'String',{'(b)'},...
    'LineStyle','none',...
    'FontSize',18,...
    'FontName','Times New Roman');
annotation(f,'textbox',...
    [0.68 0.867750001005828 0.0564999986141921 0.0462499989941716],...
    'String',{'(c)'},...
    'LineStyle','none',...
    'FontSize',18,...
    'FontName','Times New Roman');
annotation(f,'textbox',...
    [0.046 0.626500001005827 0.0574999985843897 0.0462499989941716],...
    'String',{'(d)'},...
    'LineStyle','none',...
    'FontSize',18,...
    'FontName','Times New Roman');
annotation(f,'textbox',...
    [0.363 0.626500001005828 0.056499998614192 0.0462499989941716],...
    'String',{'(e)'},...
    'LineStyle','none',...
    'FontSize',18,...
    'FontName','Times New Roman');
annotation(f,'textbox',...
    [0.68 0.624000001005828 0.053499998703599 0.0462499989941716],...
    'String',{'(f)'},...
    'LineStyle','none',...
    'FontSize',18,...
    'FontName','Times New Roman');
annotation(f,'textbox',...
    [0.047 0.311500001005827 0.0574999985843897 0.0462499989941716],...
    'String',{'(g)'},...
    'LineStyle','none',...
    'FontSize',18,...
    'FontName','Times New Roman');
annotation(f,'textbox',...
    [0.364 0.309000001005828 0.0574999985843897 0.0462499989941716],...
    'String',{'(h)'},...
    'LineStyle','none',...
    'FontSize',18,...
    'FontName','Times New Roman');
annotation(f,'textbox',...
    [0.679 0.310250001005828 0.0524999987334014 0.0462499989941716],...
    'String',{'(i)'},...
    'LineStyle','none',...
    'FontSize',18,...
    'FontName','Times New Roman');


%% save
cd(outdir);
% print('-dpng', '-r300', 'figure3.png');
% print(f,'-depsc','-painters','figure3.eps');


%% particle information
function particle_information(ha, ip, prm, id, trange, tt, tt0, YZ, vyz)
norm=0.5*prm.value.mi*prm.value.vA.^2;
prt=prm.read(['trajh_id',id]);
prt=prt.norm_energy(norm);
prt=prt.norm_electric_field(prm);


fs = 12;
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
pos(2) = pos(2) - 0.022;
set(cb,'FontSize', fs, 'Position', pos);
pos0 = get(hi, 'Position');
pos0(2) = pos0(2) - 0.005;
set(hi, 'Position', pos0);
xlim([0,50]);
ylim([-10,10]);
set(p,'LineWidth',3);
xlabel('X [c/\omega_{pi}]');
if ip == 1
    ylabel('Z [c/\omega_{pi}]');
end
set(gca,'FontSize', fs);

%%
hi = ha(ip + 3);
axes(hi);
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
% y-z trajectory
p=patch(ry(trange),prt.value.rz(trange),[prt.value.k(trange(1):trange(end-1)); NaN],'edgecolor','flat','facecolor','none');
colormap('jet');
set(p,'LineWidth',3);
caxis([0,max(prt.value.k(trange))]);
hold on;
plot(ry(star),prt.value.rz(star),'*k','LineWidth',pw);
plot(ry(tt0),prt.value.rz(tt0),'*r','LineWidth',pw);
plot(ry(star(1)),prt.value.rz(star(1)),'*g','LineWidth',pw); % begin
plot(ry(star(end)),prt.value.rz(star(end)),'*b','LineWidth',pw); % end
hold off
xlabel('Y [c/\omega_{pi}]');
if ip == 1
    ylabel('Z [c/\omega_{pi}]');
end
if ip == 2
    ylim(hi, [-0.5, 2]);
end
set(gca,'XTick',YZ.xtick,'Xticklabel',YZ.xtkble);
set(gca,'YTick',YZ.ytick,'Yticklabel',YZ.ytkble);
set(gca,'FontSize', fs);

%%
hi = ha(ip + 6);
axes(hi);
p=patch(vy(trange),vz(trange),[prt.value.k(trange(1):trange(end-1)); NaN],'edgecolor','flat','facecolor','none');
colormap('jet');
set(p,'LineWidth',3);
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
if ip == 2
    ylim(hi, [-0.8, 0.8]);
end
set(gca,'XTick',vyz.xtick,'Xticklabel',vyz.xtkble);
set(gca,'YTick',vyz.ytick,'Yticklabel',vyz.ytkble);
set(gca,'FontSize', fs);
end