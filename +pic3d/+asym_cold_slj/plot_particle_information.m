% function trajectory_survey(obj, name)
%% writen by Liangjin Song on 20210412
%% 
clear;
indir='E:\Asym\cold2_ds1\data';
outdir='E:\Asym\cold2_ds1\out\Kinetic\Trajectory\X-line';
prm=slj.Parameters(indir,outdir);
id='971785639';
name=['trajh_id',id];

%% energy normalization
norm=prm.value.mi*prm.value.vA.^2;

%% read data
prt=prm.read(char(name));
% prt.value.kappa(1)=prt.value.kappa(6);
% prt.value.kappa(2)=prt.value.kappa(7);
% prt.value.kappa(3)=prt.value.kappa(8);
% prt.value.kappa(4)=prt.value.kappa(9);
% prt.value.kappa(5)=prt.value.kappa(10);
en=prt.acceleration_rate(prm);
en.fermi=en.fermi/norm;
en.beta=en.beta/norm;
en.epara=en.epara/norm;
en.eperp=en.eperp/norm;
den=prt.acceleration_direction(prm);
den.x=den.x/norm;
den.y=den.y/norm;
den.z=den.z/norm;
prt=prt.norm_energy(norm);
prt=prt.norm_electric_field(prm);
prt=prt.norm_velocity(prm);
lx=prt.value.time;
extra.xrange=[0,70];

%% plot figure
f1=figure;
set(f1, 'Position', [100,0,1500,5000])
dk=prt.value.k-prt.value.k(1);
%% energy in rest frame
subplot(6, 2, 1);
ly.l1=prt.value.k;
ly.l2=prt.value.kx;
ly.l3=prt.value.ky;
ly.l4=prt.value.kz;
extra.LineStyle={'-', '-', '-', '-'};
extra.LineColor={'k', 'r', 'b', 'm'};
extra.legend={'Kic', 'Kx', 'Ky', 'Kz'};
extra.ylabel='Kic';
extra.Location='west';
slj.Plot.linen(lx, ly, extra);
set(gca,'XTicklabel',[]);


%% energy in fac frame
subplot(6, 2, 2);
ly=[];
ly.l1=prt.value.k_para;
ly.l2=prt.value.k_perp;
ly.l3=prt.value.k;
extra.LineStyle={'-', '-', '--'};
extra.LineColor={'r', 'b', 'k'};
extra.legend={'K_{||}', 'K_{\perp}', 'Kic'};
extra.ylabel='Kic';
slj.Plot.linen(lx, ly, extra);
set(gca,'XTicklabel',[]);


%% magnetic field
subplot(6,2,3)
ly=[];
ly.l1=prt.value.bx;
ly.l2=prt.value.by;
ly.l3=prt.value.bz;
ly.l4=sqrt(ly.l1.^2+ly.l2.^2+ly.l3.^2);
extra.LineStyle={'-', '-', '-', '--'};
extra.LineColor={'r', 'b', 'g', 'k'};
extra.legend={'Bx', 'By', 'Bz', '|B|'};
extra.ylabel='B';
extra.Location='west';
slj.Plot.linen(lx, ly, extra);
extra=rmfield(extra,'Location');
set(gca,'XTicklabel',[]);


%% magnetic moment and kappa
subplot(6,2,4);
extra.ylabell='\mu';
extra.ylabelr='\kappa';
extra.yranger=[0,10];
extra.yrangel=[0,3];
slj.Plot.plotyy1(lx, prt.value.mu, prt.value.kappa, extra);
set(gca,'XTicklabel',[]);
extra=rmfield(extra,'yrangel');
extra=rmfield(extra,'yranger');


%% electric field in the rest frame
subplot(6,2,5)
ly=[];
ly.l1=prt.value.ex;
ly.l2=prt.value.ey;
ly.l3=prt.value.ez;
extra.LineStyle={'-', '-', '-'};
extra.LineColor={'r', 'b', 'k'};
extra.legend={'Ex', 'Ey', 'Ez'};
extra.ylabel='E';
extra.Location='west';
slj.Plot.linen(lx, ly, extra);
extra=rmfield(extra,'Location');
set(gca,'XTicklabel',[]);


