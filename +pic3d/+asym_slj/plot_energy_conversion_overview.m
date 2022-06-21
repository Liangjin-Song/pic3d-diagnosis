% function plot_energy_conversion_overview(name)
% clear;
%% parameters
indir='E:\Asym\cold2\data';
outdir='E:\Asym\cold2\out\Global';
prm=slj.Parameters(indir,outdir);

tt=28;
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
%     JE=E.dot(V);
    JE=slj.Scalar(V.z.*E.z);
    JE=JE*N;
    if name == 'e'
        JE=slj.Scalar(-JE.value);
    end
    f=figure('Visible', extra.Visible);
    slj.Plot.overview(N.value.*V.z.*E.z, ss, prm.value.lx, prm.value.lz, norm, extra);
    title(['J',sfx,'z\cdot Ez,  \Omega_{ci}t = ',num2str(tt(t))]);
    cd(outdir);
    print(f,'-dpng','-r300',['J',sfx,'z_dot_Ez_t',num2str(tt(t)),'.png']);
    close(gcf);
end