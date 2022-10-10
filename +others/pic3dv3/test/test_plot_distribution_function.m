%% clear;
indir='E:\PIC\Distribution\data';
outdir='E:\PIC\Distribution\out';

name='PVe_ts4000_x230-270_y155-170_z0-1';
cd(indir);

fve=pic3d_read_data(name);
scatter(fve.y,fve.z,'r.');
xlim([-0.5,0.5]);
ylim([-0.5,0.5]);
% daspect([1 1 1]);
% axis square
xlabel('v_{ey}');
ylabel('v_{ez}');
set(gca,'FontSize',14);
% plot_veldist(ve,3,3,1);
cd(outdir);
print('-dpng','-r300',[name,'_y-z.png']);