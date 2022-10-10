% function plot_kinetic_energy_overview(name)
% clear;
%% parameters
indir='E:\PIC\Cold-Ions\mie100\data';
outdir='E:\PIC\Cold-Ions\mie100\out\Energy\Kinetic';
prm=slj.Parameters(indir,outdir);

tt=45;
name='h';
show=true;

nt=length(tt);

extra=[];
extra.xlabel='X [c/\omega_{pi}]';
extra.ylabel='Z [c/\omega_{pi}]';

if name == 'h'
    m=prm.value.mi;
    sfx='ic';
elseif name == 'l'
    m=prm.value.mi;
    sfx='ih';
elseif name == 'e'
    m=prm.value.me;
    sfx='e';
end

% norm=0.5*m*prm.value.n0*prm.value.vA*prm.value.vA;
norm=1;
% norm=prm.value.n0*tm/prm.value.coeff;


for t=1:nt
    %% read data
    V=prm.read(['V',name],tt(t));
    N=prm.read(['N',name],tt(t));
    ss=prm.read('stream',tt(t));
    %% calculation
    K=V.sqre();
    K=slj.Scalar(0.5.*m.*N.value.*K.value);

    %% figure
    figure('Visible', show);
    slj.Plot.overview(K, ss, prm.value.lx, prm.value.lz, norm, extra);
    title(['K',sfx,', \Omega_{ci}t=',num2str(tt(t))]);
    cd(outdir);
    print('-dpng','-r300',['K',sfx,'_t',num2str(tt(t)),'.png']);
    close(gcf);
end


% end