%% function plot_distribution_spectrum
clear;
%% parameters
indir='E:\Asym\dst1\data';
outdir='E:\Asym\dst1\out\Kinetic\Distribution\Hot_Ions\Sheath';
prm=slj.Parameters(indir, outdir);

%% distribution name
tt=20;
name=['PVl_ts',num2str(tt/prm.value.wci),'_x600-1400_y418-661_z0-1'];
ennorm = prm.value.mi*prm.value.vA*prm.value.vA;
%% subposition
xrange = [24.5,25.5];
zrange = [0.1,2];
yrange = [-100,100];

%% subvelocity
vxrange = [-100, 100];
vyrange = [-100, 100];
vzrange = [-100, 100];

%% the figure style
%% the figure style
range=2;
precision=80;
extra.colormap='moon';
extra.xrange=[-range,range];
extra.yrange=[-range,range];
extra.log=true;

%% set the species
if name(3) == 'l'
    sfx='ih';
    m = prm.value.mi;
elseif name(3) == 'h'
    sfx='ic';
    m = prm.value.mi;
elseif name(3) == 'e'
    sfx = 'e';
    m = prm.value.me;
else
    error('Parameters Error!');
end

%% read data
spcs = prm.read(name);

%% select the particles
spcs=spcs.subposition(xrange,yrange,zrange);
% spcs=spcs.subvelocity(vxrange, vyrange, vzrange);

%% plot the distribution function
for vdir=1:3
    if vdir==1
        extra.xlabel=['V',sfx,'_y [V_A]'];
        extra.ylabel=['V',sfx,'_z [V_A]'];
        suffix='_vy_vz';
    elseif vdir == 2
        extra.xlabel=['V',sfx,'_x [V_A]'];
        extra.ylabel=['V',sfx,'_z [V_A]'];
        suffix='_vx_vz';
    else
        extra.xlabel=['V',sfx,'_x [V_A]'];
        extra.ylabel=['V',sfx,'_y [V_A]'];
        suffix='_vx_vy';
    end
    %% read data
    dst=spcs.dstv(prm.value.vA,precision);
    dst=dst.intgrtv(vdir);
    extra.title=['\Omega_{ci}t = ', num2str(dst.time)];
    %% plot figure
    f=slj.Plot();
    f.field2d(dst.value, dst.ll, dst.ll,extra);
%     f.png(prm,[name,suffix,'_sub',num2str(xrange(1)),'-',num2str(xrange(2)),...
%         '_',num2str(yrange(1)),'-',num2str(yrange(2)),...
%         '_',num2str(zrange(1)),'-',num2str(zrange(2))]);
%     f.close();
end

%% the spectrum
[fd, le] = spcs.spectrum(prm, m,23, ennorm, 200, false);
figure;
plot(le, fd, '-k', 'LineWidth', 2);
xlabel(['0.5 m_i(v_y^2 + v_z^2)  [m_i v_A^2]']);
ylabel(['f_{', sfx,'}']);
% yticks(0:1:10);
% yticklabels({'0','10^{1}','10^{2}','10^{3}','10^{4}','10^{5}','10^{6}','10^{7}','10^{8}','10^{9}','10^{10}'});
% xticks(-4:1:4);
% xticklabels({'10^{-4}','10^{-3}','10^{-2}','10^{-1}','10^{0}','10^{1}','10^{2}','10^{3}','10^{4}'});
set(gca,'FontSize',14);

%% the pitch angle
B = prm.read('B',tt);
[pa, lp] = spcs.pitch(prm, B, 150);
figure;
plot(lp, pa, '-k', 'LineWidth', 2);
xlabel('\theta')
ylabel(['f_{', sfx,'}']);
xlim([0,180]);
set(gca,'FontSize',14);
