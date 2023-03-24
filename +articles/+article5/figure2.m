%% the distribution function at the outflow region
clear;
%% parameters
indir = 'E:\Asym\cold2_ds1\data';
outdir = 'E:\Asym\cold2_ds1\out\Article\Paper5';
prm = slj.Parameters(indir, outdir);

%% the distribution function
name = 'PVh_ts48000_x1600-2000_y418-661_z0-1';
precision=80;
range = 2;
extra.colormap='moon';
extra.xrange=[-range,range];
extra.yrange=[-range,range];
extra.log=true;
extra.FontSize = 14;

%% the data
xrange=[41,42];
yrange=[-100,100];
spcs = prm.read(name);

%% figure
f=figure('Position',[500,10,1200,1200]);
ha=slj.Plot.subplot(4,3,[0.02,0.005],[0.07,0.03],[0.1,0.02]);

%% R1
zrange=[-1, 0];
caxs = [0, 3];
plot_VDFs(ha, 1, prm, spcs, xrange, yrange, zrange, caxs, precision, extra);

%% R2
zrange=[0, 1];
caxs = [0, 2.5];
plot_VDFs(ha, 4, prm, spcs, xrange, yrange, zrange, caxs, precision, extra);

%% R3
zrange=[1, 2.5];
caxs = [0, 2];
plot_VDFs(ha, 7, prm, spcs, xrange, yrange, zrange, caxs, precision, extra);

%% R4
zrange=[2.5, 4];
caxs=[0, 2];
plot_VDFs(ha, 10, prm, spcs, xrange, yrange, zrange, caxs, precision, extra);

%% Particles' Position
id1 = '1595262401';
id2 = '1543344803';
id3 = '1615483884';
plot_particle_position(id1, prm, ha, '*w');
plot_particle_position(id2, prm, ha, '*b');
plot_particle_position(id3, prm, ha, '*r');

%% theoratical
% fp=figure;
% polaraxes;
% varphi = -pi/2:0.01:pi/4;
% vp = 0.67./(1 - sin(varphi));
% polarplot(varphi, vp, '-b', 'LineWidth', 2);
% ax=gca;
% ax.ThetaDir = 'clockwise';
% ax.ThetaZeroLocation = 'top';
% [y, x] = pol2cart(varphi, vp);
% 
% figure(f);
% axes(ha(3));
% hold on
% plot(x, y, '-m', 'LineWidth', 2);


% x = -sqrt(1.16) : 0.01: sqrt(1.16);
% y = sqrt(1.16 - x.^2);
% plot(x, y, '-b', 'LineWidth', 2);
% plot(x, -y, '-b', 'LineWidth', 2);
% y = -0.1:0.01:0.1;
% x = sqrt(1.16 - y.^2);
% plot(x, y, '-b', 'LineWidth', 2);



%% label
annotation(f,'textbox',...
    [0.0975000000000001 0.938363817838028 0.042916665636003 0.0347912517444751],...
    'String',{'(a)'},...
    'LineStyle','none',...
    'FontSize',16,...
    'FontName','Times New Roman');
annotation(f,'textbox',...
    [0.392500000000001 0.939357853623314 0.0437499989445011 0.0347912517444751],...
    'String',{'(b)'},...
    'LineStyle','none',...
    'FontSize',16,...
    'FontName','Times New Roman');
annotation(f,'textbox',...
    [0.686666666666667 0.938363817838025 0.042916665636003 0.0347912517444751],...
    'String',{'(c)'},...
    'LineStyle','none',...
    'FontSize',16,...
    'FontName','Times New Roman');
annotation(f,'textbox',...
    [0.0975000000000002 0.708741551436435 0.0437499989445011 0.0347912517444751],...
    'String',{'(d)'},...
    'LineStyle','none',...
    'FontSize',16,...
    'FontName','Times New Roman');
annotation(f,'textbox',...
    [0.391666666666667 0.708741551436436 0.042916665636003 0.0347912517444751],...
    'String',{'(e)'},...
    'LineStyle','none',...
    'FontSize',16,...
    'FontName','Times New Roman');
annotation(f,'textbox',...
    [0.686666666666667 0.708741551436436 0.0412499990190069 0.0347912517444751],...
    'String',{'(f)'},...
    'LineStyle','none',...
    'FontSize',16,...
    'FontName','Times New Roman');
annotation(f,'textbox',...
    [0.0983333333333335 0.479119285034846 0.0437499989445011 0.0347912517444751],...
    'String',{'(g)'},...
    'LineStyle','none',...
    'FontSize',16,...
    'FontName','Times New Roman');
annotation(f,'textbox',...
    [0.392500000000001 0.478125249249558 0.0437499989445011 0.0347912517444751],...
    'String',{'(h)'},...
    'LineStyle','none',...
    'FontSize',16,...
    'FontName','Times New Roman');
annotation(f,'textbox',...
    [0.686666666666668 0.478125249249557 0.0404166657105088 0.0347912517444751],...
    'String',{'(i)'},...
    'LineStyle','none',...
    'FontSize',16,...
    'FontName','Times New Roman');
