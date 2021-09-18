%% find particles id according to particles distribution fundction
% writen by Liangjin Song on 20210330
%%
% clear;
indir='E:\PIC\Cold-Ions\mie100\data';
outdir='E:\PIC\Cold-Ions\mie100\out\Distribution_Function\Diagnose\DF\1202918096';
% name='PVh_ts96200_x2103-2126_y987-1013_z0-1';    % 30
% name='PVh_ts99359_x2120-2143_y988-1014_z0-1';  % 31
name='PVh_ts102564_x1460-1505_y986-1015_z0-1';   % 32
% name='PVh_ts105769_x2161-2185_y988-1014_z0-1';  % 33
% name='PVh_ts108974_x2184-2208_y988-1013_z0-1';  % 34
id=uint64(1202918096);
tt=1601;
range=1151:2251;
xrange=[23,45];
star=range(1):50:range(end);
extra.range=1.5;
prm=Parameters(indir,outdir);
dst=prm.read_data(name);

%% find the particles id
in=find(dst.value.id==id);
v.x=dst.value.vx(in)/prm.value.vA;
v.y=dst.value.vy(in)/prm.value.vA;
v.z=dst.value.vz(in)/prm.value.vA;

dsta=dst.distribution_function(prm);
fig=Figures.draw(prm, dsta, extra);
cd(outdir);
f=figure(1); hold on
plot(v.y,v.z,'*k','LineWidth',5);
hold off
% xlim([0,1]);
% ylim([-0.5,0.5]);
print(f,'-dpng','-r300',[name,'_y-z_position.png']);
f=figure(2); hold on
plot(v.x,v.z,'*k','LineWidth',5);
hold off
print(f,'-dpng','-r300',[name,'_x-z_position.png']);
f=figure(3); hold on
plot(v.x,v.y,'*k','LineWidth',5);
hold off
print(f,'-dpng','-r300',[name,'_x-y_position.png']);

%% plot the trajectory of cold ions
cd(indir);
id=num2str(id);
cold=Cold_Ions(indir,outdir);
prt=cold.prm.read_data(['trajh_id',id]);
norm=cold.prm.value.mi*cold.prm.value.vA*cold.prm.value.vA;
prt=prt.norm_energy(norm);
f=figure(4);
p=patch(prt.value.rx(range),prt.value.rz(range),[prt.value.k(range(1):range(end-1)); NaN],'edgecolor','flat','facecolor','none');
colormap('jet');
set(p,'LineWidth',3);
cb=colorbar;
cb.Label.String='K_{ic} [m_{ic}v_A^2]';
cb.Label.FontSize=14;
caxis([0,max(prt.value.k(range))]);
hold on;
plot(prt.value.rx(star),prt.value.rz(star),'*k','LineWidth',8);
plot(prt.value.rx(tt),prt.value.rz(tt),'*r','LineWidth',8);
plot(prt.value.rx(star(1)),prt.value.rz(star(1)),'*g','LineWidth',8); % begin
plot(prt.value.rx(star(end)),prt.value.rz(star(end)),'*b','LineWidth',8); % end
hold off
xlabel('X [c/\omega_{pi}]');
ylabel('Z [c/\omega_{pi}]');
set(gca,'FontSize',14);
cd(outdir);
print(f,'-dpng','-r300','particle_position_energy_time.png');

%% velocity
vA=cold.prm.value.vA;
vx=prt.value.vx/vA;
vy=prt.value.vy/vA;
vz=prt.value.vz/vA;
f=figure(5);
% plot(vy(range),vz(range),'-r','LineWidth',2);
p=patch(vy(range),vz(range),[prt.value.k(range(1):range(end-1)); NaN],'edgecolor','flat','facecolor','none');
colormap('jet');
set(p,'LineWidth',3);
cb=colorbar;
cb.Label.String='K_{ic} [m_{ic}v_A^2]';
cb.Label.FontSize=14;
caxis([0,max(prt.value.k(range))]);
hold on
plot(vy(star),vz(star),'*k','LineWidth',8);
plot(vy(tt),vz(tt),'*r','LineWidth',8); % distribution position
plot(vy(star(1)),vz(star(1)),'*g','LineWidth',8); % begin
plot(vy(star(end)),vz(star(end)),'*b','LineWidth',8); % end
hold off
xlabel('Vic_y [V_{A}]');
ylabel('Vic_z [V_{A}]');
set(gca,'FontSize',14);
cd(outdir);
print(f,'-dpng','-r300','particle_velocity-y-z_energy_time.png');

f=figure(6);
% plot(vy(range),vz(range),'-r','LineWidth',2);
p=patch(vx(range),vz(range),[prt.value.k(range(1):range(end-1)); NaN],'edgecolor','flat','facecolor','none');
colormap('jet');
set(p,'LineWidth',3);
cb=colorbar;
cb.Label.String='K_{ic} [m_{ic}v_A^2]';
cb.Label.FontSize=14;
caxis([0,max(prt.value.k(range))]);
hold on
plot(vx(star),vz(star),'*k','LineWidth',8);
plot(vx(tt),vz(tt),'*r','LineWidth',8); % distribution position
plot(vx(star(1)),vz(star(1)),'*g','LineWidth',8); % begin
plot(vx(star(end)),vz(star(end)),'*b','LineWidth',8); % end
hold off
xlabel('V_x [V_{A}]');
ylabel('V_z [V_{A}]');
set(gca,'FontSize',14);
print(f,'-dpng','-r300','particle_velocity-x-z_energy_time.png');

f=figure(7);
% plot(vy(range),vz(range),'-r','LineWidth',2);
p=patch(vx(range),vy(range),[prt.value.k(range(1):range(end-1)); NaN],'edgecolor','flat','facecolor','none');
colormap('jet');
set(p,'LineWidth',3);
cb=colorbar;
cb.Label.String='K_{ic} [m_{ic}v_A^2]';
cb.Label.FontSize=14;
caxis([0,max(prt.value.k(range))]);
hold on
plot(vx(star),vy(star),'*k','LineWidth',8);
plot(vx(tt),vy(tt),'*r','LineWidth',8); % distribution position
plot(vx(star(1)),vy(star(1)),'*g','LineWidth',8); % begin
plot(vx(star(end)),vy(star(end)),'*b','LineWidth',8); % end
hold off
xlabel('V_x [V_{A}]');
ylabel('V_y [V_{A}]');
set(gca,'FontSize',14);
print(f,'-dpng','-r300','particle_velocity-x-y_energy_time.png');

%% the rz and vz as the function of the time
f=figure(8);
plot(prt.value.time(range),prt.value.rz(range),'-k','LineWidth',2);
xlabel('\Omega_{ci}t');
ylabel('Z [c/\omega_{pi}]');
set(gca,'FontSize',14);
xlim();
print(f,'-dpng','-r300','particle_rz_time.png');

f=figure(9);
plot(prt.value.time(range),vz(range),'-k','LineWidth',2);
xlabel('\Omega_{ci}t');
ylabel('Vic_z [v_A]');
set(gca,'FontSize',14);
xlim(xrange);
print(f,'-dpng','-r300','particle_vz_time.png');

f=figure(10);
plot(prt.value.time(range),vy(range),'-k','LineWidth',2);
xlabel('\Omega_{ci}t');
ylabel('Vic_y [v_A]');
set(gca,'FontSize',14);
xlim(xrange);
print(f,'-dpng','-r300','particle_vy_time.png');