% function plot_temperature_component_profiles(name)
clear;
%% 
indir='E:\Asym\cold2_ds1\data';
outdir='E:\Asym\cold2_ds1\out\Test';
prm=slj.Parameters(indir,outdir);

tt=0;
name='l';

dir=1;
xz=25;

nt=length(tt);

xrange=[-10,10];
extra.Visible=true;

if dir == 1
    ll = prm.value.lz;
    labelx='Z [c/\omega_{pi}]';
    pstr='x';
else
    ll = prm.value.lx;
    labelx='X [c/\omega_{pi}]';
    pstr='z';
end

if name == 'h'
    tm=prm.value.thm;
    sfx='ic';
elseif name == 'l'
    tm=prm.value.tlm;
    sfx='ih';
elseif name == 'e'
    tm=prm.value.tem;
    sfx='e';
end

norm=tm/prm.value.coeff;

for t=1:nt
    %% read data
    P=prm.read(['P',name],tt(t));
    N=prm.read(['N',name],tt(t));
    ss=prm.read('stream',tt(t));
    %% calculation
    Txx=slj.Scalar(P.xx./N.value);
    Tyy=slj.Scalar(P.yy./N.value);
    Tzz=slj.Scalar(P.zz./N.value);

    %% line
    lxx=Txx.get_line2d(xz,dir,prm,norm);
    lyy=Tyy.get_line2d(xz,dir,prm,norm);
    lzz=Tzz.get_line2d(xz,dir,prm,norm);
    ltt=(lxx + lyy + lzz)./3;

    %% figure
    f=figure('Visible', extra.Visible);
    plot(ll, lxx, '-r', 'LineWidth', 2);
    hold on
    plot(ll, lyy, '-g', 'LineWidth', 2);
    plot(ll, lzz, '-b', 'LineWidth', 2);
    plot(ll, ltt, '-k', 'LineWidth', 2);
    legend('T_{xx}', 'T_{yy}', 'T_{zz}', ['T',sfx], 'Location', 'Best');
    title(['profiles ',pstr,'=',num2str(xz),', \Omega_{ci}t=',num2str(tt(t))]);
    ylabel(['T',sfx]);
    xlabel(labelx);
    xlim(xrange);
    set(gca,'FontSize',14);
    cd(outdir);
    print(f, '-dpng','-r300',['T',sfx,'_t',num2str(tt(t), '%06.2f'), '_',pstr,num2str(xz),'.png']);
%     close(gcf);
end


% end
