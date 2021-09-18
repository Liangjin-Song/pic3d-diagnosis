% function figure9()
%%
% figure 9
% writen by Liangjin Song on 20210628
% the particle's information which is at the DF
%%
clear;
run('articles.article4.parameters.m');

%% time
tt=32;
tt0=1451;

%% figure
extra.xlabel='X [c/\omega_{pi}]';
extra.ylabel='Z [c/\omega_{pi}]';
extra.ColorbarPosition='north';
extra.FontSize=16;

%% particles
id=uint64(1466770715);
% id=uint64(1266864751);
% id=uint64(1267265581);
% id=uint64(1359645935);
% id=uint64(1371805878);
norm=prm.value.mi*prm.value.vA*prm.value.vA;
prt=prm.read(['trajh_id',num2str(id)]);
den=prt.acceleration_direction(prm);
prt=prt.norm_energy(norm);
prt=prt.norm_electric_field(prm);

%% 
% trange=1451:2101;
trange=1:1451;
star=trange(1):50:trange(end);

%% figure
% f=figure('Position',[500,10,800,600]);
% ha=slj.Plot.subplot(2,2,[0.09,0.09],[0.1,0.06],[0.085,0.07]);

%% particle's trajectory
f1=figure;
dh=0.05;
trange0=1:trange(end);
ss=prm.read('stream',tt);
cr=[0, max(prt.value.k(trange0))];
slj.Plot.stream(ss,prm.value.lx,prm.value.lz,20);
hold on
p=patch(prt.value.rx(trange0),prt.value.rz(trange0),[prt.value.k(trange0(1:end-1));NaN],'edgecolor','flat','facecolor','none');
caxis(cr);
colormap('jet');
cb=colorbar;
% cb.Label.String='K_{ic}';
cb.Label.FontSize=extra.FontSize;
xlim([30,50]);
ylim([-5,5]);
set(p,'LineWidth',3);
xlabel(extra.xlabel);
ylabel(extra.ylabel);
set(gca,'FontSize',extra.FontSize);
cd(outdir);
% print(f1,'-dpng','-r300','figure9-1.png');

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
% cb.Label.String='K_{ic}';
cb.Label.FontSize=extra.FontSize;
caxis([0,max(prt.value.k(trange))]);
xtick=6:10;
xtkble={'6','7','8','9','10'};
ytick=-2.5:0.5:0;
ytkble={'-2.5','-2','-1.5','-1','-0.5','0'};
set(gca,'XTick',xtick,'Xticklabel',xtkble);
set(gca,'YTick',ytick,'Yticklabel',ytkble);
hold on;
plot(ry(star),prt.value.rz(star),'*k','LineWidth',8);
plot(ry(tt0),prt.value.rz(tt0),'*r','LineWidth',8);
plot(ry(star(1)),prt.value.rz(star(1)),'*g','LineWidth',8); % begin
plot(ry(star(end)),prt.value.rz(star(end)),'*b','LineWidth',8); % end
hold off
xlim([6,10]);
ylim([-2.5,0]);
xlabel('Y [c/\omega_{pi}]');
ylabel('Z [c/\omega_{pi}]');
set(gca,'FontSize',extra.FontSize);
cd(outdir);
% print(f2,'-dpng','-r300','figure9-2.png');

%% vy-vz
f3=figure;
p=patch(vy(trange),vz(trange),[prt.value.k(trange(1):trange(end-1)); NaN],'edgecolor','flat','facecolor','none');
xtick=-1:0.5:1;
xtkble={'-1','-0.5','0','0.5','1'};
ytick=-0.8:0.2:0.8;
ytkble={'-0.8','-0.6','-0.4','-0.2','0','0.2','0.4','0.6','0.8'};
set(gca,'XTick',xtick,'Xticklabel',xtkble);
set(gca,'YTick',ytick,'Yticklabel',ytkble);
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
xlim([-1,1]);
ylim([-0.8,0.8]);
xlabel('Vic_y');
ylabel('Vic_z');
set(gca,'FontSize',extra.FontSize);
cd(outdir);
% print(f3,'-dpng','-r300','figure9-3.png');

%% vx-vy
f4=figure;
vx=prt.value.vx/vA;
p=patch(vx(trange),vy(trange),[prt.value.k(trange(1):trange(end-1)); NaN],'edgecolor','flat','facecolor','none');
xtick=-1.9:0.1:-1.4;
ytick=-1:0.5:1;
xtkble={'-1.9','-1.8','-1.7','-1.6','-1.5','-1.4'};
ytkble={'-1','-0.5','0','0.5','1'};
set(gca,'XTick',xtick,'Xticklabel',xtkble);
set(gca,'YTick',ytick,'Yticklabel',ytkble);
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
xlim([-1.9,-1.4]);
ylim([-1,1]);
xlabel('Vic_x');
ylabel('Vic_y');
set(gca,'FontSize',extra.FontSize);
cd(outdir);
% print(f4,'-dpng','-r300','figure9-4.png');