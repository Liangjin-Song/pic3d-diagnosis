%% function plot_plasma_current_line
clear;
%% parameters
indir='E:\Asym\cold2_ds1\data';
outdir='E:\Asym\cold2_ds1\out\Test';
prm=slj.Parameters(indir,outdir);

tt=30;
name='e';

xz=-0.96;
dir=0;

xrange=[30,40];
nt=length(tt);

extra=[];
extra.xlabel='X [c/\omega_{pi}]';
extra.ylabel='Z [c/\omega_{pi}]';

norm=prm.value.n0*prm.value.vA;
nn = 1;

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
    V=prm.read(['V',name],tt(t));
    N=prm.read(['N',name],tt(t));
    %% calculation
    Jx=slj.Scalar(N.value.*V.x);
    Jy=slj.Scalar(N.value.*V.y);
    Jz=slj.Scalar(N.value.*V.z);
    if strcmp(name, 'e')
        Jx=slj.Scalar(-Jx.value);
        Jy=slj.Scalar(-Jy.value);
        Jz=slj.Scalar(-Jz.value);
    end
    

    %% get line
    ljx=Jx.get_line2d(xz,dir,prm,norm);
    ljy=Jy.get_line2d(xz,dir,prm,norm);
    ljz=Jz.get_line2d(xz,dir,prm,norm);
    
%     ljx = smoothdata(ljx, 'movmean', nn);
%     ljy = smoothdata(ljy, 'movmean', nn);
%     ljz = smoothdata(ljz, 'movmean', nn);

    %% plot figure
    plot(ll, ljx, 'r', 'LineWidth', 2); hold on
    plot(ll, ljy, 'b', 'LineWidth', 2);
    plot(ll, ljz, 'm', 'LineWidth', 2); hold off

    %% set figure
    xlim(xrange);
    legend(['J',sfx,'x'], ['J',sfx,'y'], ['J',sfx,'z'], 'Location', 'Best');
    xlabel('X [c/\omega_{pi}]');
    ylabel(['J',sfx]);
    title(['profiles  ', pstr,' = ',num2str(xz)]);
    set(gca,'FontSize',14);

    %% save figure
    cd(outdir);
%     print('-dpng','-r300',['J',sfx,'_t',num2str(tt(t)),'_line.png']);
%     close(gcf);
end



% end