annotation(f,'textbox',...
    [0.0975000000000002 0.248502982847967 0.0404166657105089 0.0347912517444751],...
    'String',{'(j)'},...
    'LineStyle','none',...
    'FontSize',16,...
    'FontName','Times New Roman');
annotation(f,'textbox',...
    [0.392500000000001 0.248502982847967 0.0437499989445011 0.0347912517444751],...
    'String',{'(k)'},...
    'LineStyle','none',...
    'FontSize',16,...
    'FontName','Times New Roman');
annotation(f,'textbox',...
    [0.686666666666668 0.248502982847968 0.0404166657105088 0.0347912517444751],...
    'String',{'(l)'},...
    'LineStyle','none',...
    'FontSize',16,...
    'FontName','Times New Roman');



%%
annotation(f,'textbox',...
    [0.0125 0.84293638268735 0.0570833318804702 0.0427435377897847],...
    'String',{'R1'},...
    'LineStyle','none',...
    'FontSize',22,...
    'FontName','Times New Roman');
annotation(f,'textbox',...
    [0.0116666666666667 0.612320080500469 0.0570833318804702 0.0427435377897847],...
    'String',{'R2'},...
    'LineStyle','none',...
    'FontSize',22,...
    'FontName','Times New Roman');
annotation(f,'textbox',...
    [0.0125 0.38269781409888 0.0570833318804702 0.0427435377897847],...
    'String',{'R3'},...
    'LineStyle','none',...
    'FontSize',22,...
    'FontName','Times New Roman');
annotation(f,'textbox',...
    [0.0125 0.152081511912002 0.0570833318804702 0.0427435377897847],...
    'String',{'R4'},...
    'LineStyle','none',...
    'FontSize',22,...
    'FontName','Times New Roman');

%% save
cd(outdir);
% print('-dpng', '-r300', 'figure2.png');
% print(f,'-depsc','-painters','figure2.eps');


function h = plot_VDF(prm, spcs, xrange, yrange, zrange, vdir, precision, extra)
spc=spcs.subposition(xrange,yrange,zrange);
dst=spc.dstv(prm.value.vA,precision);
dst=dst.intgrtv(vdir);
h = slj.Plot.field2d(dst.value, dst.ll, dst.ll,extra);
set(gca, 'FontSize', 12);
end


function plot_VDFs(ha, i, prm, spcs, xrange, yrange, zrange, caxs, precision, extra)
sfx = 'ic';
dx = 0.05;

hi = ha(i+2);
axes(hi);
vdir = 1;
extra.ylabel=['V',sfx,'_z [V_A]'];
h = plot_VDF(prm, spcs, xrange, yrange, zrange, vdir, precision, extra);
caxis(caxs);
pos0 = get(hi, 'Position');
pos = pos0;
pos(3) = pos(3) - dx;
set(hi, 'Position', pos, 'Xminortick','on','Yminortick','on','tickdir','out');
hold on
box on;
axis on;


dx = 0.025;
hi = ha(i);
axes(hi);
vdir = 3;
extra.ylabel=['V',sfx,'_y [V_A]'];
h = plot_VDF(prm, spcs, xrange, yrange, zrange, vdir, precision, extra);
caxis(caxs);
delete(h);
pos = get(hi, 'Position');
pos(3) = pos0(3) - dx;
set(hi, 'Position', pos, 'Xminortick','on','Yminortick','on','tickdir','out');
hold on
box on;
axis on;


hi = ha(i+1);
axes(hi);
vdir = 2;
extra.ylabel=['V',sfx,'_z [V_A]'];
h = plot_VDF(prm, spcs, xrange, yrange, zrange, vdir, precision, extra);
caxis(caxs);
delete(h);
pos = get(hi, 'Position');
pos(3) = pos0(3) - dx;
set(hi, 'Position', pos, 'Xminortick','on','Yminortick','on','tickdir','out');
hold on
box on;
axis on;


if i ~= 10
    set(ha(i),'XTicklabel',[]);
    set(ha(i+1),'XTicklabel',[]);
    set(ha(i+2),'XTicklabel',[]);
end
if i == 10
    xlabel(ha(i), ['V',sfx,'_x [V_A]']);
    xlabel(ha(i+1), ['V',sfx,'_x [V_A]']);
    xlabel(ha(i+2), ['V',sfx,'_y [V_A]']);
end
end

function plot_particle_position(id, prm, ha, log)
tt = 30;
prt = prm.read(['trajh_id', id]);
prt=prt.norm_velocity(prm);
ttp = find(prt.value.time == tt);

axes(ha(1));
hold on
plot(prt.value.vx(ttp), prt.value.vy(ttp), log, 'LineWidth', 5);

axes(ha(2));
hold on
plot(prt.value.vx(ttp), prt.value.vz(ttp), log, 'LineWidth', 5);

axes(ha(3));
hold on
plot(prt.value.vy(ttp), prt.value.vz(ttp), log, 'LineWidth', 5);
end