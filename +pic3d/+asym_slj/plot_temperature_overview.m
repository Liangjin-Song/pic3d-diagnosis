% function plot_temperature_overview(name)
clear;
%% 
indir='E:\Asym\cb1\data';
outdir='E:\Asym\cb1\out\Overview';
prm=slj.Parameters(indir,outdir);

tt=30;
name='h';

nt=length(tt);

extra=[];
extra.xlabel='X [c/\omega_{pi}]';
extra.ylabel='Z [c/\omega_{pi}]';
extra.Visible=false;

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
    cd(outdir);
    % print('-dpng','-r300',['T',sfx,'_t',num2str(tt(t)),'.png']);
    % close(gcf);
end


% end