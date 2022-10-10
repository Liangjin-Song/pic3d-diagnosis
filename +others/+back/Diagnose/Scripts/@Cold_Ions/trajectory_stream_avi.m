function trajectory_stream_avi(obj, name)
Lx=obj.prm.value.Lx;
Lz=obj.prm.value.Lz;
xrange=[0,Lx];
yrange=[-15,15];
name=char(name);
outdir=obj.prm.value.outdir;
aviname=[outdir,'\',name,'.avi'];
%% read data
prt=obj.prm.read_data(name);
tt=prt.value.time(1:2475);
%% environment
nt=length(tt);
x0=prt.value.rx(1);
z0=prt.value.rz(1);
x01=x0;
z01=z0;
aviobj=VideoWriter(aviname);
aviobj.FrameRate=200;
open(aviobj);
t0=-1;
%% plot
pause('on');
for t=1:nt
    x1=prt.value.rx(t);
    z1=prt.value.rz(t);
    t1=round(tt(t));
    if t0~=t1
        hold off
        ss=obj.prm.read_data('stream',t1);
        ss=ss.value;
        plot_stream(ss,Lx,Lz); hold on
        plot([x0, x1],[z0, z1],'-r','LineWidth',2); hold on
        xlim(xrange);
        ylim(yrange);
        title(['\Omega_{ci}t = ',num2str(t1)]);
        set(gca,'FontSize',14);
        t0=t1;
        pause(3);
    else
        plot([x01, x1],[z01, z1],'-r','LineWidth',2); hold on
    end
    x01=x1;
    z01=z1;
    x0=[x0, x1];
    z0=[z0, z1];
    currFrame = getframe(gcf);
    writeVideo(aviobj,currFrame);
end
close(aviobj);
end