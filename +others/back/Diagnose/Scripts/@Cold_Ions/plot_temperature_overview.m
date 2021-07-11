function plot_temperature_overview()
%% writen by Liangjin Song on 20210411
%% plot temperature overview
indir='E:\PIC\Cold-Ions\mie100\data';
outdir='E:\PIC\Cold-Ions\mie100\out\Overview\range';
prm=Parameters(indir, outdir);
tt=27;
Pic=prm.read_data('Ph', tt);
Nic=prm.read_data('Nh',tt);
ss=prm.read_data('stream',tt);
Tic=Field();
Tic.value=(Pic.value.xx+Pic.value.yy+Pic.value.zz)./Nic.value;
Tic.norm=Pic.norm/Nic.norm;
extra.title=['T_{ic}, \Omega_{ci}t=',num2str(tt)];
extra.xrange=[30,70];
extra.yrange=[-10,10];
fig=Figures.plot_overview2d(Tic.value, ss.value, Tic.norm, prm, extra);
cd(prm.value.outdir);
extra.figname=['Tic_t',num2str(tt,'%06.2f')];
fig.printpng(extra);
fig.close();

