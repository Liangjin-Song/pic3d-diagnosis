% function figure3()
%%
% writen by Liangjin Song on 20210624
% the particle information in the spectrum at the DF and the second island
%%
clear;
run('articles.article4.parameters.m');
%% particle's ID
id1='295320754';
id2='1599194011';

%% particle's time information
tt1=45;
tt2=50;
% tt3=41;

%% figure property
extra.xlabel='X [c/\omega_{pi}]';
extra.ylabel='Z [c/\omega_{pi}]';
extra.ColorbarPosition='north';
extra.FontSize=16;

%% particle's information
% norm=prm.value.tem*prm.value.tle*prm.value.thl/prm.value.coeff;
norm=prm.value.mi*prm.value.vA.^2;
trange=1:2501;

% particle 1
prt1=prm.read(['trajh_id',id1]);
den1=prt1.acceleration_direction(prm);
den1.x=den1.x/norm;
den1.y=den1.y/norm;
den1.z=den1.z/norm;
prt1=prt1.norm_energy(norm);
prt1=prt1.norm_electric_field(prm);
prt1=prt1.norm_velocity(prm);
% particle 2
prt2=prm.read(['trajh_id',id2]);
den2=prt2.acceleration_direction(prm);
den2.x=den2.x/norm;
den2.y=den2.y/norm;
den2.z=den2.z/norm;
prt2=prt2.norm_energy(norm);
prt2=prt2.norm_electric_field(prm);
prt2=prt2.norm_velocity(prm);


%% figure
dh=0.12;
f=figure('Position',[500,100,800,500]);
ha=slj.Plot.subplot(1,2,[0.09,0.07],[0.1,0.07],[0.1,0.06]);

%% part 1, the particle's trajectory
% particle 1
axes(ha(1));
ss=prm.read('stream',tt1);
cr=[0, max(prt1.value.k(trange))];
slj.Plot.stream(ss,prm.value.lx,prm.value.lz,40);
hold on
p=patch(prt1.value.rx(trange),prt1.value.rz(trange),[prt1.value.k(trange(1:end-1));NaN],'edgecolor','flat','facecolor','none');
caxis(cr);
colormap('jet');
hbar=colorbar(extra.ColorbarPosition);
pos=get(hbar,'Position');
pos(2)=pos(2)+dh;
set(hbar,'Position',pos);
set(hbar,'AxisLocation','out');
xlim([20,35]);
ylim([-5,5]);
set(p,'LineWidth',3);
xlabel(extra.xlabel);
ylabel(extra.ylabel);
set(gca,'FontSize',extra.FontSize);

% particle 2
axes(ha(2));
ss=prm.read('stream',tt2);
cr=[0, max(prt2.value.k(trange))];
slj.Plot.stream(ss,prm.value.lx,prm.value.lz,40);
hold on
p=patch(prt2.value.rx(trange),prt2.value.rz(trange),[prt2.value.k(trange(1:end-1));NaN],'edgecolor','flat','facecolor','none');
caxis(cr);
colormap('jet');
hbar=colorbar(extra.ColorbarPosition);
pos=get(hbar,'Position');
pos(2)=pos(2)+dh;
set(hbar,'Position',pos);
set(hbar,'AxisLocation','out');
xlim([49,70]);
ylim([-7,7]);
set(p,'LineWidth',3);
xlabel(extra.xlabel);
% ylabel(extra.ylabel);
set(gca,'FontSize',extra.FontSize);

%% save figure
cd(outdir);
print(f,'-dpng','-r300','figure3.png');