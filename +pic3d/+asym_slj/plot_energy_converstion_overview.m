% function plot_energy_converstion_overview
clear;
%% parameters
indir='E:\Asym\cb1\data';
outdir='E:\Asym\cb1\out\Overview';
prm=slj.Parameters(indir,outdir);

tt=30;
name='h';

nt=length(tt);

extra=[];
extra.xlabel='X [c/\omega_{pi}]';
extra.ylabel='Z [c/\omega_{pi}]';

norm=prm.value.n0*prm.value.vA*prm.value.vA;

if name == 'l'
    sfx='ih';
elseif name == 'h'
    sfx='ic';
elseif name == 'e'
    sfx = 'e';
else
    error('Parameters Error!');
end



for t=1:nt
    %% read data
    E=prm.read('E',tt(t));
    V=prm.read(['V',name],tt(t));
    N=prm.read(['N',name],tt(t));
    ss=prm.read('stream',tt(t));
    %% calculation
    JE=E.dot(V);
    JE=JE*N;
    if name == 'e'
        JE=slj.Scalar(-JE.value);
    end
    slj.Plot.overview(JE, ss, prm.value.lx, prm.value.lz, norm, extra);
    title(['J',sfx,'\cdot E,  \Omega_{ci}t = ',num2str(tt(t))]);
    cd(outdir);
    print('-dpng','-r300',['J',sfx,'_dot_E_t',num2str(tt(t)),'.png']);
    close(gcf);
end