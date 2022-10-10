% function plot_3s_density_profiles
%% plot the cold ions density profiles
clear;
%% parameters
indir='E:\Asym\cold2_ds1\data';
outdir='E:\Asym\cold2_ds1\out\Test';
prm=slj.Parameters(indir,outdir);
aviname=[outdir,'\density.avi'];
tt=0:60;
xz=41;
dir=1;
extra.xlabel='Z [c/\omega_{pi}]';
extra.ylabel='N';
extra.xrange=[-10,10];
fs=14;

aviobj=VideoWriter(aviname);
aviobj.FrameRate=3;
open(aviobj);
figure;

lxz=prm.value.lz;
nt = length(tt);
for t = 1:nt
    %% read data
    N=prm.read('Nh',tt(t));
    E=prm.read('E',tt(t));
    
    %% get the line
    ln=N.get_line2d(xz, dir, prm, prm.value.n0);
    le=E.get_line2d(xz, dir, prm, prm.value.vA);
    le=smoothdata(le.lz,'movmean',3);
    yyaxis left;
    plot(lxz, ln, '-r','LineWidth', 2);
    ylabel('Nic');
    xlim([-10,10]);
    ylim([0,1]);
    set(gca, 'ycolor','r');
    
    yyaxis right;
    plot(lxz, le, '-b','LineWidth', 2);
    xlabel('Z [c/\omega_{pi}]');
    ylabel('Ez');
    xlim([-10,10]);
    ylim([-1,4]);
    set(gca, 'ycolor','b');
    
    title(['\Omega_{ci}t = ',num2str(tt(t))]);
    set(gca,'FontSize', fs);
    currFrame = getframe(gcf);
    writeVideo(aviobj,currFrame);
end
close(aviobj);
cd(outdir);
% print('-dpng','-r300',['plasma_density_t',num2str(tt,'%06.2f'),'_',ps,num2str(xz),'.png']);
