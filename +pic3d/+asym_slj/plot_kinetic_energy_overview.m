% function plot_kinetic_energy_overview(name)
clear;
%% parameters
indir='E:\Asym\cold2\data';
outdir='E:\Asym\cold2\out\Article';
prm=slj.Parameters(indir,outdir);

tt=40;
name='h';
show=true;

nt=length(tt);

extra=[];
extra.xlabel='X [c/\omega_{pi}]';
extra.ylabel='Z [c/\omega_{pi}]';

if name == 'l'
    sfx='ih';
    q=prm.value.qi;
    m=prm.value.mi;
    tm=prm.value.tlm;
elseif name == 'h'
    sfx='ic';
    q=prm.value.qi;
    m=prm.value.mi;
    tm=prm.value.thm;
elseif name == 'e'
    sfx = 'e';
    q=prm.value.qe;
    m=prm.value.me;
    tm=prm.value.tem;
else
    error('Parameters Error!');
end

% norm=0.5*m*prm.value.n0*prm.value.vA*prm.value.vA;
% norm=1;
norm=prm.value.n0*tm/prm.value.coeff;


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
%     close(gcf);
end


% end