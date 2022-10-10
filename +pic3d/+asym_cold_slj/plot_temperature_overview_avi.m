% function plot_temperature_overview(name)
clear;
%% 
indir='E:\Asym\cold2_ds1\data';
outdir='E:\Asym\cold2_ds1\out\Test';
prm=slj.Parameters(indir,outdir);



tt=0:100;
name='h';
sname='Tic';
disp(name);

nt=length(tt);

extra=[];
extra.xlabel='X [c/\omega_{pi}]';
extra.ylabel='Z [c/\omega_{pi}]';
extra.Visible=true;

if name == 'h'
    tm=prm.value.thm;
    sfx='ic';
elseif name == 'l'
    tm=prm.value.tlm;
    sfx='ih';
elseif name == 'e'
    tm=prm.value.tem;
    sfx='e';
end

norm=tm/prm.value.coeff;
% norm = 1;
extra=[];
extra.xlabel='X [c/\omega_{pi}]';
extra.ylabel='Z [c/\omega_{pi}]';
extra.caxis=[0,30];

aviname=[outdir,'\',sname,'.avi'];

aviobj=VideoWriter(aviname);
aviobj.FrameRate=5;
open(aviobj);

f=figure;

for t=1:nt
    %% read data
    P=prm.read(['P',name],tt(t));
    N=prm.read(['N',name],tt(t));
    ss=prm.read('stream',tt(t));
    %% calculation
    T=slj.Scalar((P.xx+P.yy+P.zz)./(N.value.*3));

    %% figure
    slj.Plot.overview(T, ss, prm.value.lx, prm.value.lz, norm, extra);
    title(['T',sfx,', \Omega_{ci}t=',num2str(tt(t))]);
    hold off
    currFrame = getframe(gcf);
    writeVideo(aviobj,currFrame);
%     cd(outdir);
%     print(f, '-dpng','-r300',['T',sfx,'_t',num2str(tt(t), '%06.2f'),'.png']);
%     close(gcf);
end
close(aviobj);

% end