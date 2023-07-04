% function plot_energy_converstion_line
clear;
%% parameters
indir='Z:\ion_deceleration\case2_2harris';
outdir='C:\Users\Liangjin\Pictures\Asym\case2_2harris\Test';
prm=slj.Parameters(indir,outdir);

tt=5;
name='i';

xz=25;
dd=0;
dir=1;

nn = 1;

nt=length(tt);

extra=[];
extra.xlabel='X [c/\omega_{pi}]';
extra.ylabel='Z [c/\omega_{pi}]';

norm=prm.value.n0*prm.value.vA*prm.value.vA;

xrange=[-20,-5];


if dir == 1
    ll = prm.value.lz;
    labelx='Z [c/\omega_{pi}]';
    pstr='x';
else
    ll = prm.value.lx;
    labelx='X [c/\omega_{pi}]';
    pstr='z';
end

if name == 'i'
    sfx='i';
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
    JE=JE.value.*N.value;
    JEx=N.value.*V.x.*E.x;
    JEy=N.value.*V.y.*E.y;
    JEz=N.value.*V.z.*E.z;
    if strcmp(name, 'e')
        JE=-JE;
        JEx=-JEx;
        JEy=-JEy;
        JEz=-JEz;
    end
    
    
    %% get line
    %     lje=JE.get_line2d(xz,dir,prm,1);
    %     ljex=JEx.get_line2d(xz,dir,prm,1);
    %     ljey=JEy.get_line2d(xz,dir,prm,1);
    %     ljez=JEz.get_line2d(xz,dir,prm,1);
    if dir == 0
        sdir = 'x';
        xlab = 'X [c/\omega_{pi}]';
        ll = prm.value.lx;
        lp = prm.value.lz;
        [~, xz] = min(abs(prm.value.lz - xz));
        lje = mean(JE(xz-dd:xz+dd, :), 1);
        ljex = mean(JEx(xz-dd:xz+dd, :), 1);
        ljey = mean(JEy(xz-dd:xz+dd, :), 1);
        ljez = mean(JEz(xz-dd:xz+dd, :), 1);
    elseif dir == 1
        sdir = 'z';
        xlab = 'Z [c/\omega_{pi}]';
        ll = prm.value.lz;
        lp = prm.value.lx;
        [~, xz] = min(abs(prm.value.lx - xz));
        lje = mean(JE(:, xz-dd:xz+dd), 2);
        ljex = mean(JEx(:, xz-dd:xz+dd), 2);
        ljey = mean(JEy(:, xz-dd:xz+dd), 2);
        ljez = mean(JEz(:, xz-dd:xz+dd), 2);
    else
        error('Parameters error!');
    end
    % smooth
%     lje = smoothdata(lje, 'movmean', nn);
%     ljex = smoothdata(ljex, 'movmean', nn);
%     ljey = smoothdata(ljey, 'movmean', nn);
%     ljez = smoothdata(ljez, 'movmean', nn);
    
    
    %% plot figure
    figure;
    plot(ll, lje/norm, '-k', 'LineWidth', 2); hold on
    plot(ll, ljex/norm, 'r', 'LineWidth', 2);
    plot(ll, ljey/norm, 'g', 'LineWidth', 2);
    plot(ll, ljez/norm, 'b', 'LineWidth', 2); hold off
    
    %% set figure
    xlim(xrange);
    legend(['J',sfx,' \cdot E'], ['J',sfx,'xEx'], ['J',sfx,'yEy'], ['J',sfx,'zEz'], 'Location', 'Best');
    xlabel('X [c/\omega_{pi}]');
    ylabel(['J',sfx,'\cdot E']);
    title(['\Omega_{ci}t = ',num2str(tt(t)),', profiles  ', pstr,' = ',num2str(round(lp(xz)))]);
    set(gca,'FontSize',14);
    
    %% save figure
    cd(outdir);
    %     print('-dpng','-r300',['J',sfx,'_dot_E_t',num2str(tt(t)),'_', pstr,'=',num2str(round(lp(xz))),'.png']);
    %     close(gcf);
end