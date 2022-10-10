%% plot the energy spectrum
% @brief: plot the energy spectrum, x-axis is the position, andy y-axis is the energy, the colorbar is the density
% @info: written by Liangjin Song on 20220913
%%
clear;
%% parameters
indir='E:\Asym\cold2_ds1\data';
outdir='E:\Asym\cold2_ds1\out\Kinetic\Distribution\All_Ions';
prm=slj.Parameters(indir, outdir);

%% time and species
tt=30;
sps = 'l';

%% the position range
zrange = [-5, 5];
xrange = [41, 42];
yrange=[-100,100];

dir = 1;

%% the number of grids of the spectrum in x and y direction
%% x direction is the position
%% z direction is the energy
na = 200;

%% normalization of the energy
norm = 0.5 * prm.value.mi * prm.value.vA * prm.value.vA;

%% the number of distribution function
ndf = 5;
%% the distribution function name
fix_name = '_y418-661_z0-1';
df_name{1}=['PV',sps,'_ts',num2str(tt/prm.value.wci),'_x0-400', fix_name];
df_name{2}=['PV',sps,'_ts',num2str(tt/prm.value.wci),'_x400-800', fix_name];
df_name{3}=['PV',sps,'_ts',num2str(tt/prm.value.wci),'_x800-1200', fix_name];
df_name{4}=['PV',sps,'_ts',num2str(tt/prm.value.wci),'_x1200-1600', fix_name];
df_name{5}=['PV',sps,'_ts',num2str(tt/prm.value.wci),'_x1600-2000', fix_name];

%% obtain the particles in the range
spcs=prm.read(df_name{1});
spcs=spcs.subposition(xrange,yrange,zrange);
for i=2:ndf
    spc=prm.read(df_name{i});
    spc=spc.subposition(xrange,yrange,zrange);
    spcs = spcs.add(spc);
end
clear spc;

%% the weight
w = spcs.value.weight;

%% the position
if dir == 1
    labelx='Z [c/\omega_{pi}]';
    rr = spcs.value.rz;
    lx = prm.value.lz;
else
    labelx='X [c/\omega_{pi}]';
    rr = spcs.value.rx;
    lx = prm.value.lx;
end

%% the magnetic field
B = prm.read('B', tt);

%% the particles' position
px = spcs.value.rx;
px = (prm.value.nx - 1).*px./prm.value.Lx + 1;
pz = spcs.value.rz;
pz = (prm.value.nz - 1).*(pz+prm.value.Lz/2)./prm.value.Lz + 1;

%% the particles' velocity
vx = spcs.value.vx;
vy = spcs.value.vy;
vz = spcs.value.vz;

%% build the angle spectrum
la = linspace(0, 180, na);
nx = length(lx);
spm = zeros(na, nx);
ns = length(vx);
for s=1:ns
    %% the magnetic field at the particle's position
    bx = slj.Physics.linear_interp_2d(px(s), pz(s), B.x);
    by = slj.Physics.linear_interp_2d(px(s), pz(s), B.y);
    bz = slj.Physics.linear_interp_2d(px(s), pz(s), B.z);
    %% the pitch angle
    a = slj.Physics.pitch_angle(bx, by, bz, vx(s), vy(s), vz(s));
    %% find the position
    tmp = abs(lx - rr(s));
    [~, i] = min(tmp);
    tmp = abs(la - a);
    [~, j] = min(tmp);
    spm(j, i) = spm(j, i) + w(s);
end

%% plot the spectrum
figure;
[X, Y] = meshgrid(lx, la);
p=pcolor(X, Y, log10(spm));
shading flat;
% grid on;
p.FaceColor = 'interp';
% set(gca,'YScale','log');
h=colorbar;
set(h,'YTick',[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]','YTicklabel',{'10^1','10^2','10^3','10^4','10^5','10^6','10^7','10^8','10^9','10^{10}','10^{11}','10^{12}','10^{13}','10^{14}','10^{15}'});
colormap(slj.Plot.mycolormap(1));
ylabel('pitch angle');
xlabel(labelx);
set(gca,'FontSize', 14);
% set(gca,'fontsize',14,'DataAspectRatio',[1 1 1],'PlotBoxAspectRatio',[1 1 1],...
%     'Xminortick','on','Yminortick','on','tickdir','out')
%% save figure
cd(outdir);
% print('-dpng','-r300',[sps,'_pitch_angle_spectrum_t', num2str(tt,'%06.2f'),'.png']);

