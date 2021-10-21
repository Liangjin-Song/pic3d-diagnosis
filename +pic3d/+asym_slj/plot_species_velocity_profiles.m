%% function plot_J_E_B_line
clear;
%% parameters
indir='E:\Asym\Cold\data';
outdir='E:\Asym\Cold\out\Analysis';
prm=slj.Parameters(indir,outdir);

tt=100;

xz=50;
dir=1;

nt=length(tt);

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
    Vl=prm.read('Vl',tt(t));
    Vh=prm.read('Vh',tt(t));
    Ve=prm.read('Ve',tt(t));

    %% get line
    lvl=Vl.get_line2d(xz,dir,prm,norm);
    lvh=Vh.get_line2d(xz,dir,prm,norm);
    lve=Ve.get_line2d(xz,dir,prm,norm);


    %% plot figure
    plot(ll, lvl.lz, '-r', 'LineWidth', 2); hold on
    plot(ll, lvh.lz, '-b', 'LineWidth', 2);
    plot(ll, lve.lz, '-g', 'LineWidth', 2);


    %% set figure
    xlim(xrange);
    legend('Vih', 'Vic', 'Ve', 'Location', 'Best');
    xlabel('Vz');
    title(['\Omega_{ci}t = ',num2str(tt(t)),', profiles  ', pstr,' = ',num2str(xz)]);
    set(gca,'FontSize',14);

    %% save figure
    cd(outdir);
    print('-dpng','-r300',['Velocity_t',num2str(tt(t)),'_line_', pstr,' = ',num2str(xz),'.png']);
    % close(gcf);
end



% end