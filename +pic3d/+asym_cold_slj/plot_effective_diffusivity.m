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
tt=30;

%% figure properties
extra=[];
extra.xlabel='X [c/\omega_{pi}]';
extra.ylabel='Z [c/\omega_{pi}]';

nt=length(tt);
for t = 1:nt
    %% read data
    B = prm.read('B', tt(t));
    E = prm.read('E', tt(t));
    J = prm.read('J', tt(t));
    V = prm.read('Ve', tt(t));
    ss=prm.read('stream',tt(t));
    %% calculation
    [eff, nmt, dnt] =slj.Physics.effective_diffusivity(prm, B, E, V, J);
    %% figure
    figure;
    slj.Plot.overview(eff,ss,prm.value.lx,prm.value.lz,1,extra);
    title('total')
    ylim([-10,10]);
    figure;
    slj.Plot.overview(nmt,ss,prm.value.lx,prm.value.lz,1,extra);
    title('分子')
    ylim([-10,10]);
    figure;
    slj.Plot.overview(dnt,ss,prm.value.lx,prm.value.lz,1,extra);
    title('分母')
    ylim([-10,10]);
    % f.png(prm,[name,'_t',num2str(tt),'_range'])
    cd(outdir);
%     print('-dpng','-r300',[name,'_t',num2str(tt(t),'%06.2f'),'.png']);
%     close(gcf);
end