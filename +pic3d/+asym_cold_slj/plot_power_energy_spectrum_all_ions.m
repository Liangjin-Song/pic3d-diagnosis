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
sps1 = 'l';
sps2 = 'h';

%% the position range
zrange = [-1, 0.5];
xrange = [0, 50];
yrange=[-100,100];

dir = 0;


%% the number of grids of the spectrum in x and y direction
%% x direction is the position
%% z direction is the energy
ne = 2000;

%% normalization of the energy
norm = 0.5 * prm.value.mi * prm.value.vA * prm.value.vA;

%% the number of distribution function
ndf = 5;
%% the distribution function name
fix_name = '_y418-661_z0-1';
df_name1{1}=['PV',sps1,'_ts',num2str(tt/prm.value.wci),'_x0-400', fix_name];
df_name1{2}=['PV',sps1,'_ts',num2str(tt/prm.value.wci),'_x400-800', fix_name];
df_name1{3}=['PV',sps1,'_ts',num2str(tt/prm.value.wci),'_x800-1200', fix_name];
df_name1{4}=['PV',sps1,'_ts',num2str(tt/prm.value.wci),'_x1200-1600', fix_name];
df_name1{5}=['PV',sps1,'_ts',num2str(tt/prm.value.wci),'_x1600-2000', fix_name];
df_name2{1}=['PV',sps2,'_ts',num2str(tt/prm.value.wci),'_x0-400', fix_name];
df_name2{2}=['PV',sps2,'_ts',num2str(tt/prm.value.wci),'_x400-800', fix_name];
df_name2{3}=['PV',sps2,'_ts',num2str(tt/prm.value.wci),'_x800-1200', fix_name];
df_name2{4}=['PV',sps2,'_ts',num2str(tt/prm.value.wci),'_x1200-1600', fix_name];
df_name2{5}=['PV',sps2,'_ts',num2str(tt/prm.value.wci),'_x1600-2000', fix_name];

%% obtain the particles in the range
spc=prm.read(df_name1{1});
spcs=spc.subposition(xrange,yrange,zrange);
spc=prm.read(df_name2{1});
spc=spc.subposition(xrange,yrange,zrange);
spcs=spcs.add(spc);
for i=2:ndf
    spc=prm.read(df_name1{i});
    spc=spc.subposition(xrange,yrange,zrange);
    spcs = spcs.add(spc);
    spc=prm.read(df_name2{i});
    spc=spc.subposition(xrange,yrange,zrange);
    spcs = spcs.add(spc);
end
clear spc;

%% the weight
w = spcs.value.weight;

%% the energy
en = 0.5 .* prm.value.mi .* spcs.value.weight .* (spcs.value.vx.^2 + spcs.value.vy.^2 + spcs.value.vz.^2);
en = en ./ norm;

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

%% build the energy spectrum
en = log10(en);
% le = log10(linspace(min(en)*0.5, max(en) + min(en), ne));
le = linspace(min(en)*0.99, max(en)*1.01, ne);
nx = length(lx);
spm = zeros(ne, nx);
ns = length(en);
for s=1:ns
    %% find the position
    tmp = abs(lx - rr(s));
    [~, i] = min(tmp);
    tmp = abs(le - en(s));
    [~, j] = min(tmp);
    spm(j, i) = spm(j, i) + w(s);
end

%% plot the spectrum
figure;
[X, Y] = meshgrid(lx, le);
p=pcolor(X, Y, log10(spm));
shading flat;
% grid on;
p.FaceColor = 'interp';
% set(gca,'YScale','log');
set(gca, 'YTick', [-7, -6, -5, -4, -3, -2, -1, 0, 1, 2],'YTicklabel', ...
    {'10^{-7}', '10^{-6}', '10^{-5}', '10^{-4}', '10^{-3}', '10^{-2}', '10^{-1}', '10^{0}', '10^{1}', '10^{2}'});
h=colorbar;
set(h,'YTick',[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]','YTicklabel',{'10^1','10^2','10^3','10^4','10^5','10^6','10^7','10^8','10^9','10^{10}','10^{11}','10^{12}','10^{13}','10^{14}','10^{15}'});
colormap(slj.Plot.mycolormap(1));
ylabel('0.5 mv^2');
xlabel(labelx);
set(gca,'FontSize', 14);
% set(gca,'fontsize',14,'DataAspectRatio',[1 1 1],'PlotBoxAspectRatio',[1 1 1],...
%     'Xminortick','on','Yminortick','on','tickdir','out')

%% save figure
cd(outdir);
% print('-dpng','-r300',['i_energy_spectrum_t', num2str(tt,'%06.2f'),'.png']);