% function plot_species_energy_conversion_line
clear;
%% parameters
indir='E:\Asym\Cold\data';
outdir='E:\Asym\Cold\out\Global';
prm=slj.Parameters(indir,outdir);

xz=49.7;
dir=1;
ll=prm.value.lz;

fontsize=14;
linewidth=1.5;
xrange=[-8,5];

norm=prm.value.qi*prm.value.n0*prm.value.vA*prm.value.vA;

tt=100;
nt=length(tt);
for t=1:nt
    %% magnetic field
    B=prm.read('B',tt(t));
    %% J dot E
    J=prm.read('J',tt(t));
    E=prm.read('E',tt(t));
    JE=J.dot(E);
    %% Ji dot E
    Ni=prm.read('Nl',tt(t));
    Vi=prm.read('Vl',tt(t));
    JiE=Vi.dot(E);
    JiE=slj.Scalar(prm.value.qi*JiE.value.*Ni.value);
    %% Jh dot E
    Nh=prm.read('Nh',tt(t));
    Vh=prm.read('Vh',tt(t));
    JhE=Vh.dot(E);
    JhE=slj.Scalar(prm.value.qi*JhE.value.*Nh.value);
    %% Je dot E
    Ne=prm.read('Ne',tt(t));
    Ve=prm.read('Ve',tt(t));
    JeE=Ve.dot(E);
    JeE=slj.Scalar(prm.value.qe*JeE.value.*Ne.value);
    %% filter
    n=5;
    JE=JE.filter2d(n);
    JiE=JiE.filter2d(n);
    JeE=JeE.filter2d(n);
    JhE=JhE.filter2d(n);
    %% get line
    lJE=JE.get_line2d(xz, dir, prm, norm);
    lJiE=JiE.get_line2d(xz,dir,prm,norm);
    lJhE=JhE.get_line2d(xz,dir,prm,norm);
    lJeE=JeE.get_line2d(xz,dir,prm,norm);
    lB=B.get_line2d(xz,dir,prm,1);
    %% figure
    figure;
    [ax,h1,h2]=plotyy(ll,[lJE';lJiE';lJeE';lJhE'],ll,lB.lx);
    set(ax(1),'XColor','k','YColor','b','FontSize',fontsize);
    set(ax(2),'XColor','k','YColor','r','FontSize',fontsize);
    set(ax,'XLim',xrange);
    % set label
    set(get(ax(1),'Ylabel'),'String','J \cdot E','FontSize',fontsize);
    set(get(ax(2),'Ylabel'),'String','Bx','FontSize',fontsize);
    xlabel('Z [c/\omega_{pi}]','FontSize',fontsize);
    
    % set line
    set(h1(1),'Color','k','LineWidth',linewidth);
    set(h1(2),'Color','g','LineWidth',linewidth);
    set(h1(3),'Color','b','LineWidth',linewidth);
    set(h1(4),'Color','m','LineWidth',linewidth);
    set(h2,'Color','r','LineWidth',linewidth);
    legend([h1(:);h2],'J \cdot E','Ji \cdot E','Je \cdot E', 'Jic \cdot E','Bx');
    pos=get(gca,'Position');
    pos(2)=pos(2)+0.04;
    set(gca,'Position',pos);
end