%% electric field in the fac frame
subplot(6,2,6)
ly=[];
ly.l1=prt.value.e_para;
ly.l2=prt.value.e_perp;
extra.LineStyle={'-', '--'};
extra.LineColor={'r', 'k'};
extra.legend={'E_{||}', 'E_{\perp}'};
extra.ylabel='E';
extra.Location='west';
slj.Plot.linen(lx, ly, extra);
extra=rmfield(extra,'Location');
set(gca,'XTicklabel',[]);

%% velocity in the rest frame
subplot(6,2,7)
ly=[];
ly.l1=prt.value.vx;
ly.l2=prt.value.vy;
ly.l3=prt.value.vz;
extra.LineStyle={'-', '-', '-'};
extra.LineColor={'r', 'b', 'k'};
extra.legend={'vx', 'vy', 'vz'};
extra.ylabel='V_{ic}';
extra.Location='west';
slj.Plot.linen(lx, ly, extra);
extra=rmfield(extra,'Location');
set(gca,'XTicklabel',[]);

%% velocity in the rest frame
subplot(6,2,8)
ly=[];
ly.l1=prt.value.v_para;
ly.l2=prt.value.v_perp;
extra.LineStyle={'-', '-'};
extra.LineColor={'r', 'k'};
extra.legend={'v_{||}', 'v_{\perp}'};
extra.ylabel='V_{ic}';
extra.Location='west';
slj.Plot.linen(lx, ly, extra);
set(gca,'XTicklabel',[]);


extra.FontSize=14;
%% acceleration in the rest direction
subplot(6,2,9)
ly=[];
ly.l1=dk;
ly.l2=den.x;
ly.l3=den.y;
ly.l4=den.z;
ly.l5=ly.l2+ly.l3+ly.l4;
extra.LineStyle={'-', '-', '-', '-', '--'};
extra.LineColor={'k', 'r', 'b', 'g', 'k'};
extra.legend={'\Delta K', 'qVxEx', 'qVyEy', 'qVzEz', 'Sum'};
extra.ylabel='\Delta Kic';
extra.Location='northwest';
slj.Plot.linen(lx, ly, extra);
set(gca,'XTicklabel',[]);


%% acceleration in the fac direction
subplot(6,2,10)
ly=[];
ly.l1=dk;
ly.l2=en.epara;
ly.l3=en.eperp;
ly.l4=ly.l2+ly.l3;
extra.LineStyle={'-', '-', '-', '--'};
extra.LineColor={'k', 'r', 'b', 'k'};
extra.legend={'\Delta K', 'qV_{||}E_{||}', 'qV_{\perp}E_{\perp}', 'Sum'};
extra.ylabel='\Delta Kic';
slj.Plot.linen(lx, ly, extra);
set(gca,'XTicklabel',[]);


%% the particle position
subplot(6,2,11);
extra.ylabell='X [c/\omega_{pi}]';
extra.ylabelr='Z [c/\omega_{pi}]';
extra.xlabel='\Omega_{ci}t';
extra.yrangel=[0,100];
slj.Plot.plotyy1(lx, prt.value.rx, prt.value.rz, extra);
extra=rmfield(extra,'yrangel');
% set(gca,'XTicklabel',[]);


%% the acceleration
subplot(6, 2, 12);
ly=[];
ly.l1=dk;
ly.l2=en.fermi;
ly.l3=en.beta;
ly.l4=en.epara;
ly.l5=ly.l2+ly.l3+ly.l4;
extra.LineStyle={'-', '-', '-', '-', '--'};
extra.LineColor={'k', 'r', 'b', 'g', 'k'};
extra.legend={'\Delta K', 'Fermi', '\mu dB/dt', 'qV_{||}E_{||}', 'Sum'};
extra.ylabel='\Delta Kic';
slj.Plot.linen(lx, ly, extra);
% set(gca,'XTicklabel',[]);


%% add particle's ID as the title
h1 = get(gcf,'children');
axis1 = get(h1(end),'Position');
axis2 = get(h1(end),'Position');
axest = [axis1(1)+axis1(1)*1.7,axis1(2)+axis1(4),axis2(1)+axis1(3)-axis1(1),0.03];
ht = axes('Position',axest);
axis(ht,'off')
title(ht,['ID=', num2str(prt.id)],'FontSize', 16);


%% save the figure
cd(outdir);
print(f1, '-dpng', '-r350', [name,'_survey.png']);