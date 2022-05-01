% function plot_thermal_energy_overview(name)
% clear;
%%
indir='E:\Asym\dst1v2\data';
outdir='E:\Asym\dst1v2\out\Overview';
prm=slj.Parameters(indir,outdir);

tt=20:60;
name='h';

nt=length(tt);

show=false;
extra=[];
extra.xlabel='X [c/\omega_{pi}]';
extra.ylabel='Z [c/\omega_{pi}]';

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

norm=prm.value.n0*tm/prm.value.coeff;
% norm=1;
for t=1:nt
    %% read data
    P=prm.read(['P',name],tt(t));
    V=prm.read(['V',name],tt(t));
    N=prm.read(['N',name],tt(t));
    ss=prm.read('stream',tt(t));
    %% calculation
    K=V.sqre();
    T=slj.Scalar((P.xx+P.yy+P.zz).*0.5 + 0.5.*m.*N.value.*K.value);

    %% figure
    figure('Visible', show);
    slj.Plot.overview(T, ss, prm.value.lx, prm.value.lz, norm, extra);
    title(['K',sfx,' + U',sfx,', ', '\Omega_{ci}t=',num2str(tt(t))]);
    cd(outdir);
    print('-dpng','-r300',['KU',sfx,'_t',num2str(tt(t)),'.png']);
    close(gcf);
end


% end
