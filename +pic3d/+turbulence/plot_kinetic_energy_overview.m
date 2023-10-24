% function plot_kinetic_energy_overview(name)
clear;
%% parameters
indir='Y:\turbulence5.55';
outdir='C:\Users\Liangjin\Pictures\Turbulence\Energy';
prm=slj.Parameters(indir,outdir);

tt=[0, 10, 20, 30, 50, 80, 90, 100, 120, 150, 180, 200, 220, 240];
name='e';
show=true;

nt=length(tt);

extra=[];
extra.xlabel='X [c/\omega_{pi}]';
extra.ylabel='Z [c/\omega_{pi}]';

if name == 'i'
    sfx='i';
    q=prm.value.qi;
    m=prm.value.mi;
elseif name == 'e'
    sfx = 'e';
    q=prm.value.qe;
    m=prm.value.me;
else
    error('Parameters Error!');
end

norm=0.5*m*prm.value.n0*prm.value.vA*prm.value.vA;
% norm=1;


for t=1:nt
    %% read data
    V=prm.read(['V',name],tt(t));
    N=prm.read(['N',name],tt(t));
%     B=prm.read('B', tt(t));
%     ss=slj.Physics.stream2d(B.x, B.z);
%     ss=prm.read('stream',tt(t));
    %% calculation
    K=V.sqre();
    K=0.5.*m.*N.value.*K.value/norm;

    %% figure
    figure('Visible', show);
    slj.Plot.field2d(K, prm.value.lx, prm.value.lz, extra);
%     slj.Plot.overview(K, ss, prm.value.lx, prm.value.lz, 1, extra);
    title(['K',sfx,', \Omega_{ci}t=',num2str(tt(t))]);
    cd(outdir);
    print('-dpng','-r300',['K',sfx,'_t',num2str(tt(t)),'.png']);
    close(gcf);
end


% end