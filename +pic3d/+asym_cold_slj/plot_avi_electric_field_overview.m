% function plot_density_overview()
%%
% plot the cold ions density overview
% writen by Liangjin Song on 20210629
%%
clear;
%% parameters
indir='E:\Asym\cold2_ds1\data';
outdir='E:\Asym\cold2_ds1\out\Test';
prm=slj.Parameters(indir,outdir);

%% variable information
tt=27.5:0.1:28.5;
norm=prm.value.vA;

%% direction
dname = 'para';

%% figure properties
extra=[];
extra.xlabel='X [c/\omega_{pi}]';
extra.ylabel='Z [c/\omega_{pi}]';
extra.caxis=[0,1.5];
aviname=[outdir,'\E_', dname,'.avi'];
% extra.title=['Nic, \Omega_{ci}t=',num2str(tt)];
% extra.xrange=[40,52];
% extra.yrange=[-5,5];
% extra.caxis=[0,1.5];

aviobj=VideoWriter(aviname);
aviobj.FrameRate=5;
open(aviobj);

f=figure;

nt=length(tt);
for t = 1:nt
    %% read data
    E=prm.read('E',tt(t));
    B=prm.read('B',tt(t));
    ss=prm.read('stream',tt(t));
    %% calculation
    [para, perp] = E.fac_vector(B);
    para = para.sqrt();
    perp = perp.sqrt();
    if strcmp(dname,'para')
        fd = para;
        sub = 'parallel';
    else
        fd = perp;
        sub = 'perp';
    end
    %% figure
    slj.Plot.overview(fd,ss,prm.value.lx,prm.value.lz,norm,extra);
    title(['E_{', sub,'}, \Omega_{ci}t = ',num2str(tt(t), '%06.2f')]);
    hold off;
    currFrame = getframe(gcf);
    writeVideo(aviobj,currFrame);
end
close(aviobj);
cd(outdir);