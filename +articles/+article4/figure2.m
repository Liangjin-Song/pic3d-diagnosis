% function figure2()
%% figure 2
% writen by Liangjin Song on 20210624
% the particle information in the spectrum
%%
clear;
run('articles.article4.parameters.m');
%% particle's ID
id1='295320754';
id2='1599194011';
id3='1479944291';

%% particle's time information
tt1=45;
tt2=50;
tt3=41;

%% figure property
extra.xlabel='X [c/\omega_{pi}]';
extra.ylabel='Z [c/\omega_{pi}]';
extra.FontSize=16;

%% particle's information
norm=prm.value.tem*prm.value.tle*prm.value.thl/prm.value.coeff;
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
% particle 3
prt3=prm.read(['trajh_id',id3]);
den3=prt3.acceleration_direction(prm);
den3.x=den3.x/norm;
den3.y=den3.y/norm;
den3.z=den3.z/norm;
prt3=prt3.norm_energy(norm);
prt3=prt3.norm_electric_field(prm);
prt3=prt3.norm_velocity(prm);


%% figure
fpos=[0,0,1200,500];

f=figure('Position',fpos);
pos1=[0.1,0.3,0.2,0];
dp=0.11;
pos1(4)=pos1(3)*fpos(3)/(fpos(4));
%
pos2=pos1;
pos2(1)=pos1(1)+pos1(3)+dp;
pos2(4)=pos2(3)*fpos(3)/(fpos(4));
% axes('Position',pos2);
%
pos3=pos2;
pos3(1)=dp+pos2(1)+pos2(3);
pos3(4)=pos3(3)*fpos(3)/(fpos(4));
% axes('Position',pos3);

%% part 1, the particle's trajectory
% particle 1
% subplot(1,3,1);
axes('Position',pos1);
ss=prm.read('stream',tt1);
cr=[0, max(prt1.value.k(trange))];
slj.Plot.stream(ss,prm.value.lx,prm.value.lz);
hold on
p=patch(prt1.value.rx(trange),prt1.value.rz(trange),[prt1.value.k(trange(1:end-1));NaN],'edgecolor','flat','facecolor','none');
caxis(cr);
colormap('jet');
colorbar;
xlim([20,35]);
ylim([-8,8]);
set(p,'LineWidth',3);
xlabel(extra.xlabel);
ylabel(extra.ylabel);
set(gca,'FontSize',extra.FontSize);

% particle 2
% subplot(1,3,2);
axes('Position',pos2);
ss=prm.read('stream',tt2);
cr=[0, max(prt2.value.k(trange))];
slj.Plot.stream(ss,prm.value.lx,prm.value.lz);
hold on
p=patch(prt2.value.rx(trange),prt2.value.rz(trange),[prt2.value.k(trange(1:end-1));NaN],'edgecolor','flat','facecolor','none');
caxis(cr);
colormap('jet');
colorbar;
xlim([49,70]);
ylim([-11,11]);
set(p,'LineWidth',3);
xlabel(extra.xlabel);
ylabel(extra.ylabel);
set(gca,'FontSize',extra.FontSize);

% particle 3
% subplot(1,3,3);
axes('Position',pos3);
ss=prm.read('stream',tt3);
cr=[0, max(prt3.value.k(trange))];
slj.Plot.stream(ss,prm.value.lx,prm.value.lz);
hold on
p=patch(prt3.value.rx(1:2367),prt3.value.rz(1:2367),[prt3.value.k(1:2366);NaN],'edgecolor','flat','facecolor','none');
set(p,'LineWidth',3);
p=patch(prt3.value.rx(2368:trange(end)),prt3.value.rz(2368:trange(end)),[prt3.value.k(2368:trange(end-1));NaN],'edgecolor','flat','facecolor','none');
set(p,'LineWidth',3);
caxis(cr);
colormap('jet');
colorbar;
xlim([22,52]);
ylim([-16,16]);
xlabel(extra.xlabel);
ylabel(extra.ylabel);
set(gca,'YTickMode','auto');
set(gca,'FontSize',extra.FontSize);
%% save figure2-1
cd(outdir);
print(f,'-dpng','-r300','figure2-1.png');


%% particle's trajectory
extra=[];
fpos(4)=850;
f=figure('Position',fpos);
ha=slj.Plot.subplot(4,3,[0.02,0.12],[0.1,0.05],[0.06,0.06]);

%% particle 1
extra.xrange=[40,50];
particle_information(ha, 1, prt1, den1, trange, extra);
%% particle 2
extra.xrange=[0,50];
particle_information(ha, 2, prt2, den2, trange, extra);
%% particle 3
cmd='obj.value.rx(2368:end)=obj.value.rx(2368:end)-100;';
prt3=prt3.command(cmd);
particle_information(ha, 3, prt3, den3, trange, extra);
%% save figure2-2
cd(outdir);
print(f,'-dpng','-r300','figure2-2.png');


function particle_information(ha, np, prt, den, trange, extra)
lx=prt.value.time(trange);
% extra.xrange=[lx(1),lx(end)];
axes(ha(np));
ly.l1=prt.value.k(trange);
ly.l2=prt.value.kx(trange);
ly.l3=prt.value.ky(trange);
ly.l4=prt.value.kz(trange);
extra.LineStyle={'-', '-', '-', '-'};
extra.LineColor={'k', 'r', 'b', 'm'};
extra.legend={'K', 'Kx', 'Ky', 'Kz'};
extra.ylabel='Kic';
extra.Location='west';
slj.Plot.linen(lx, ly, extra);
set(gca,'XTicklabel',[]);

axes(ha(np+6));
ly=[];
ly.l1=den.x(trange);
ly.l2=den.y(trange);
ly.l3=den.z(trange);
extra.LineStyle={'-', '-', '-'};
extra.LineColor={'r', 'b', 'g'};
extra.legend={'qVxEx', 'qVyEy', 'qVzEz'};
extra.ylabel='Kic';
extra.Location='northwest';
slj.Plot.linen(lx, ly, extra);
set(gca,'XTicklabel',[]);

% axes(ha(np+6));
% extra.ylabelr='\mu';
% extra.ylabell='\kappa';
% extra.yranger=[0,100];
% extra.yrangel=[0,10];
% slj.Plot.plotyy1(lx, prt.value.kappa(trange), prt.value.mu(trange), extra);
% set(gca,'XTicklabel',[]);
% extra=rmfield(extra,'yranger');
% extra=rmfield(extra,'yrangel');

axes(ha(np+3));
ly=[];
ly.l1=prt.value.bx(trange);
ly.l2=prt.value.by(trange);
ly.l3=prt.value.bz(trange);
ly.l4=sqrt(ly.l1.^2+ly.l2.^2+ly.l3.^2);
extra.LineStyle={'-', '-', '-', '--'};
extra.LineColor={'r', 'b', 'g', 'k'};
extra.legend={'Bx', 'By', 'Bz', '|B|'};
extra.ylabel='B';
extra.Location='west';
slj.Plot.linen(lx, ly, extra);
extra=rmfield(extra,'Location');
set(gca,'XTicklabel',[]);

axes(ha(np+9));
extra.ylabell='X [c/\omega_{pi}]';
extra.ylabelr='Z [c/\omega_{pi}]';
% extra.yrangel=[40,80];
% extra.yranger=[-1,1];
extra.xlabel='\Omega_{ci}t';
% prt.value.rx(2368:end)=prt.value.rx(2368:end)-100;
slj.Plot.plotyy1(lx, prt.value.rx(trange), prt.value.rz(trange), extra);
end