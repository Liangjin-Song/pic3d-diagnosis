% function plot_3s_density_profiles
%% plot the cold ions density profiles
clear;
%% parameters 
indir='E:\Simulation\Cold\Data';
outdir='E:\Simulation\Cold\Out\Global';
tt=0;
xz=50;
dir=1;
ylab='N';
xrange=[-15,15];
fs=14;

%% read data
prm=slj.Parameters(indir,outdir);
Nl=prm.read('Nl',tt);
Nh=prm.read('Nh',tt);
Ne=prm.read('Ne',tt);
Nhe=prm.read('Nhe',tt);
B=prm.read('B',tt);
% N1=N1.filter2d(3);
% N2=N2.filter2d(3);
% N3=N3.filter2d(3);
% N4=N4.filter2d(3);

%% get the line
ll=Nl.get_line2d(xz, dir, prm, prm.value.n0);
lh=Nh.get_line2d(xz, dir, prm, prm.value.n0);
le=Ne.get_line2d(xz, dir, prm, prm.value.n0);
lhe=Nhe.get_line2d(xz, dir, prm, prm.value.n0);
le=le+lhe;
lb=B.get_line2d(xz,dir,prm,1);
if dir==1
    xlab = 'Z [c/\omega_{pi}]';
    lxz=prm.value.lz;
    sdir = 'x';
else
    lxz=prm.value.lx;
    xlab = 'X [c/\omega_{pi}]';
    sdir = 'z';
end
plot(lxz, ll, '-r', 'LineWidth', 2); hold on
plot(lxz, lh, '-b', 'LineWidth', 2);
plot(lxz, le, '-k', 'LineWidth', 2);
xlabel(xlab);
ylabel(ylab);
legend('Hot ion', 'Cold ion', 'Electron');
set(gca, 'FontSize', fs);
xlim(xrange);

cd(outdir);
print('-dpng', '-r300', ['plasma_density_t', num2str(tt, '%06.2f'), '_', sdir, num2str(xz),'.png']);

%{
[ax,h1,h2]=plotyy(lxz,[ll;lh;le],lxz,lb.lz);
set(ax(1),'XColor','k','YColor','k','FontSize',fs);
set(ax(2),'XColor','k','YColor','r','FontSize',fs);
set(h1(1),'Color','k');
set(h1(2),'Color','g');
set(h1(3),'Color','b');
set(h2,'Color','r');
legend([h1(1);h1(2);h1(3);h2],'Nih','Nic','Ne','Bz','FontSize',fs);
set(h1,'LineWidth',2);
set(h2,'LineWidth',2);
xlabel(extra.xlabel);
set(get(ax(1),'Ylabel'),'String','N','FontSize',fs);
set(get(ax(2),'Ylabel'),'String','Bz','FontSize',fs);
set(ax(1),'xlim',extra.xrange);
set(ax(2),'xlim',extra.xrange);
cd(outdir);
print('-dpng','-r300','density_profile_3s_RF.png');
%}