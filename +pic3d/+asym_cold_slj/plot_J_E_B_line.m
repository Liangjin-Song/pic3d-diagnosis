%% function plot_J_E_B_line
clear;
%% parameters
indir='E:\Asym\Cold\data';
outdir='E:\Asym\Cold\out\Analysis\Electron';
prm=slj.Parameters(indir,outdir);

tt=100;
name='h';

xz=51;
dir=1;

nt=length(tt);

normE=prm.value.vA;
normJ=prm.value.n0*prm.value.vA;
normB=1;

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
    B=prm.read('B',tt(t));
    V=prm.read(['V',name],tt(t));
    N=prm.read(['N',name],tt(t));

    %% calculation
    % current
    Jx=slj.Scalar(N.value.*V.x);
    Jy=slj.Scalar(N.value.*V.y);
    Jz=slj.Scalar(N.value.*V.z);
    
    if name == 'e'
        Jx=slj.Scalar(-Jx.value);
        Jy=slj.Scalar(-Jy.value);
        Jz=slj.Scalar(-Jz.value);
    end
    % energy conversion
    JEx=slj.Scalar(Jx.value.*E.x);
    JEy=slj.Scalar(Jy.value.*E.y);
    JEz=slj.Scalar(Jz.value.*E.z);

    %% get line
    lj=Jz.get_line2d(xz,dir,prm,normJ);
    le=E.get_line2d(xz,dir,prm,normE);
    lb=B.get_line2d(xz,dir,prm,normB);
    lje=JEz.get_line2d(xz,dir,prm,normJ*normE);


    %% plot figure
    plot(ll, lj*10, '-r', 'LineWidth', 2); hold on
    plot(ll, le.lz, '-b', 'LineWidth', 2);
    plot(ll, le.ly, '-g', 'LineWidth', 2);
    plot(ll, lb.lx, '-m', 'LineWidth', 2);
    plot(ll, lje*10, '-k', 'LineWidth', 2); hold off


    %% set figure
    xlim(xrange);
    legend(['J',sfx,'z*10'], 'Ez', 'Ey', 'Bx',['J',sfx,'zEz*10'], 'Location', 'Best');
    xlabel('Z [c/\omega_{pi}]');
    title(['profiles  ', pstr,' = ',num2str(xz)]);
    set(gca,'FontSize',14);

    %% save figure
    cd(outdir);
    print('-dpng','-r300',['J',sfx,'_E_B_t',num2str(tt(t)),'_line.png']);
    % close(gcf);
end



% end