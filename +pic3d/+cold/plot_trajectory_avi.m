%% plot the trajectory of the avi
% writen by Liangjin Song on 20210505
clear;
%% parameters
id={'1479944291'};
indir='E:\PIC\Cold-Ions\mie100\data';
outdir='E:\PIC\Cold-Ions\mie100\out\Oral';
prm=slj.Parameters(indir,outdir);
nid=length(id);
for i=1:nid
    write_avi(prm,char(id(i)));
end


function write_avi(prm, id)
aviname=[prm.outdir,'\trajh_id',id,'.avi'];
% xrange=[prm.value.lx(1),prm.value.lx(end)];
xrange=[0,60];
% yrange=[-Ly/2,Ly/2];
yrange=[-15,15];
%% read data
prt=prm.read(['trajh_id',id]);
norm=prm.value.tem*prm.value.tle*prm.value.thl/prm.value.coeff;
% prt.value.k=prt.value.k/norm;
prt=prt.norm_energy(norm);
% trange=1:2501;
trange=1:2351;
cr=[0, max(prt.value.k(trange))];
tt=prt.value.time(trange);
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
        ss=prm.read('stream',t1);
        ss=ss.value;
        slj.Plot.stream(ss,prm.value.lx,prm.value.lz); hold on
        % plot([x0, x1],[z0, z1],'*r','LineWidth',2); hold on
        p=patch([x0, x1],[z0, z1],[k0, NaN],'edgecolor','flat','facecolor','none'); hold on
        set(p,'LineWidth',4);
        % scatter([x0, x1],[z0,z1],'filled','cdata',[k0, k1]); hold on
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
        p=patch([x01, x1],[z01, z1],[k01, NaN],'edgecolor','flat','facecolor','none'); hold on
        set(p,'LineWidth',4);
        % scatter([x01, x1],[z01,z1],'filled','cdata',[k01, k1]); hold on
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