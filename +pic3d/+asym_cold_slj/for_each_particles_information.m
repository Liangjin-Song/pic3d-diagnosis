%% the loop for particles id, and plot the particles' information along the particles' trajectory
clear;
%% parameters
indir = 'E:\Asym\cold2_ds1\data';
outdir = 'E:\Asym\cold2_ds1\out\Kinetic\Trajectory\Survey';
prm=slj.Parameters(indir,outdir);
disp(outdir);

%% particles' id
file = 'id.txt';

%% the time interval
trange=[0, 70];

time.tt=20;
t1=30;
t2=60;
time.range=(t1/prm.value.wci+1):(t2/prm.value.wci+1);

t0=20;
time.t0=t0/prm.value.wci+1;

avit1=0;
avit2=50;
avirange=(avit1*100+1):10:(avit2*100+1);
avixrange=[0,50];
aviyrange=[-10,10];

%% read the particles' id
cd(outdir);
ids = uint64(load(file));
% ids = uint64(213477796);

%% energy normalization
norm=prm.value.mi*prm.value.vA*prm.value.vA;

%% show figure or not
show = false;
save = true;

%% loop
nid = length(ids);
for i=1:nid
    %% read data
    id = ids(i);
    cd(indir);
    [name, spc] = get_particle_name(id);
    spc = get_species(spc);
    prt = prm.read(name);

    %% set the directory
    cd(outdir);
    % slj.Utility.exist_directory(num2str(id));
    % iddir=[outdir,'\', num2str(id)];
    iddir = outdir;

    %% plot figure
    cd(outdir);
    plot_trajectory_information(prm, name, prt, norm, spc, trange, show, iddir, save);
    % plot_particle_information(prm, prt, spc, norm, time, show, iddir, save);
    % plot_trajectory_avi(prm, prt, name, norm, avirange, avixrange, aviyrange, show, iddir);
end


%%  ================================================================================  %%
%% get the file name according to the particle's id
function [name, spc] = get_particle_name(id)
spcs={'e','l','h'};
ns=length(spcs);
for s=1:ns
    spc=char(spcs(s));
    name=['traj',spc,'_id',num2str(id)];
    if exist([name,'.dat'],'file')~=0
        break;
    end
end
end

%%  ================================================================================  %%
%% get the species
function spc = get_species(spc)
if strcmp(spc,'e')
    spc='e';
elseif strcmp(spc,'h')
    spc='ic';
elseif strcmp(spc,'l')
    spc='ih';
else
    error('Parameters error!');
end
end

%%  ================================================================================  %%
function plot_trajectory_information(prm, name, prt, norm, spc, range, show, outdir, save)
en=prt.acceleration_rate(prm);
en.fermi=en.fermi/norm;
en.beta=en.beta/norm;
en.epara=en.epara/norm;
en.eperp=en.eperp/norm;
den=prt.acceleration_direction(prm);
den.x=den.x/norm;
den.y=den.y/norm;
den.z=den.z/norm;
prt=prt.norm_energy(norm);
prt=prt.norm_electric_field(prm);
prt=prt.norm_velocity(prm);
lx=prt.value.time;
extra.xrange=range;
dk=prt.value.k-prt.value.k(1);

%% plot figure
f1=figure('Visible', show);
set(f1, 'Position', [100,0,1500,5000])

%% energy in rest frame
subplot(6, 2, 1);
ly.l1=prt.value.k;
ly.l2=prt.value.kx;
ly.l3=prt.value.ky;
ly.l4=prt.value.kz;
extra.LineStyle={'-', '-', '-', '-'};
extra.LineColor={'k', 'r', 'b', 'm'};
extra.legend={['K',spc], 'Kx', 'Ky', 'Kz'};
extra.ylabel=['K',spc];
extra.Location='west';
slj.Plot.linen(lx, ly, extra);
set(gca,'XTicklabel',[]);


%% energy in fac frame
subplot(6, 2, 2);
ly=[];
ly.l1=prt.value.k_para;
ly.l2=prt.value.k_perp;
ly.l3=prt.value.k;
extra.LineStyle={'-', '-', '--'};
extra.LineColor={'r', 'b', 'k'};
extra.legend={'K_{||}', 'K_{\perp}', 'Kic'};
extra.ylabel=['K',spc];
slj.Plot.linen(lx, ly, extra);
set(gca,'XTicklabel',[]);


%% magnetic field
subplot(6,2,3)
ly=[];
ly.l1=prt.value.bx;
ly.l2=prt.value.by;
ly.l3=prt.value.bz;
ly.l4=sqrt(ly.l1.^2+ly.l2.^2+ly.l3.^2);
extra.LineStyle={'-', '-', '-', '--'};
extra.LineColor={'r', 'b', 'g', 'k'};
extra.legend={'Bx', 'By', 'Bz', '|B|'};
extra.ylabel='B';
extra.Location='west';
slj.Plot.linen(lx, ly, extra);
extra=rmfield(extra,'Location');
set(gca,'XTicklabel',[]);


%% magnetic moment and kappa
subplot(6,2,4);
extra.ylabell='\mu';
extra.ylabelr='\kappa';
extra.yranger=[0,10];
slj.Plot.plotyy1(lx, prt.value.mu, prt.value.kappa, extra);
set(gca,'XTicklabel',[]);
extra=rmfield(extra,'yranger');


%% electric field in the rest frame
subplot(6,2,5)
ly=[];
ly.l1=prt.value.ex;
ly.l2=prt.value.ey;
ly.l3=prt.value.ez;
extra.LineStyle={'-', '-', '-'};
extra.LineColor={'r', 'b', 'k'};
extra.legend={'Ex', 'Ey', 'Ez'};
extra.ylabel='E';
extra.Location='west';
slj.Plot.linen(lx, ly, extra);
extra=rmfield(extra,'Location');
set(gca,'XTicklabel',[]);


%% electric field in the fac frame
subplot(6,2,6)
ly=[];
ly.l1=prt.value.e_para;
ly.l2=prt.value.e_perp;
extra.LineStyle={'-', '--'};
extra.LineColor={'r', 'k'};
extra.legend={'E_{||}', 'E_{\perp}'};
extra.ylabel='E';
extra.Location='west';
slj.Plot.linen(lx, ly, extra);
extra=rmfield(extra,'Location');
set(gca,'XTicklabel',[]);

%% velocity in the rest frame
subplot(6,2,7)
ly=[];
ly.l1=prt.value.vx;
ly.l2=prt.value.vy;
ly.l3=prt.value.vz;
extra.LineStyle={'-', '-', '-'};
extra.LineColor={'r', 'b', 'k'};
extra.legend={'vx', 'vy', 'vz'};
extra.ylabel=['V_{',spc,'}'];
extra.Location='west';
slj.Plot.linen(lx, ly, extra);
extra=rmfield(extra,'Location');
set(gca,'XTicklabel',[]);

%% velocity in the rest frame
subplot(6,2,8)
ly=[];
ly.l1=prt.value.v_para;
ly.l2=prt.value.v_perp;
extra.LineStyle={'-', '-'};
extra.LineColor={'r', 'k'};
extra.legend={'v_{||}', 'v_{\perp}'};
extra.ylabel=['V_{',spc,'}'];
extra.Location='west';
slj.Plot.linen(lx, ly, extra);
set(gca,'XTicklabel',[]);


extra.FontSize=14;
%% acceleration in the rest direction
subplot(6,2,9)
ly=[];
ly.l1=dk;
ly.l2=den.x;
ly.l3=den.y;
ly.l4=den.z;
ly.l5=ly.l2+ly.l3+ly.l4;
extra.LineStyle={'-', '-', '-', '-', '--'};
extra.LineColor={'k', 'r', 'b', 'g', 'k'};
extra.legend={'\Delta K', 'qVxEx', 'qVyEy', 'qVzEz', 'Sum'};
extra.ylabel=['\Delta K',spc];
extra.Location='northwest';
slj.Plot.linen(lx, ly, extra);
set(gca,'XTicklabel',[]);


%% acceleration in the fac direction
subplot(6,2,10)
ly=[];
ly.l1=dk;
ly.l2=en.epara;
ly.l3=en.eperp;
ly.l4=ly.l2+ly.l3;
extra.LineStyle={'-', '-', '-', '--'};
extra.LineColor={'k', 'r', 'b', 'k'};
extra.legend={'\Delta K', 'qV_{||}E_{||}', 'qV_{\perp}E_{\perp}', 'Sum'};
extra.ylabel=['\Delta K',spc];
slj.Plot.linen(lx, ly, extra);
set(gca,'XTicklabel',[]);


%% the particle position
subplot(6,2,11);
extra.ylabell='X [c/\omega_{pi}]';
extra.ylabelr='Z [c/\omega_{pi}]';
extra.xlabel='\Omega_{ci}t';
slj.Plot.plotyy1(lx, prt.value.rx, prt.value.rz, extra);
% set(gca,'XTicklabel',[]);


%% the acceleration
subplot(6, 2, 12);
ly=[];
ly.l1=dk;
ly.l2=en.fermi;
ly.l3=en.beta;
ly.l4=en.epara;
ly.l5=ly.l2+ly.l3+ly.l4;
extra.LineStyle={'-', '-', '-', '-', '--'};
extra.LineColor={'k', 'r', 'b', 'g', 'k'};
extra.legend={'\Delta K', 'Fermi', '\mu dB/dt', 'qV_{||}E_{||}', 'Sum'};
extra.ylabel=['\Delta K',spc];
slj.Plot.linen(lx, ly, extra);
% set(gca,'XTicklabel',[]);


%% add particle's ID as the title
h1 = get(gcf,'children');
axis1 = get(h1(end),'Position');
axis2 = get(h1(end),'Position');
axest = [axis1(1)+axis1(1)*1.7,axis1(2)+axis1(4),axis2(1)+axis1(3)-axis1(1),0.03];
ht = axes('Position',axest);
axis(ht,'off')
title(ht,['ID=', num2str(prt.id)],'FontSize', 16);


%% save the figure
if save
    cd(outdir);
    print(f1, '-dpng', '-r350', [name,'_survey.png']);
    close(f1);
end
end


%%  ================================================================================  %%
function plot_particle_information(prm, prt, spc, norm, time, show, outdir, save)
%% time
tt=time.tt;
tt0=time.t0;
trange=time.range;
%% figure
extra.xlabel='X [c/\omega_{pi}]';
extra.ylabel='Z [c/\omega_{pi}]';
extra.ColorbarPosition='north';
extra.FontSize=14;

%% particles
den=prt.acceleration_direction(prm);
prt=prt.norm_energy(norm);
prt=prt.norm_electric_field(prm);

%% 
star=trange(1):1600:trange(end);


%% particle's trajectory
f1=figure('Visible', show);
dh=0.05;
trange0=1:trange(end);
trange0=trange;
ss=prm.read('stream',tt);
cr=[0, max(prt.value.k(trange0))];
slj.Plot.stream(ss,prm.value.lx,prm.value.lz,20);
hold on
p=patch(prt.value.rx(trange0),prt.value.rz(trange0),[prt.value.k(trange0(1:end-1));NaN],'edgecolor','flat','facecolor','none');
caxis(cr);
colormap('jet');
cb=colorbar;
cb.Label.FontSize=extra.FontSize;
xlim([0,50]);
ylim([-10,10]);
set(p,'LineWidth',3);
xlabel(extra.xlabel);
ylabel(extra.ylabel);
set(gca,'FontSize',extra.FontSize);

%% particle's trajectory in Y-Z plane
vA=prm.value.vA;
vy=prt.value.vy/vA;
vz=prt.value.vz/vA;
vy=(vy(1:end-1)+vy(2:end))/2;
% y position
nvy=length(vy);
ry=zeros(nvy+1,1);
dt=prt.value.time(10)-prt.value.time(9);
for i=1:nvy
    ry(i+1)=ry(i)+vy(i)*dt;
end
% y-z trajectory
f2=figure('Visible', show);
p=patch(ry(trange),prt.value.rz(trange),[prt.value.k(trange(1):trange(end-1)); NaN],'edgecolor','flat','facecolor','none');
colormap('jet');
set(p,'LineWidth',3);
cb=colorbar;
cb.Label.FontSize=extra.FontSize;
caxis([0,max(prt.value.k(trange))]);

hold on;
plot(ry(star),prt.value.rz(star),'*k','LineWidth',8);
plot(ry(tt0),prt.value.rz(tt0),'*r','LineWidth',8);
plot(ry(star(1)),prt.value.rz(star(1)),'*g','LineWidth',8); % begin
plot(ry(star(end)),prt.value.rz(star(end)),'*b','LineWidth',8); % end
hold off
xlabel('Y [c/\omega_{pi}]');
ylabel('Z [c/\omega_{pi}]');
set(gca,'FontSize',extra.FontSize);




%% vy-vz
f3=figure('Visible', show);
p=patch(vy(trange),vz(trange),[prt.value.k(trange(1):trange(end-1)); NaN],'edgecolor','flat','facecolor','none');
colormap('jet');
set(p,'LineWidth',3);
cb=colorbar;
% cb.Label.String='K_{ic}';
cb.Label.FontSize=extra.FontSize;
caxis([0,max(prt.value.k(trange))]);
hold on
plot(vy(star),vz(star),'*k','LineWidth',8);
plot(vy(tt0),vz(tt0),'*r','LineWidth',8); % distribution position
plot(vy(star(1)),vz(star(1)),'*g','LineWidth',8); % begin
plot(vy(star(end)),vz(star(end)),'*b','LineWidth',8); % end
hold off
xlabel(['V',spc,'_y']);
ylabel(['V',spc,'_z']);
set(gca,'FontSize',extra.FontSize);

%% vx-vy
f4=figure('Visible', show);
vx=prt.value.vx/vA;
p=patch(vx(trange),vy(trange),[prt.value.k(trange(1):trange(end-1)); NaN],'edgecolor','flat','facecolor','none');
colormap('jet');
set(p,'LineWidth',3);
cb=colorbar;
% cb.Label.String='K_{ic}';
cb.Label.FontSize=extra.FontSize;
caxis([0,max(prt.value.k(trange))]);
hold on
plot(vx(star),vy(star),'*k','LineWidth',8);
plot(vx(tt0),vy(tt0),'*r','LineWidth',8); % distribution position
plot(vx(star(1)),vy(star(1)),'*g','LineWidth',8); % begin
plot(vx(star(end)),vy(star(end)),'*b','LineWidth',8); % end
hold off
xlabel(['V',spc,'_x']);
ylabel(['V',spc,'_y']);
set(gca,'FontSize',extra.FontSize);

%% x-y trajectory
f5=figure('Visible', show);
p=patch(prt.value.rx(trange),ry(trange),[prt.value.k(trange(1):trange(end-1)); NaN],'edgecolor','flat','facecolor','none');
colormap('jet');
set(p,'LineWidth',3);
cb=colorbar;
% cb.Label.String='K_{ic}';
cb.Label.FontSize=extra.FontSize;
caxis([0,max(prt.value.k(trange))]);

hold on;
plot(prt.value.rx(star),ry(star),'*k','LineWidth',8);
plot(prt.value.rx(tt0),ry(tt0),'*r','LineWidth',8);
plot(prt.value.rx(star(1)),ry(star(1)),'*g','LineWidth',8); % begin
plot(prt.value.rx(star(end)),ry(star(end)),'*b','LineWidth',8); % end
hold off
xlabel('X [c/\omega_{pi}]');
ylabel('Y [c/\omega_{pi}]');
set(gca,'FontSize',extra.FontSize);

%% vx-vz
f6=figure('Visible', show);
p=patch(vx(trange),vz(trange),[prt.value.k(trange(1):trange(end-1)); NaN],'edgecolor','flat','facecolor','none');
colormap('jet');
set(p,'LineWidth',3);
cb=colorbar;
% cb.Label.String='K_{ic}';
cb.Label.FontSize=extra.FontSize;
caxis([0,max(prt.value.k(trange))]);
hold on
plot(vx(star),vz(star),'*k','LineWidth',8);
plot(vx(tt0),vz(tt0),'*r','LineWidth',8); % distribution position
plot(vx(star(1)),vz(star(1)),'*g','LineWidth',8); % begin
plot(vx(star(end)),vz(star(end)),'*b','LineWidth',8); % end
hold off
xlabel(['V',spc,'_x']);
ylabel(['V',spc,'_z']);
set(gca,'FontSize',extra.FontSize);

%% v_para-v_perp1 (E cross B)
f7=figure('Visible', show);
v_para = prt.value.v_para/vA;
v_perp1 = prt.value.v_perp1/vA;
p=patch(v_para(trange),v_perp1(trange),[prt.value.k(trange(1):trange(end-1)); NaN],'edgecolor','flat','facecolor','none');
colormap('jet');
set(p,'LineWidth',3);
cb=colorbar;
% cb.Label.String='K_{ic}';
cb.Label.FontSize=extra.FontSize;
caxis([0,max(prt.value.k(trange))]);
hold on
plot(v_para(star),v_perp1(star),'*k','LineWidth',8);
plot(v_para(tt0),v_perp1(tt0),'*r','LineWidth',8); % distribution position
plot(v_para(star(1)),v_perp1(star(1)),'*g','LineWidth',8); % begin
plot(v_para(star(end)),v_perp1(star(end)),'*b','LineWidth',8); % end
hold off
xlabel(['V',spc,'_{||}']);
ylabel(['V',spc,'_{\perp1}']);
set(gca,'FontSize',extra.FontSize);


%% v_para-v_perp2 (B cross E cross B)
f8=figure('Visible', show);
v_perp2 = prt.value.v_perp2/vA;
p=patch(v_para(trange),v_perp2(trange),[prt.value.k(trange(1):trange(end-1)); NaN],'edgecolor','flat','facecolor','none');
colormap('jet');
set(p,'LineWidth',3);
cb=colorbar;
% cb.Label.String='K_{ic}';
cb.Label.FontSize=extra.FontSize;
caxis([0,max(prt.value.k(trange))]);
hold on
plot(v_para(star),v_perp2(star),'*k','LineWidth',8);
plot(v_para(tt0),v_perp2(tt0),'*r','LineWidth',8); % distribution position
plot(v_para(star(1)),v_perp2(star(1)),'*g','LineWidth',8); % begin
plot(v_para(star(end)),v_perp2(star(end)),'*b','LineWidth',8); % end
hold off
xlabel(['V',spc,'_{||}']);
ylabel(['V',spc,'_{\perp2}']);
set(gca,'FontSize',extra.FontSize);


%% v_perp1-v_perp2
f9=figure('Visible', show);
p=patch(v_perp1(trange),v_perp2(trange),[prt.value.k(trange(1):trange(end-1)); NaN],'edgecolor','flat','facecolor','none');
colormap('jet');
set(p,'LineWidth',3);
cb=colorbar;
% cb.Label.String='K_{ic}';
cb.Label.FontSize=extra.FontSize;
caxis([0,max(prt.value.k(trange))]);
hold on
plot(v_perp1(star),v_perp2(star),'*k','LineWidth',8);
plot(v_perp1(tt0),v_perp2(tt0),'*r','LineWidth',8); % distribution position
plot(v_perp1(star(1)),v_perp2(star(1)),'*g','LineWidth',8); % begin
plot(v_perp1(star(end)),v_perp2(star(end)),'*b','LineWidth',8); % end
hold off
xlabel(['V',spc,'_{\perp1}']);
ylabel(['V',spc,'_{\perp2}']);
set(gca,'FontSize',extra.FontSize);


%% save figure
if save
    cd(outdir);
    print(f1,'-dpng','-r300','trajectory_X_Z.png');
    print(f2,'-dpng','-r300','trajectory_Y_Z.png');
    print(f3,'-dpng','-r300','trajectory_Vy_Vz.png');
    print(f4,'-dpng','-r300','trajectory_Vx_Vy.png');
    print(f5,'-dpng','-r300','trajectory_X_Y.png');
    print(f6,'-dpng','-r300','trajectory_Vx_Vz.png');
    print(f7,'-dpng','-r300','trajectory_Y_Z.png');
    close(f1);
    close(f2);
    close(f3);
    close(f4);
    close(f5);
    close(f6);
    close(f7);
end
end


%%  ================================================================================  %%
function plot_trajectory_avi(prm, prt, name, norm, avirange, avixrange, aviyrange, show, outdir)
aviname=[outdir,'\',name,'.avi'];
% xrange=[prm.value.lx(1),prm.value.lx(end)];
hlx=prm.value.Lx/2;
xrange=avixrange;
% yrange=[-Ly/2,Ly/2];
yrange=aviyrange;
% prt.value.k=prt.value.k/norm;
prt=prt.norm_energy(norm);
% trange=1:2501;
trange=avirange;
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
aviobj.FrameRate=15;
open(aviobj);
t0=-1;
%% the periodic boundary
pb=1;
%% plot
pause('on');
f=figure('Visible', show);
for t=1:nt
    x1=prt.value.rx(trange(t));
    z1=prt.value.rz(trange(t));
    k1=prt.value.k(trange(t));
    
    %% periodic boundary position
    if abs(x0(end)-x1)>hlx
        pb=[pb, t];
    end
    
    t1=round(tt(t));
    if t0~=t1
        hold off
        ss=prm.read('stream',t1);
        ss=ss.value;
        slj.Plot.stream(ss,prm.value.lx,prm.value.lz,40); hold on
        
        npb = length(pb);
        for b = 2:npb
            p=patch(x0(pb(b-1):(pb(b)-1)),z0(pb(b-1):(pb(b)-1)),[k0(pb(b-1):(pb(b)-2)), NaN],'edgecolor','flat','facecolor','none'); hold on
            set(p,'LineWidth',2);
        end
        
        p=patch([x0(pb(end)+1:end), x1],[z0(pb(end)+1:end), z1],[k0(pb(end)+1:end), NaN],'edgecolor','flat','facecolor','none'); hold on
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
        
        if abs(x01-x1)<hlx
            p=patch([x01, x1],[z01, z1],[k01, NaN],'edgecolor','flat','facecolor','none'); hold on
            set(p,'LineWidth',2);
        end
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
close(f);
end