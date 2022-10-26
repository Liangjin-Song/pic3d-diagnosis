% function figure9()
%%
% writen by Liangjin Song on 20210628
% the particle's information which is at the DF
%%
clear;
indir='E:\Asym\cold2_ds1\data';
outdir='E:\Asym\cold2_ds1\out\Kinetic\Trajectory\X-line';
prm=slj.Parameters(indir,outdir);

%% particle
id=uint64(811378968);
spcs='h';

%% time
tt=40;
tt0=4001;
trange=3801:4501;
%% figure
extra.xlabel='X [c/\omega_{pi}]';
extra.ylabel='Z [c/\omega_{pi}]';
extra.ColorbarPosition='north';
extra.FontSize=14;

%% particles
norm=0.5*prm.value.mi*prm.value.vA.^2;
prt=prm.read(['traj',spcs,'_id',num2str(id)]);
den=prt.acceleration_direction(prm);
prt=prt.norm_energy(norm);
prt=prt.norm_electric_field(prm);

%% 
% trange=1:2501;
star=trange(1):100:trange(end);

%% figure
% f=figure('Position',[500,10,800,600]);
% ha=slj.Plot.subplot(2,2,[0.09,0.09],[0.1,0.06],[0.085,0.07]);


%%

if strcmp(spcs,'l')
    spc='ih';
elseif strcmp(spcs,'h')
    spc='ic';
elseif strcmp(spcs,'he')
    spc='e';
else
    spc='e';
end


%% particle's trajectory
f1=figure;
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
cd(outdir);
print(f1,'-dpng','-r300','trajectory_X_Z.png');

%% particle's trajectory in Y-Z plane
vA=prm.value.vA;
vy=prt.value.vy/vA;
vz=prt.value.vz/vA;
vy=(vy(1:end-1)+vy(2:end))/2;
% y position
nvy=length(vy);
ry=zeros(nvy+1,1);
for i=1:nvy
    ry(i+1)=ry(i)+vy(i)*0.02;
end
% y-z trajectory
f2=figure;
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
cd(outdir);
print(f2,'-dpng','-r300','trajectory_Y_Z.png');




%% vy-vz
f3=figure;
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
cd(outdir);
print(f3,'-dpng','-r300','trajectory_Vy_Vz.png');

%% vx-vy
f4=figure;
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
cd(outdir);
print(f4,'-dpng','-r300','trajectory_Vx_Vy.png');

%% x-y trajectory
f2=figure;
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
cd(outdir);
print(f2,'-dpng','-r300','trajectory_X_Y.png');

%% vx-vz
f5=figure;
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
cd(outdir);
print(f5,'-dpng','-r300','trajectory_Vx_Vz.png');

%% y-z trajectory
f6=figure;
rz=prt.value.rz;
p=patch(ry(trange),rz(trange),[prt.value.k(trange(1):trange(end-1)); NaN],'edgecolor','flat','facecolor','none');
colormap('jet');
set(p,'LineWidth',3);
cb=colorbar;
% cb.Label.String='K_{ic}';
cb.Label.FontSize=extra.FontSize;
caxis([0,max(prt.value.k(trange))]);

hold on;
plot(ry(star),rz(star),'*k','LineWidth',8);
plot(ry(tt0),rz(tt0),'*r','LineWidth',8);
plot(ry(star(1)),rz(star(1)),'*g','LineWidth',8); % begin
plot(ry(star(end)),rz(star(end)),'*b','LineWidth',8); % end
hold off
xlabel('Y [c/\omega_{pi}]');
ylabel('Z [c/\omega_{pi}]');
set(gca,'FontSize',extra.FontSize);
cd(outdir);
print(f6,'-dpng','-r300','trajectory_Y_Z.png');