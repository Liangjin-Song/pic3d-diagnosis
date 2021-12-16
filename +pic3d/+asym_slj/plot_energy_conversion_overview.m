% function plot_energy_conversion_overview(name)
% clear;
%% parameters
indir='E:\Asym\Cold1\data';
outdir='E:\Asym\Cold1\out\Overview';
prm=slj.Parameters(indir,outdir);

tt=31;
name='e';

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
    % JE=slj.Scalar(V.y.*E.y);
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