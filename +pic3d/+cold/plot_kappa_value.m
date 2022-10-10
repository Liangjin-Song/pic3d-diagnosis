%% plot the kappa value distribution
% clear;
%% parameters
indir='E:\PIC\Cold-Ions\mie100\data';
outdir='E:\PIC\Cold-Ions\mie100\out';
prm=slj.Parameters(indir,outdir);

tt=30;
name='h';

%% figure style
extra=[];
extra.xlabel='X [c/\omega_{pi}]';
extra.ylabel='Z [c/\omega_{pi}]';
extra.xrange=[30,70];
extra.yrange=[-10,10];

if name == 'h'
    m=prm.value.mi;
    q=prm.value.qi;
    sfx='ic';
elseif name == 'l'
    m=prm.value.mi;
    q=prm.value.qi;
    sfx='ih';
elseif name == 'e'
    m=prm.value.me;
    q=prm.value.qe;
    sfx='e';
elseif strcmp(name, 'he')
    m=prm.value.me;
    q=prm.value.qe;
    sfx='he';
end

extra.title=['\kappa_{',sfx, '},  \Omega_{ci}t = ', num2str(tt)];

%% read data
P=prm.read(['P',name],tt);
N=prm.read(['N',name],tt);
B=prm.read('B',tt);
ss=prm.read('stream',tt);

%% calculation
T = slj.Physics.temperature(P, N);
K = slj.Physics.kappa(prm, q, m, T, B);

%% figure
figure;
slj.Plot.overview(K,ss,prm.value.lx,prm.value.lz,1,extra);
caxis([0,5]);
cd(outdir);
