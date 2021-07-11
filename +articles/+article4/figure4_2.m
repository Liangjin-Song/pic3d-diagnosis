% function figure4_2()
%%
% figure 4, part 2
% writen by Liangjin Song on 20210628
% the particle's information which is at the DF
%%
clear;
run('articles.article4.parameters.m');

%% time
tt=32;

%% particles
id1=uint64(1466770715);
id2=uint64(1202918096);
norm=prm.value.mi*prm.value.vA*prm.value.vA;
prt1=prm.read(['trajh_id',num2str(id1)]);
prt1=prt1.norm_energy(norm);
trange1=1451:2101;
prt2=prm.read(['trajh_id',num2str(id1)]);
prt2=prt2.norm_energy(norm);

%% stream
ss=prm.read('stream',tt);

%% figure
f=figure('Position',[500,10,1000,1000]);
ha=slj.Plot.subplot(4,2,[0.09,0.09],[0.085,0.07],[0.085,0.07]);

plot_particle_info(prt1, ss, ha, prm, 1, trange1, extra)


function plot_particle_info(prt, ss, ha, prm, np, trange, extra)
%{
axes(ha(np));
slj.Plot.stream(ss, prm.value.lx, prm.value.lz);
xlabel('X [c/\omega_{pi}]');
ylabel('Z [c/\omega_{pi}]');
xlim([30,50]);
ylim([-5,5]);
range=1:2501;
p=patch(prt.value.rx(range),prt.value.rz(range),[prt.value.k(range(1):range(end-1)); NaN],'edgecolor','flat','facecolor','none');
colormap('jet');
set(p,'LineWidth',3);
cb=colorbar('North');
cb.Label.String='K_{ic} [m_{ic}v_A^2]';
cb.Label.FontSize=extra.FontSize;
caxis([min(prt.value.k(range)),max(prt.value.k(range))]);
set(gca,'FontSize',extra.FontSize);
%}

star=trange(1):50:trange(end);
vA=prm.value.vA;
vx=prt.value.vx/vA;
vy=prt.value.vy/vA;
vz=prt.value.vz/vA;
tt=1601;

axes(ha(np+2));
p=patch(vy(trange),vz(trange),[prt.value.k(trange(1):trange(end-1)); NaN],'edgecolor','flat','facecolor','none');
colormap('jet');
set(p,'LineWidth',3);
cb=colorbar;
cb.Label.String='K_{ic} [m_{ic}v_A^2]';
cb.Label.FontSize=14;
caxis([0,max(prt.value.k(trange))]);
hold on
plot(vy(star),vz(star),'*k','LineWidth',8);
plot(vy(tt),vz(tt),'*r','LineWidth',8); % distribution position
plot(vy(star(1)),vz(star(1)),'*g','LineWidth',8); % begin
plot(vy(star(end)),vz(star(end)),'*b','LineWidth',8); % end
hold off
xlabel('Vic_y [V_{A}]');
ylabel('Vic_z [V_{A}]');
set(gca,'FontSize',14);
end