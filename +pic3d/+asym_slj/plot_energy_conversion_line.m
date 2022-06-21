% function plot_energy_converstion_line
clear;
%% parameters
indir='E:\Asym\cold2\data';
outdir='E:\Asym\cold2\out\Global';
% indir='E:\Asym\dst1\data';
% outdir='E:\Asym\dst1\out\Global';
prm=slj.Parameters(indir,outdir);

tt=28;
name='h';

xz=40;
dir=1;

nn = 15;

nt=length(tt);

extra=[];
extra.xlabel='X [c/\omega_{pi}]';
extra.ylabel='Z [c/\omega_{pi}]';

norm=prm.value.n0*prm.value.vA*prm.value.vA;

xrange=[-10,10];


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
    lje=JE.get_line2d(xz,dir,prm,1);
    ljex=JEx.get_line2d(xz,dir,prm,1);
    ljey=JEy.get_line2d(xz,dir,prm,1);
    ljez=JEz.get_line2d(xz,dir,prm,1);
    
    % smooth
    lje = smoothdata(lje, 'movmean', nn);
    ljex = smoothdata(ljex, 'movmean', nn);
    ljey = smoothdata(ljey, 'movmean', nn);
    ljez = smoothdata(ljez, 'movmean', nn);
    

    %% plot figure
    plot(ll, lje/norm, '-k', 'LineWidth', 2); hold on
    plot(ll, ljex/norm, 'r', 'LineWidth', 2);
    plot(ll, ljey/norm, 'b', 'LineWidth', 2);
    plot(ll, ljez/norm, 'g', 'LineWidth', 2); hold off

    %% set figure
    xlim(xrange);
    legend(['J',sfx,' \cdot E'], ['J',sfx,'xEx'], ['J',sfx,'yEy'], ['J',sfx,'zEz'], 'Location', 'Best');
    xlabel('Z [c/\omega_{pi}]');
    ylabel(['J',sfx,'\cdot E']);
    title(['\Omega_{ci}t = ',num2str(tt(t)),', profiles  ', pstr,' = ',num2str(xz)]);
    set(gca,'FontSize',14);

    %% save figure
    cd(outdir);
    print('-dpng','-r300',['J',sfx,'_dot_E_t',num2str(tt(t)),'_', pstr,' = ',num2str(xz),'.png']);
    close(gcf);
end