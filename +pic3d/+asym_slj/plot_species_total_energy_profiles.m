% function plot_species_total_energy_line
clear;
%% parameters
indir='E:\Asym\Cold1\data';
outdir='E:\Asym\Cold1\out\Energy\Cold';
prm=slj.Parameters(indir,outdir);

%% time and species
tt=6;
name='h';

%% line position
xz=25;
dir=1;

%% figure properties
xrange=[-5,3];
FontSize=14;

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

%% line
if dir == 1
    ll = prm.value.lz;
    labelx='Z [c/\omega_{pi}]';
    pstr='x';
else
    ll = prm.value.lx;
    labelx='X [c/\omega_{pi}]';
    pstr='z';
end

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
    aK=slj.Scalar(K.value./N.value);
    aU=slj.Scalar(U.value./N.value);

    %% get line
    lk=K.get_line2d(xz,dir,prm,tnorm);
    lu=U.get_line2d(xz,dir,prm,tnorm);
    le=E.get_line2d(xz,dir,prm,tnorm);
    alk=aK.get_line2d(xz,dir,prm,anorm);
    alu=aU.get_line2d(xz,dir,prm,anorm);
    ale=aE.get_line2d(xz,dir,prm,anorm);


    %% plot figure
    cd(outdir);
    f1=figure;
    plot(ll, lk, '-r', 'LineWidth', 2);
    hold on
    plot(ll, lu, '-b', 'LineWidth', 2);
    plot(ll, le, '-k', 'LineWidth', 2);
    xlim(xrange);
    xlabel(labelx);
    ylabel(['E',sfx]);
    legend(['K',sfx],['U',sfx], ['E',sfx], 'Location', 'Best');
    title(['Profiles  ',pstr,'=',num2str(xz),', \Omega_{ci}t=',num2str(tt(t))]);
    set(gca, 'FontSize', FontSize);

    f2=figure;
    plot(ll, alk, '-r', 'LineWidth', 2);
    hold on
    plot(ll, alu, '-b', 'LineWidth', 2);
    plot(ll, ale, '-k', 'LineWidth', 2);
    xlim(xrange);
    xlabel(labelx);
    ylabel(['E',sfx,'/N',sfx]);
    legend(['K',sfx, '/N',sfx],['U',sfx, '/N',sfx], ['E',sfx, '/N',sfx], 'Location', 'Best');
    title(['Profiles  ',pstr,'=',num2str(xz),', \Omega_{ci}t=',num2str(tt(t))]);
    set(gca, 'FontSize', FontSize);
end
