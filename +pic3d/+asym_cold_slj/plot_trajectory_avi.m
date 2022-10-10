%% plot the trajectory of the avi
% writen by Liangjin Song on 20210505
clear;
%% parameters
id={'570987588'};
indir='E:\Asym\dst1\data';
outdir='E:\Asym\dst1\out\Kinetic\Trajectory\Cold_Ions\type2\1';
prm=slj.Parameters(indir,outdir);
show=true;
nid=length(id);
for i=1:nid
    write_avi(prm,char(id(i)), show);
end


function write_avi(prm, id, show)
aviname=[prm.outdir,'\traje_id',id,'.avi'];
% xrange=[prm.value.lx(1),prm.value.lx(end)];
xrange=[20,30];
% yrange=[-Ly/2,Ly/2];
yrange=[-5,5];
%% read data
prt=prm.read(['trajh_id',id]);
% norm=prm.value.tem*prm.value.tle*prm.value.thl/prm.value.coeff;
norm=prm.value.mi*prm.value.vA*prm.value.vA;
% prt.value.k=prt.value.k/norm;
prt=prt.norm_energy(norm);
% trange=1:2501;
trange=1:400:40001;
cr=[0, max(prt.value.k(trange))];
tt=prt.value.time(trange);
% cr=[0, max(prt.value.k(1:1001))];
% tt=prt.value.time(1:1001);
%% environment
nt=length(tt);
x0=prt.value.rx(trange(1));
z0=prt.value.rz(trange(1));
k0=prt.value.k(trange(1));
x01=x0;
z01=z0;
k01=k0;
aviobj=VideoWriter(aviname);
aviobj.FrameRate=5;
open(aviobj);
t0=-1;
%% plot
pause('on');
f=figure('Visible', show);
for t=1:nt
    x1=prt.value.rx(trange(t));
    z1=prt.value.rz(trange(t));
    k1=prt.value.k(trange(t));
    t1=round(tt(t));
    if t0~=t1
        hold off
        ss=prm.read('stream',t1);
        ss=ss.value;
        slj.Plot.stream(ss,prm.value.lx,prm.value.lz,40); hold on
        % plot([x0, x1],[z0, z1],'*r','LineWidth',2); hold on
        p=patch([x0, x1],[z0, z1],[k0, NaN],'edgecolor','flat','facecolor','none'); hold on
        set(p,'LineWidth',2);
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
        set(p,'LineWidth',2);
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
    xlabel('X [c/\omega_{pi}]');
    ylabel('Z [c/\omega_{pi}]');
    currFrame = getframe(gcf);
    writeVideo(aviobj,currFrame);
end
close(aviobj);
end