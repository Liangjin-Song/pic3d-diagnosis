%% plot the trajectory of the avi
% writen by Liangjin Song on 20210505
clear;
%% parameters
id={'1466770715'};
indir='E:\PIC\Cold-Ions\mie100\data';
outdir='E:\PIC\Cold-Ions\mie100\out\Distribution_Function\Diagnose\DF\1466770715';
nid=length(id);
for i=1:nid
    write_avi(indir,outdir,char(id(i)));
end


function write_avi(indir, outdir, id)
aviname=[outdir,'\trajh_id',id,'.avi'];
di=40;
nx=4000;
ny=2000;
Lx=nx/di;
Ly=ny/di;
xrange=[0,Lx];
% yrange=[-Ly/2,Ly/2];
yrange=[-15,15];
%% read data
cold=Cold_Ions(indir,outdir);
prt=cold.prm.read_data(['trajh_id',id]);
norm=cold.prm.value.tem*cold.prm.value.tle*cold.prm.value.thl/cold.prm.value.coeff;
prt.value.k=prt.value.k/norm;
cr=[0, max(prt.value.k(1:2501))];
tt=prt.value.time(1:2501);
% cr=[0, max(prt.value.k(1:1001))];
% tt=prt.value.time(1:1001);
%% environment
nt=length(tt);
x0=prt.value.rx(1);
z0=prt.value.rz(1);
k0=prt.value.k(1);
x01=x0;
z01=z0;
k01=k0;
aviobj=VideoWriter(aviname);
aviobj.FrameRate=200;
open(aviobj);
t0=-1;
%% plot
pause('on');
f=figure;
for t=1:nt
    x1=prt.value.rx(t);
    z1=prt.value.rz(t);
    k1=prt.value.k(t);
    t1=round(tt(t));
    if t0~=t1
        hold off
        ss=cold.prm.read_data('stream',t1);
        ss=ss.value;
        plot_stream(ss,Lx,Ly); hold on
        % plot([x0, x1],[z0, z1],'*r','LineWidth',2); hold on
        % p=patch([x0, x1],[z0, z1],[k0, NaN],'edgecolor','flat','facecolor','none'); hold on
        % set(p,'LineWidth',2);
        scatter([x0, x1],[z0,z1],'filled','cdata',[k0, k1]); hold on
        colormap('jet');
        caxis(cr);
        colorbar;
        xlim(xrange);
        ylim(yrange);
        title(['\Omega_{ci}t = ',num2str(t1)]);
        set(gca,'FontSize',14);
        t0=t1;
        % pause(5);
    else
        plot([x01, x1],[z01, z1],'*r','LineWidth',2); hold on
        % p=patch([x01, x1],[z01, z1],[k01, NaN],'edgecolor','flat','facecolor','none'); hold on
        % set(p,'LineWidth',2);
        scatter([x01, x1],[z01,z1],'filled','cdata',[k01, k1]); hold on
        colormap('jet');
        caxis(cr);
        colorbar;
    end
    x01=x1;
    z01=z1;
    k01=k1;
    x0=[x0, x1];
    z0=[z0, z1];
    k0=[k0, k1];
    currFrame = getframe(gcf);
    writeVideo(aviobj,currFrame);
end
close(aviobj);
end