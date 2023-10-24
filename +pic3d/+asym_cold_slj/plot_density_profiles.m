% function plot_3s_density_profiles
%% plot the cold ions density profiles
clear;
%% parameters 
indir='E:\Asym\cold2_ds1\data';
outdir='E:\Asym\cold2_ds1\out\Test';
tt=28;
xz=-0.66;
dir=0;
extra.xlabel='X [c/\omega_{pi}]';
extra.ylabel='N';
extra.xrange=[35,45];
fs=14;

%% read data
prm=slj.Parameters(indir,outdir);
Nl=prm.read('Nl',tt);
Nh=prm.read('Nh',tt);
Ne=prm.read('Ne',tt);
B=prm.read('B',tt);
% N1=N1.filter2d(3);
% N2=N2.filter2d(3);
% N3=N3.filter2d(3);
% N4=N4.filter2d(3);

%% get the line
norm = 1;
ll=Nl.get_line2d(xz, dir, prm, norm);
lh=Nh.get_line2d(xz, dir, prm, norm);
le=Ne.get_line2d(xz, dir, prm, norm);
ls=ll+lh;
lb=B.get_line2d(xz,dir,prm,1);
if dir==1
    lxz=prm.value.lz;
    ps='x';
else
    lxz=prm.value.lx;
    ps='z';
end

figure;
plot(lxz, ll, '-r','LineWidth', 1.5);
hold on
plot(lxz, lh, '-b','LineWidth', 1.5);
plot(lxz, le, '-k','LineWidth', 1.5);
plot(lxz, ls, '--k', 'LineWidth', 1.5);
hold off
xlabel(extra.xlabel);
ylabel(extra.ylabel);
legend('Nih', 'Nic', 'Ne', 'Nih + Nic', 'Location', 'Best');
xlim(extra.xrange);
set(gca,'FontSize', fs);
title(['profiles ',ps,' = ',num2str(xz),',  \Omega_{ci}t=',num2str(tt)]);
cd(outdir);
% print('-dpng','-r300',['plasma_density_t',num2str(tt,'%06.2f'),'_',ps,num2str(xz),'.png']);


% [ax,h1,h2]=plotyy(lxz,[ll;lh;le],lxz,lb.lz);
% set(ax(1),'XColor','k','YColor','k','FontSize',fs);
% set(ax(2),'XColor','k','YColor','r','FontSize',fs);
% set(h1(1),'Color','k');
% set(h1(2),'Color','g');
% set(h1(3),'Color','b');
% set(h2,'Color','r');
% legend([h1(1);h1(2);h1(3);h2],'Nih','Nic','Ne','Bz','FontSize',fs);
% set(h1,'LineWidth',2);
% set(h2,'LineWidth',2);
% xlabel(extra.xlabel);
% set(get(ax(1),'Ylabel'),'String','N','FontSize',fs);
% set(get(ax(2),'Ylabel'),'String','Bz','FontSize',fs);
% set(ax(1),'xlim',extra.xrange);
% set(ax(2),'xlim',extra.xrange);
% cd(outdir);
% print('-dpng','-r300','density_profile_3s_RF.png');