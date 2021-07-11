%% the particle trajectory in x-y and y-z plane
clear;
%% parameters
indir='E:\PIC\Cold-Ions\mie100\data';
outdir='E:\PIC\Cold-Ions\mie100\out\Distribution_Function\Diagnose\DF\1202918096';
prm=Parameters(indir,outdir);
id=uint64(1202918096);
tt=1601;
range=1151:2251;
xrange=[23,45];
star=range(1):50:range(end);
%% read data
id=num2str(id);
prt=prm.read_data(['trajh_id',id]);
norm=prm.value.mi*prm.value.vA*prm.value.vA;
prt=prt.norm_energy(norm);
vy=prt.value.vy/prm.value.vA;
vy=(vy(1:end-1)+vy(2:end))/2;

%% y position
nvy=length(vy);
ry=zeros(nvy+1,1);
for i=1:nvy
    ry(i+1)=ry(i)+vy(i)*0.02;
end

%% figure
%% y-z plane
f=figure(1);
p=patch(ry(range),prt.value.rz(range),[prt.value.k(range(1):range(end-1)); NaN],'edgecolor','flat','facecolor','none');
colormap('jet');
set(p,'LineWidth',3);
cb=colorbar;
cb.Label.String='K_{ic} [m_{ic}v_A^2]';
cb.Label.FontSize=14;
caxis([0,max(prt.value.k(range))]);
hold on;
plot(ry(star),prt.value.rz(star),'*k','LineWidth',8);
plot(ry(tt),prt.value.rz(tt),'*r','LineWidth',8);
plot(ry(star(1)),prt.value.rz(star(1)),'*g','LineWidth',8); % begin
plot(ry(star(end)),prt.value.rz(star(end)),'*b','LineWidth',8); % end
hold off
xlabel('Y [c/\omega_{pi}]');
ylabel('Z [c/\omega_{pi}]');
set(gca,'FontSize',14);
cd(outdir);
print(f,'-dpng','-r300','particle_position_y-z_energy_time.png');

%% x-y plane
f=figure(2);
p=patch(prt.value.rx(range),ry(range),[prt.value.k(range(1):range(end-1)); NaN],'edgecolor','flat','facecolor','none');
colormap('jet');
set(p,'LineWidth',3);
cb=colorbar;
cb.Label.String='K_{ic} [m_{ic}v_A^2]';
cb.Label.FontSize=14;
caxis([0,max(prt.value.k(range))]);
hold on;
plot(prt.value.rx(star),ry(star),'*k','LineWidth',8);
plot(prt.value.rx(tt),ry(tt),'*r','LineWidth',8);
plot(prt.value.rx(star(1)),ry(star(1)),'*g','LineWidth',8); % begin
plot(prt.value.rx(star(end)),ry(star(end)),'*b','LineWidth',8); % end
hold off
xlabel('X [c/\omega_{pi}]');
ylabel('Y [c/\omega_{pi}]');
set(gca,'FontSize',14);
cd(outdir);
print(f,'-dpng','-r300','particle_position_x-y_energy_time.png');