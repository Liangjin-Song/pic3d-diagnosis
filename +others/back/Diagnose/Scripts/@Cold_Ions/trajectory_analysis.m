function trajectory_analysis(obj)
%% writen by Liangjin Song on 20210409
%% trajectory analysis for one particle
%%
%% parameters
% particle id
id='1582862044';
acce=3;
name=['trajh_id',id];
extra.FontSize=16;

%% energy normalization
norm=obj.prm.value.tem*obj.prm.value.tle*obj.prm.value.thl/obj.prm.value.coeff;

%% read data
prt=obj.prm.read_data(char(name));
prt.value.kappa(1)=prt.value.kappa(6);
prt.value.kappa(2)=prt.value.kappa(7);
prt.value.kappa(3)=prt.value.kappa(8);
prt.value.kappa(4)=prt.value.kappa(9);
prt.value.kappa(5)=prt.value.kappa(10);
en=prt.acceleration_rate(obj.prm);
en.fermi=en.fermi/norm;
en.beta=en.beta/norm;
en.epara=en.epara/norm;
en.eperp=en.eperp/norm;
den=prt.acceleration_direction(obj.prm);
den.x=den.x/norm;
den.y=den.y/norm;
den.z=den.z/norm;
prt=prt.norm_energy(norm);
prt=prt.norm_electric_field(obj.prm);
prt=prt.norm_velocity(obj.prm);
lx=prt.value.time;
extra.xrange=[0,50];

%% plot figure
f1=figure;
set(f1, 'Position', [100,0,1500,5000])

%% energy in rest frame
subplot(3, 2, 1);
ly.l1=prt.value.k;
ly.l2=prt.value.kx;
ly.l3=prt.value.ky;
ly.l4=prt.value.kz;
extra.LineStyle={'-', '-', '-', '-'};
extra.LineColor={'k', 'r', 'b', 'm'};
extra.legend={'Kic', 'Kx', 'Ky', 'Kz'};
extra.ylabel='Kic';
extra.Location='west';
Figures.linen(lx, ly, extra);
set(gca,'XTicklabel',[]);


%% energy in fac frame
subplot(3, 2, 2);
ly=[];
ly.l1=prt.value.v_para;
ly.l2=prt.value.v_perp;
extra.LineStyle={'-', '-'};
extra.LineColor={'r', 'k'};
extra.legend={'v_{||}', 'v_{\perp}'};
extra.ylabel='V_{ic}';
extra.Location='west';
Figures.linen(lx, ly, extra);
set(gca,'XTicklabel',[]);


%% magnetic field
subplot(3,2,3)
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
Figures.linen(lx, ly, extra);
extra=rmfield(extra,'Location');
set(gca,'XTicklabel',[]);


%% magnetic moment and kappa
subplot(3,2,4);
extra.ylabell='\mu';
extra.ylabelr='\kappa';
extra.yrangel=[0,100];
extra.yranger=[0,10];
Figures.plotyy1(lx, prt.value.mu, prt.value.kappa, extra);
set(gca,'XTicklabel',[]);
extra=rmfield(extra,'yranger');
% ly=[];
% ly.l1=prt.value.vx;
% ly.l2=prt.value.vy;
% ly.l3=prt.value.vz;
% extra.LineStyle={'-', '-','-'};
% extra.LineColor={'r', 'k','b'};
% extra.legend={'v_{x}', 'v_{y}', 'v_{z}'};
% extra.ylabel='V_{ic}';
% extra.Location='west';
% Figures.linen(lx, ly, extra);
% set(gca,'XTicklabel',[]);

extra.FontSize=14;
%% the particle position
subplot(3,2,5);
extra.ylabell='X [c/\omega_{pi}]';
extra.ylabelr='Z [c/\omega_{pi}]';
extra.yrangel=[40,80];
extra.yranger=[-1,1];
extra.xlabel='\Omega_{ci}t';
% prt.value.rx(2368:end)=prt.value.rx(2368:end)-100;
Figures.plotyy1(lx, prt.value.rx, prt.value.rz, extra);
% set(gca,'XTicklabel',[]);
extra=rmfield(extra,'yrangel');
extra=rmfield(extra,'yranger');

%% the acceleration
subplot(3,2,6)
ly=[];
if acce == 1
    %% acceleration in the fac direction
    ly.l1=prt.value.k;
    ly.l2=en.epara;
    ly.l3=en.eperp;
    extra.LineStyle={'-', '-', '-'};
    extra.LineColor={'k', 'r', 'b'};
    extra.legend={'K', 'qV_{||}E_{||}', 'qV_{\perp}E_{\perp}'};
    extra.ylabel='Kic';
elseif acce == 2
    ly.l1=prt.value.k;
    ly.l2=en.fermi;
    ly.l3=en.beta;
    ly.l4=en.epara;
    extra.LineStyle={'-', '-', '-', '-'};
    extra.LineColor={'k', 'r', 'b', 'g'};
    extra.legend={'K', 'Fermi', '\mu dB/dt', 'qV_{||}E_{||}'};
    extra.ylabel='Kic';
else
    ly.l1=prt.value.k;
    ly.l2=den.x;
    ly.l3=den.y;
    ly.l4=den.z;
    extra.LineStyle={'-', '-', '-', '-'};
    extra.LineColor={'k', 'r', 'b', 'g'};
    extra.legend={'K', 'qVxEx', 'qVyEy', 'qVzEz'};
    extra.ylabel='Kic';
    extra.Location='northwest';
end
Figures.linen(lx, ly, extra);

%% add particle's ID as the title
h1 = get(gcf,'children');
axis1 = get(h1(end),'Position');
axis2 = get(h1(end),'Position');
axest = [axis1(1)+axis1(1)*1.7,axis1(2)+axis1(4),axis2(1)+axis1(3)-axis1(1),0.03];
ht = axes('Position',axest);
axis(ht,'off')
title(ht,['ID=', num2str(prt.id)],'FontSize', 16);

set(gca,'FontSize',18);
%% save the figure
cd(obj.prm.value.outdir);
print(f1, '-dpng', '-r350', [name,'_analysis.png']);
close(f1);
