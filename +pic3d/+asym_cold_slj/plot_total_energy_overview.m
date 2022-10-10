% function plot_thermal_energy_overview(name)
% clear;
%%
indir='E:\Asym\cold2_ds1\data';
outdir='E:\Asym\cold2_ds1\out\Test';
prm=slj.Parameters(indir,outdir);

tt=40;
name='h';

nt=length(tt);

show=true;
extra=[];
extra.xlabel='X [c/\omega_{pi}]';
extra.ylabel='Z [c/\omega_{pi}]';

if name == 'h'
    tm=prm.value.thm;
    m=prm.value.mi;
    sfx='ic';
elseif name == 'l'
    tm=prm.value.tlm;
    m=prm.value.mi;
    sfx='ih';
elseif name == 'e'
    tm=prm.value.tem;
    m=prm.value.me;
    sfx='e';
end

norm=prm.value.nhm*tm/prm.value.coeff;
% norm=1;

for t=1:nt
    %% read data
    P=prm.read(['P',name],tt(t));
    V=prm.read(['V',name],tt(t));
    N=prm.read(['N',name],tt(t));
    ss=prm.read('stream',tt(t));
    %% calculation
    K=V.sqre();
    T=(P.xx+P.yy+P.zz).*0.5 + 0.5.*m.*N.value.*K.value;
    Ts = T./T;
    T = T + Ts - 1;

    %% figure
    figure('Visible', show);
    slj.Plot.overview(T, ss, prm.value.lx, prm.value.lz, norm, extra);
    title(['K',sfx,' + U',sfx,', \Omega_{ci}t=',num2str(tt(t))]);
    cd(outdir);
    print('-dpng','-r300',['KU',sfx,'_t',num2str(tt(t)),'.png']);
%     close(gcf);
end


% end
