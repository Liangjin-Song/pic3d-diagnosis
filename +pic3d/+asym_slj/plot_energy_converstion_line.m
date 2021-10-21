% function plot_energy_converstion_line
clear;
%% parameters
indir='E:\Asym\Cold\data';
outdir='E:\Asym\Cold\out\Analysis\Electron';
prm=slj.Parameters(indir,outdir);

tt=100;
name='e';

xz=51;
dir=1;

nt=length(tt);

extra=[];
extra.xlabel='X [c/\omega_{pi}]';
extra.ylabel='Z [c/\omega_{pi}]';

norm=prm.value.n0*prm.value.vA*prm.value.vA;

xrange=[-5,5];


if dir == 1
    ll = prm.value.lz;
    labelx='Z [c/\omega_{pi}]';
    pstr='x';
else
    ll = prm.value.lx;
    labelx='X [c/\omega_{pi}]';
    pstr='z';
end

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
    %% calculation
    JE=E.dot(V);
    JE=JE*N;
    JEx=slj.Scalar(N.value.*V.x.*E.x);
    JEy=slj.Scalar(N.value.*V.y.*E.y);
    JEz=slj.Scalar(N.value.*V.z.*E.z);
    if strcmp(name, 'e')
        JE=slj.Scalar(-JE.value);
        JEx=slj.Scalar(-JEx.value);
        JEy=slj.Scalar(-JEy.value);
        JEz=slj.Scalar(-JEz.value);
    end
    

    %% get line
    lje=JE.get_line2d(xz,dir,prm,norm);
    ljex=JEx.get_line2d(xz,dir,prm,norm);
    ljey=JEy.get_line2d(xz,dir,prm,norm);
    ljez=JEz.get_line2d(xz,dir,prm,norm);

    %% plot figure
    plot(ll, lje, '-k', 'LineWidth', 2); hold on
    plot(ll, ljex, 'r', 'LineWidth', 2);
    plot(ll, ljey, 'b', 'LineWidth', 2);
    plot(ll, ljez, 'm', 'LineWidth', 2); hold off

    %% set figure
    xlim(xrange);
    legend(['J',sfx,' \cdot E'], ['J',sfx,'xEx'], ['J',sfx,'yEy'], ['J',sfx,'zEz'], 'Location', 'Best');
    xlabel('Z [c/\omega_{pi}]');
    ylabel(['J',sfx,'\cdot E']);
    title(['profiles  ', pstr,' = ',num2str(xz)]);
    set(gca,'FontSize',14);

    %% save figure
    cd(outdir);
    print('-dpng','-r300',['J',sfx,'_dot_E_t',num2str(tt(t)),'_line.png']);
%     close(gcf);
end