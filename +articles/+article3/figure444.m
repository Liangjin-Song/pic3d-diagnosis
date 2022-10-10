% function figure4()
%%
% writen by Liangjin Song on 20210624
% the particle information in the spectrum at the DF and the second island
%%
clear;
run('articles.article4.parameters.m');
%% particle's ID
id1='295320754';
id2='1599194011';

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

%% particle's trajectory
extra=[];
fpos=[1000,100,800,850];
f=figure('Position',fpos);
ha=slj.Plot.subplot(4,2,[0.02,0.1],[0.09,0.05],[0.09,0.1]);

%% particle 1
extra.xrange=[40,50];
particle_information(ha, 1, prt1, den1, trange, extra);
%% particle 2
extra.xrange=[0,50];
particle_information(ha, 2, prt2, den2, trange, extra);
%% save figure
cd(outdir);
print(f,'-dpng','-r300','figure4.png');


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
if np == 1
    extra.legend={'K', 'Kx', 'Ky', 'Kz'};
    extra.ylabel='Kic';
    extra.Location='west';
end
slj.Plot.linen(lx, ly, extra);
set(gca,'XTicklabel',[]);

axes(ha(np+4));
ly=[];
ly.l1=den.x(trange);
ly.l2=den.y(trange);
ly.l3=den.z(trange);
extra.LineStyle={'-', '-', '-'};
extra.LineColor={'r', 'b', 'g'};
if np == 1
    extra.legend={'\int_0^{ t}qVxEx dt', '\int_0^{ t}qVyEy dt', '\int_0^{ t}qVzEz dt'};
    extra.ylabel='Kic';
    extra.Location='northwest';
end
slj.Plot.linen(lx, ly, extra);
set(gca,'XTicklabel',[]);

axes(ha(np+2));
ly=[];
ly.l1=prt.value.bx(trange);
ly.l2=prt.value.by(trange);
ly.l3=prt.value.bz(trange);
ly.l4=sqrt(ly.l1.^2+ly.l2.^2+ly.l3.^2);
extra.LineStyle={'-', '-', '-', '--'};
extra.LineColor={'r', 'b', 'g', 'k'};
if np == 1
    extra.legend={'Bx', 'By', 'Bz', '|B|'};
    extra.ylabel='B';
    extra.Location='west';
end
slj.Plot.linen(lx, ly, extra);
if np == 1
    extra=rmfield(extra,'Location');
end
set(gca,'XTicklabel',[]);

axes(ha(np+6));
if np == 1
    extra.ylabell='X [c/\omega_{pi}]';
else
    extra.ylabelr='Z [c/\omega_{pi}]';
end
extra.xlabel='\Omega_{ci}t';
slj.Plot.plotyy1(lx, prt.value.rx(trange), prt.value.rz(trange), extra);
end