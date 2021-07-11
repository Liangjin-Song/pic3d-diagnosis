%% plot ions all velocity to check the force 
% writen by Liangjin Song on 20190522
clear
indir='/data/simulation/rec2d_M25SBg00Sx/data/';
outdir='/data/simulation/rec2d_M25SBg00Sx/out/line/ion_velocity/';
di=20;
Lx=4000/di;
Ly=2000/di;
z0=25;
c=0.6;
tt=50:0.5:97;
nt=length(tt);
for t=1:nt
    cd(indir);
    vx=read_data('vxi',tt(t));
    vy=read_data('vyi',tt(t));
    vz=read_data('vzi',tt(t));
    bz=read_data('Bz',tt(t));
    v=sqrt(vx.^2+vy.^2+vz.^2);

    [lvx,lx]=get_line_data(vx,Lx,Ly,z0,1,0);
    [lvy,~]=get_line_data(vy,Lx,Ly,z0,1,0);
    [lvz,~]=get_line_data(vz,Lx,Ly,z0,1,0);
    [lv,~]=get_line_data(v,Lx,Ly,z0,1,0);
    [lbz,~]=get_line_data(bz,Lx,Ly,z0,c,0);

    h=figure;
    fontsize=12;
    linewidth=2;
    set(h,'Visible','off');
    [ax,h1,h2]=plotyy(lx,[lv;lvx;lvy;lvz],lx,lbz);

    set(ax(1),'XColor','k','YColor','k','FontSize',fontsize);
    set(ax(2),'XColor','k','YColor','r','FontSize',fontsize);
    [~,in]=max(lbz);
    x0=lx(in);
    xrange=[x0-3,x0+3];
    set(ax(1),'XLim',xrange);
    set(ax(2),'XLim',xrange);

    set(get(ax(1),'Ylabel'),'String','ion velocity','FontSize',fontsize);
    set(get(ax(2),'Ylabel'),'String','Bz','FontSize',fontsize);
    xlabel('X[c/\omega_{pi}]','FontSize',fontsize);

    set(h1(1),'Color','k','LineWidth',linewidth);
    set(h1(2),'Color','g','LineWidth',linewidth);
    set(h1(3),'Color','b','LineWidth',linewidth);
    set(h1(4),'Color','c','LineWidth',linewidth);
    set(h2,'Color','r','LineWidth',linewidth);

    hl=legend([h1(:);h2],'v_{tot}','v_x','v_y','v_z','Bz','Location','Best');
    set(gca,'FontSize',fontsize);

    %% save figures
    cd(outdir);
    print('-r200','-dpng',['ion_velocity_t',num2str(tt(t),'%06.2f'),'.png']);
    close(gcf);
end
