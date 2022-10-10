%% plot the field and the particle's trajectory
%% writen by Liangjin Song on 20210413
%%
clear;
%% parameters
indir='E:\PIC\Cold-Ions\mie100\data';
outdir='E:\PIC\Cold-Ions\mie100\out\Trajectory\Particle';

% box size
nx=4000;
ny=2000;
nz=1;
di=40;
Lx=nx/di;
Ly=ny/di;
vA=0.0125;

tt=[49];
% particle's id
% id='1246782299';
pid=uint64(importdata('E:\PIC\Cold-Ions\mie100\out\Trajectory\Analysis.txt'));
% pid=pid(12:end);
pid=uint64(871817482);

% normalization
% the energy of cold ions
norme=1*5*0.01/18461.763672;

%% the position vector in x and z direction
lx=linspace(0,Lx,nx);
lz=linspace(-Ly/2,Ly/2,ny);

%% plot the figures
np=length(pid);
nt=length(tt);
for p=1:np
    %% read data
    cd(indir);
    %% particle information
    id=num2str(pid(p));
    name=['trajh_id',id];
    dprt=load([name,'.dat']);
    prt.time=dprt(:,1);
    prt.time(end)=NaN;
    prt.k=dprt(:,14)/norme;
    prt.k(end)=NaN;
    prt.rx=particle_position(lx,dprt(:,2));
    prt.rz=particle_position(lz,dprt(:,3));
    
    %% for the time
    for t=1:nt
        cd(indir);
        ss=pic3d_read_data('stream',tt(t),nx,ny,nz);
        %% magnetic field
        nfd='B';
        cd(indir);
        fd=pic3d_read_data(nfd,tt(t),nx,ny,nz);
        plot_trajectory_fd_map(prt, fd, ss, nfd, tt(t), id, Lx, Ly, 1,outdir);
%         nfd='E';
%         cd(indir);
%         fd=pic3d_read_data(nfd,tt(t),nx,ny,nz);
%         plot_trajectory_fd_map(prt, fd, ss, nfd, tt(t), id, Lx, Ly, vA,outdir);
    end
    copyfile(['E:\PIC\Cold-Ions\mie100\out\Trajectory\Survey\',name,'_survey.png'],'./');
    copyfile(['E:\PIC\Cold-Ions\mie100\out\Trajectory\Survey\',name,'_survey.png'],'E:\PIC\Cold-Ions\mie100\out\Trajectory\Particle\Gather');
end


%% ===================================== plot =================================
function plot_trajectory_fd_map(prt, fd, ss, nfd, tt, id, Lx, Ly, norm, outdir)
%% plot figure
gcf_position=[200,200,800,800];
ax_pos1=[0.15,0.4,0.53,0.6];
ax_pos2=[0.15,0.1,0.53,0.6];

xrange=[0,Lx];
% yrange=[-Ly/2,Ly/2];
yrange=[-15,15];
%%
f=figure('Visible','off');
fs=16;
set(f, 'Position',gcf_position);

%% the time and fd
ax1=axes;
set(ax1,'Position',ax_pos1);
plot_overview(fd.y,ss,norm,Lx,Ly);
colorbar('off');
ax2=axes;
set(ax2,'Visible','off');
set(ax2,'Position',ax_pos1);
pic3d_plot_2D_stream(ss,Lx,Ly,20);
set(gca,'Visible','off');
p=patch(prt.rx,prt.rz,prt.time,'edgecolor','flat','facecolor','none');
set(p,'LineWidth',2);

ax3=axes;
set(ax3,'Position',ax_pos2);
plot_overview(fd.z,ss,norm,Lx,Ly);
colorbar('off');
ax4=axes;
set(ax4,'Visible','off');
set(ax4,'Position',ax_pos2);
pic3d_plot_2D_stream(ss,Lx,Ly,20);
set(gca,'Visible','off');
p=patch(prt.rx,prt.rz,prt.k,'edgecolor','flat','facecolor','none');
set(p,'LineWidth',2);

%% set the range
xlim(ax1,xrange);
ylim(ax1,yrange);
xlim(ax2,xrange);
ylim(ax2,yrange);
xlim(ax3,xrange);
ylim(ax3,yrange);
xlim(ax4,xrange);
ylim(ax4,yrange);

%% set label
xlabel(ax1,'');
xlabel(ax2,'');
ylabel(ax1,'Z [c/\omega_{pi}]');
ylabel(ax2,'Z [c/\omega_{pi}]');
ylabel(ax3,'Z [c/\omega_{pi}]');
ylabel(ax4,'Z [c/\omega_{pi}]');
xlabel(ax3,'X [c/\omega_{pi}]');
xlabel(ax4,'X [c/\omega_{pi}]');

%% set the Xticklabel
set(ax1,'XTicklabel',[]);
set(ax2,'XTicklabel',[]);

%% set colormap
colormap(ax1,mycolormap(0));
colormap(ax2,'hsv');
colormap(ax3,mycolormap(0));
colormap(ax4,'hsv');

%% set title
title(ax1,['ID=',id]);

%% set caxis
caxis(ax2,[0,50]);
caxis(ax4,[0,max(prt.k)]);
% cx=max(abs(fd.y(200:1800,:)),[],'All');
% caxis(ax1,[-cx,cx]);
% cx=max(abs(fd.z(200:1800,:)),[],'All');
% caxis(ax3,[-cx,cx]);

%% colorbar
c1=colorbar(ax1,'Position',[0.8, 0.58, 0.03, 0.25],'AxisLocation','in');
c1.Label.String = [nfd,'y, \Omega_{ci}t=',num2str(tt)];
c2=colorbar(ax2,'Position',[0.86, 0.58, 0.03, 0.25]);
c2.Label.String = '\Omega_{ci}t';

c3=colorbar(ax3,'Position',[0.8, 0.28, 0.03, 0.25],'AxisLocation','in');
c3.Label.String = [nfd,'z, \Omega_{ci}t=',num2str(tt)];
c4=colorbar(ax4,'Position',[0.86, 0.28, 0.03, 0.25]);
c4.Label.String = 'K_{ic}';

%% set font size
set(ax1, 'FontSize', fs);
set(ax2, 'FontSize', fs);
set(ax3, 'FontSize', fs);
set(ax4, 'FontSize', fs);


%% save the figure
cd(outdir);
is_exist_dir(id);
cd(id);
print(f, '-dpng','-r300',['trajectory_tk_map_id',id,'_',nfd,'_t',num2str(tt),'.png']);
close(f);
end