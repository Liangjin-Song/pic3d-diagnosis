% function plot_energy_conversion_overview(name)
clear;
%% parameters
indir='E:\Asym\cold2v2\data';
outdir='E:\Asym\cold2v2\out\Article';
prm=slj.Parameters(indir,outdir);

tt=39;
name='h';

nt=length(tt);

extra=[];
extra.xlabel='X [c/\omega_{pi}]';
extra.ylabel='Z [c/\omega_{pi}]';
extra.Visible=true;

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
%     JE=slj.Scalar(V.y.*E.y);
    JE=JE*N;
    if name == 'e'
        JE=slj.Scalar(-JE.value);
    end
    f=figure('Visible', extra.Visible);
    slj.Plot.overview(JE, ss, prm.value.lx, prm.value.lz, norm, extra);
    title(['J',sfx,'\cdot E,  \Omega_{ci}t = ',num2str(tt(t))]);
    cd(outdir);
%     print(f,'-dpng','-r300',['J',sfx,'y_dot_Ey_t',num2str(tt(t)),'.png']);
%     close(gcf);
end