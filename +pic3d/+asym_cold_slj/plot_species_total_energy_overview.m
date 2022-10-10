% function plot_species_total_energy_overview
clear;
%% parameters
indir='E:\Asym\dst1\data';
outdir='E:\Asym\dst1\out\Tmp';
prm=slj.Parameters(indir,outdir);

%% time and species
tt=0:100;
name='h';

%% figure proterties
show=false;
extra=[];
extra.xlabel='X [c/\omega_{pi}]';
extra.ylabel='Z [c/\omega_{pi}]';

%% species name
if name == 'h'
    m=prm.value.mi;
    tm=prm.value.thm;
    sfx='ic';
elseif name == 'l'
    m=prm.value.mi;
    tm=prm.value.tlm;
    sfx='ih';
elseif name == 'e'
    m=prm.value.me;
    tm=prm.value.tem;
    sfx='e';
end

%% normlization
anorm=tm/prm.value.coeff;
tnorm=anorm*prm.value.n0;

%% time length
nt=length(tt);

for t=1:nt
    %% read data
    V=prm.read(['V',name],tt(t));
    N=prm.read(['N',name],tt(t));
    P=prm.read(['P',name],tt(t));
    ss=prm.read('stream',tt(t));

    %% bulk kinetic energy calculation
    K=V.sqre();
    K=slj.Scalar(0.5.*m.*N.value.*K.value);

    %% thermal energy calculation
    U=slj.Scalar((P.xx+P.yy+P.zz).*0.5);

    %% total energy
    E=slj.Scalar(K.value+U.value);

    %% average energy
    aE=slj.Scalar(E.value./N.value);

    %% plot figure
    cd(outdir);
    f1=figure('Visible', show);
    slj.Plot.overview(E, ss, prm.value.lx, prm.value.lz, tnorm, extra);
    title(['E',sfx,', \Omega_{ci}t=',num2str(tt(t))]);
    cd(outdir);
    print('-dpng','-r300',['K',sfx,'+U',sfx,'_t',num2str(tt(t)),'.png']);
    close(gcf);

    f2=figure('Visible', show);
    slj.Plot.overview(aE, ss, prm.value.lx, prm.value.lz, anorm, extra);
    title(['E',sfx,'/N',sfx,', \Omega_{ci}t=',num2str(tt(t))]);
    print('-dpng','-r300',['aver(K',sfx,'+U',sfx,')_t',num2str(tt(t)),'.png']);
    close(gcf);
end