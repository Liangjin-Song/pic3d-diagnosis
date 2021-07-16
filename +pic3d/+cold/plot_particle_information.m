% function plot_particle_information()
%% writen by Liangjin Song on 20210715
% the particle information in the spectrum
clear;
%% parameters
indir='E:\PIC\Cold-Ions\mie100\data';
outdir='E:\PIC\Cold-Ions\mie100\out\Oral';
prm=slj.Parameters(indir,outdir);
id=char('295320754');

%% particle's information
norm=prm.value.tem*prm.value.tle*prm.value.thl/prm.value.coeff;
trange=1:2501;
prt=prm.read(['trajh_id',id]);
den=prt.acceleration_direction(prm);
den.x=den.x/norm;
den.y=den.y/norm;
den.z=den.z/norm;
prt=prt.norm_energy(norm);
prt=prt.norm_electric_field(prm);
prt=prt.norm_velocity(prm);

%% figure
ha=slj.Plot.subplot(2,2,[0.05,0.05],[0.1,0.05],[0.13,0.06]);
axes(ha(1));
lx=prt.value.time(trange);
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

axes(ha(2));
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

axes(ha(3));
ly=[];
ly.l1=den.x(trange);
ly.l2=den.y(trange);
ly.l3=den.z(trange);
extra.LineStyle={'-', '-', '-'};
extra.LineColor={'r', 'b', 'g'};
extra.legend={'qVxEx', 'qVyEy', 'qVzEz'};
extra.ylabel='Kic';
extra.Location='northwest';
extra.xlabel='\Omega_{ci}t';
slj.Plot.linen(lx, ly, extra);

axes(ha(4));
extra.ylabell='X [c/\omega_{pi}]';
extra.ylabelr='Z [c/\omega_{pi}]';
% extra.yrangel=[40,80];
% extra.yranger=[-1,1];
extra.xlabel='\Omega_{ci}t';
% prt.value.rx(2368:end)=prt.value.rx(2368:end)-100;
slj.Plot.plotyy1(lx, prt.value.rx(trange), prt.value.rz(trange), extra);