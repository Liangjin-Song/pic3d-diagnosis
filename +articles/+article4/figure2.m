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
extra.FontSize=12;

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
dh=0.035;
daxs=0.05;
% f=figure('Position',[500,100,800,500]);
% ha=slj.Plot.subplot(1,2,[0.09,0.07],[0.1,0.07],[0.1,0.06]);
% extra=[];
fpos=[800,10,800,1000];
f=figure('Position',fpos);
ha=slj.Plot.subplot(5,2,[0.015,0.1],[0.07,0.1],[0.09,0.1]);


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

pos=get(ha(1),'Position');
pos(2)=pos(2)+daxs;
set(ha(1),'Position',pos);

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

pos=get(ha(2),'Position');
pos(2)=pos(2)+daxs;
set(ha(2),'Position',pos);

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

%%
norm=prm.value.mi*prm.value.vA.^2;
trange=1:2501;
extra=[];
extra.FontSize=12;
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
% extra=[];
% fpos=[1000,100,800,850];
% f=figure('Position',fpos);
% ha=slj.Plot.subplot(4,2,[0.02,0.1],[0.09,0.05],[0.09,0.1]);

%% particle 1
extra.xrange=[40,50];
particle_information(ha, 1, prt1, den1, trange, extra);
%% particle 2
extra.xrange=[0,50];
particle_information(ha, 2, prt2, den2, trange, extra);

%% save figure
cd(outdir);
print(f,'-dpng','-r300','figure2.png');

%%
function particle_information(ha, np, prt, den, trange, extra)
lx=prt.value.time(trange);
% extra.xrange=[lx(1),lx(end)];
axes(ha(np+2));
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
h=slj.Plot.linen(lx, ly, extra);
set(h,'box','off');
set(gca,'XTicklabel',[]);

axes(ha(np+4+2));
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
h=slj.Plot.linen(lx, ly, extra);
set(h,'box','off');
set(gca,'XTicklabel',[]);

axes(ha(np+2+2));
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
h=slj.Plot.linen(lx, ly, extra);
if np == 1
    extra=rmfield(extra,'Location');
    set(h,'box','off');
end
set(gca,'XTicklabel',[]);

axes(ha(np+6+2));
if np == 1
    extra.ylabell='X [c/\omega_{pi}]';
else
    extra.ylabelr='Z [c/\omega_{pi}]';
end
extra.xlabel='\Omega_{ci}t';
slj.Plot.plotyy1(lx, prt.value.rx(trange), prt.value.rz(trange), extra);
end
