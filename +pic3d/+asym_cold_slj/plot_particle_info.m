% plot particle information
%%
% writen by Liangjin Song on 20211129
% the particle information in the spectrum at the DF and the second island
%%
clear;
%%
indir='E:\Asym\cold2_ds1\data';
outdir='E:\Asym\cold2_ds1\out\Kinetic\Trajectory\X-line';
prm=slj.Parameters(indir,outdir);
%% particle's ID
%% id1='295320754';
id = '1595262401';
spc='h';
spcs='ic';

xrange=[0,70];

%% figure property
extra.ColorbarPosition='north';
extra.FontSize=12;

%% particle's information
% norm=prm.value.tem*prm.value.tle*prm.value.thl/prm.value.coeff;
norm=0.5*prm.value.mi*prm.value.vA*prm.value.vA;

% particle
prt=prm.read(['traj',spc,'_id',id]);
den=prt.acceleration_direction(prm);
den.x=den.x/norm;
den.y=den.y/norm;
den.z=den.z/norm;
prt=prt.norm_energy(norm);
prt=prt.norm_electric_field(prm);
prt=prt.norm_velocity(prm);
en=prt.acceleration_rate(prm);
en.epara=en.epara/norm*prm.value.wci;
en.eperp=en.eperp/norm*prm.value.wci;

%% figure
fpos=[800,200,450,500];
f=figure('Position',fpos);
ha=slj.Plot.subplot(4,1,[0.03,0.1],[0.12,0.02],[0.12,0.03]);

%% part 1, the particle's trajectory
axes(ha(1));
lx=prt.value.time;
% extra.xrange=[lx(1),lx(end)];
ly.l1=prt.value.k;
ly.l2=prt.value.kx;
ly.l3=prt.value.ky;
ly.l4=prt.value.kz;
extra.LineStyle={'-', '-', '-', '-'};
extra.LineColor={'k', 'r', 'b', 'g'};

extra.legend={'K', 'Kx', 'Ky', 'Kz'};
extra.ylabel=['K',spcs];
extra.Location='west';

h=slj.Plot.linen(lx, ly, extra);
set(h,'box','off');
xlim(xrange);
set(gca,'XTicklabel',[]);

axes(ha(2));
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

h=slj.Plot.linen(lx, ly, extra);
extra=rmfield(extra,'Location');
set(h,'box','off');
xlim(xrange);
set(gca,'XTicklabel',[]);

axes(ha(3));
ly=[];
ly.l1=prt.value.vx;
ly.l2=prt.value.vy;
ly.l3=prt.value.vz;
extra.LineStyle={'-', '-', '-'};
extra.LineColor={'r', 'b', 'g'};

extra.legend={'Vx', 'Vy', 'Vz'};
extra.ylabel='Vic';
extra.Location='west';

h=slj.Plot.linen(lx, ly, extra);
extra=rmfield(extra,'Location');
set(h,'box','off');
xlim(xrange);
set(gca,'XTicklabel',[]);

axes(ha(4));
ly=[];
ly.l1=den.x;
ly.l2=den.y;
ly.l3=den.z;
% ly.l4=ly.l1+ly.l2+ly.l3;
% ly.l5=prt.value.k(trange);
extra.LineStyle={'-', '-', '-'};
extra.LineColor={'r', 'b', 'g'};

extra.legend={'\int_0^{ t}qVxEx dt', '\int_0^{ t}qVyEy dt', '\int_0^{ t}qVzEz dt'};
extra.ylabel=['\Delta K',spcs];
extra.Location='northwest';

extra.xlabel='\Omega_{ci}t';

h=slj.Plot.linen(lx, ly, extra);
set(h,'box','off');
xlim(xrange);
set(gca,'FontSize', extra.FontSize);

% ly=[];
% ly.l1=en.epara;
% ly.l2=en.eperp;
% extra.LineStyle={'-', '-'};
% extra.LineColor={'r', 'b'};
% extra.legend={'qV_{||}E_{||}', 'qV_{\perp}E_{\perp}'};
% extra.ylabel=['\Delta K',spcs];
% h=slj.Plot.linen(lx, ly, extra);
% xlim(xrange);
% set(h,'box','off');

cd(outdir);
print('-dpng','-r300','tmp.png');
% close(gcf);


function sfd=smooth1d(lfd)
n=0;
nt=length(lfd);
sfd=lfd;
for i=1:n
    for j=2:nt-1
        sfd(j)=sfd(j-1)*0.25+sfd(j)*0.5+sfd(j+1)*0.25;
    end
end
end
