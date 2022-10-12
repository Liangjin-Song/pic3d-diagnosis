%% function plot_electric_field_line
% clear;
%% parameters
indir='E:\Asym\cold2_ds1\data';
outdir='E:\Asym\cold2_ds1\out\Kinetic\Trajectory\X-line';
prm=slj.Parameters(indir,outdir);

tt=55;

xz=25;
dir=1;

nt=length(tt);

extra=[];
extra.xlabel='X [c/\omega_{pi}]';
extra.ylabel='Z [c/\omega_{pi}]';

norm=prm.value.vA;

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

for t=1:nt
    %% read data
    E=prm.read('E',tt(t));

    %% get line
    le=E.get_line2d(xz,dir,prm,norm);

    %% plot figure
    figure;
    plot(ll, le.lx, 'r', 'LineWidth', 2); hold on
    plot(ll, le.ly, 'b', 'LineWidth', 2);
    plot(ll, le.lz, 'm', 'LineWidth', 2); hold off

    %% set figure
    xlim(xrange);
    legend('Ex', 'Ey', 'Ez', 'Location', 'Best');
    xlabel('Z [c/\omega_{pi}]');
    ylabel('E');
    title(['profiles  ', pstr,' = ',num2str(xz)]);
    set(gca,'FontSize',14);

    %% save figure
    cd(outdir);
%     print('-dpng','-r300',['E_t',num2str(tt(t)),'_line.png']);
%     close(gcf);
end

% end