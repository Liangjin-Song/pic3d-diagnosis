% function figure3_3()
%% plot the particle's trajectory, power of the electric field
% writen by Liangjin Song on 20210627
%%
clear;
run('articles.article4.parameters.m');
%% the particle's id
id=uint64(1607615077);

%% set the figure
f=figure('Position',[1000,10,600,800]);
ha=slj.Plot.subplot(3,1,[0.09,0.085],[0.085,0.07],[0.25,0.2]);

%% read the partile data
prt=prm.read(['trajh_id',num2str(id)]);
norm=prm.value.mi*prm.value.vA*prm.value.vA;
prt=prt.norm_energy(norm);

%% the particle's duration
tt=801;
range=1:1001;
xrange=[0,20];
star=range(1):50:range(end);

%% vy-vz
vA=prm.value.vA;
vy=prt.value.vy/vA;
vz=prt.value.vz/vA;
axes(ha(1));
p=patch(vy(range),vz(range),[prt.value.k(range(1):range(end-1)); NaN],'edgecolor','flat','facecolor','none');
xtick=-0.6:0.3:0.6;
set(gca,'XTick',xtick,'Xticklabel',xtick);
set(gca,'YTick',xtick,'Yticklabel',xtick);
colormap('jet');
set(p,'LineWidth',3);
cb=colorbar;
cb.Label.String='K_{ic} [m_{ic}v_A^2]';
cb.Label.FontSize=extra.FontSize;
caxis([0,max(prt.value.k(range))]);
hold on
plot(vy(star),vz(star),'*k','LineWidth',8);
plot(vy(tt),vz(tt),'*r','LineWidth',8); % distribution position
plot(vy(star(1)),vz(star(1)),'*g','LineWidth',8); % begin
plot(vy(star(end)),vz(star(end)),'*b','LineWidth',8); % end
hold off
xlabel('Vic_y [V_{A}]');
ylabel('Vic_z [V_{A}]');
set(gca,'FontSize',extra.FontSize);

%% ry-rz
vy=(vy(1:end-1)+vy(2:end))/2;

%% y position
nvy=length(vy);
ry=zeros(nvy+1,1);
for i=1:nvy
    ry(i+1)=ry(i)+vy(i)*0.02;
end

%% y-z trajectory
axes(ha(2));
p=patch(ry(range),prt.value.rz(range),[prt.value.k(range(1):range(end-1)); NaN],'edgecolor','flat','facecolor','none');

colormap('jet');
set(p,'LineWidth',3);
cb=colorbar;
cb.Label.String='K_{ic} [m_{ic}v_A^2]';
cb.Label.FontSize=extra.FontSize;
caxis([0,max(prt.value.k(range))]);
xtick=-50:1:50;
set(gca,'XTick',xtick,'Xticklabel',xtick);
set(gca,'YTick',xtick,'Yticklabel',xtick);
hold on;
plot(ry(star),prt.value.rz(star),'*k','LineWidth',8);
plot(ry(tt),prt.value.rz(tt),'*r','LineWidth',8);
plot(ry(star(1)),prt.value.rz(star(1)),'*g','LineWidth',8); % begin
plot(ry(star(end)),prt.value.rz(star(end)),'*b','LineWidth',8); % end
hold off
xlabel('Y [c/\omega_{pi}]');
ylabel('Z [c/\omega_{pi}]');
set(gca,'FontSize',extra.FontSize);


%% the power of the electric field
den=prt.acceleration_direction(prm);
den.x=den.x/norm;
den.y=den.y/norm;
den.z=den.z/norm;
ly.l1=prt.value.k(range);
ly.l2=den.x(range);
ly.l3=den.y(range);
ly.l4=den.z(range);
extra.LineStyle={'-', '-', '-', '-'};
extra.LineColor={'k', 'r', 'b', 'g'};
extra.legend={'K', 'qVxEx', 'qVyEy', 'qVzEz'};
extra.ylabel='Kic';
extra.Location='northwest';
extra.xlabel='\Omega_{ci}t';
axes(ha(3));
slj.Plot.linen(prt.value.time(range), ly, extra);

%% save the figure
cd(outdir);
print('-dpng','-r300','figure3-3.png');