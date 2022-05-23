% function avi_overview
%%
% @info: writen by Liangjin Song on 20210926
% @brief: plot the avi overview
%%
clear;
%% parameters
% input/output directory
indir='E:\Asym\dst1\data';
outdir='E:\Asym\dst1\out\Overview\avi';
prm=slj.Parameters(indir,outdir);

tt=20:60;
name='Nh';
sname='Nic';
norm=prm.value.n0;
extra.caxis=[-0.5,0.5];
aviname=[outdir,'\',sname,'.avi'];

%%
extra.xrange=[prm.value.lx(1),prm.value.lx(end)];
extra.yrange=[prm.value.lz(1),prm.value.lz(end)];
extra.xlabel='X [c/\omega_{pe}]';
extra.ylabel='Z [c/\omega_{pe}]';
lx=prm.value.lx;
ly=prm.value.lz;
aviobj=VideoWriter(aviname);
aviobj.FrameRate=10;
open(aviobj);
nt=length(tt);
figure('Visible', false);
for t=1:nt
    cd(indir);
    ss=prm.read('stream',tt(t));
    fd=prm.read(name,tt(t));
%     fd=fd.z;
    slj.Plot.overview(fd, ss, prm.value.lx, prm.value.lz, norm, extra);
    title([sname,'   \Omega_{ci}t=',num2str(tt(t))]);
    hold on
    xx = [38,48];
    zz = [-3,1];
    plot([xx(1),xx(2)],[zz(1), zz(1)], '-r', 'LineWidth', 2);
    plot([xx(1),xx(2)],[zz(2), zz(2)], '-r', 'LineWidth', 2);
    plot([xx(1),xx(1)],[zz(1), zz(2)], '-r', 'LineWidth', 2);
    plot([xx(2),xx(2)],[zz(1), zz(2)], '-r', 'LineWidth', 2);
    hold off
    currFrame = getframe(gcf);
    writeVideo(aviobj,currFrame);
end
close(aviobj);