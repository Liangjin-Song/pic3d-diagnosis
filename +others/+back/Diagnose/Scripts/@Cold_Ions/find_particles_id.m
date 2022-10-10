%% find particles id according to particles distribution fundction
% writen by Liangjin Song on 20210330
%%
clear;
indir='E:\PIC\Cold-Ions\mie100\data';
outdir='E:\PIC\Cold-Ions\mie100\out\Distribution_Function';
name='PVh_ts99359_x999-1243_y988-1013_z0-1';
vrange.xrange=[-0.03,-0.02];
vrange.yrange=[0.02,0.03];
vrange.zrange=[0.02,0.03];
extra.range=0.3;
prm=Parameters(indir,outdir);
dst=prm.read_data(name);
dsta=dst.distribution_function(prm);
fig=Figures.draw(prm, dsta, extra);
id=dst.find_particles_id(prm,vrange);
fig.printpng(prm);
