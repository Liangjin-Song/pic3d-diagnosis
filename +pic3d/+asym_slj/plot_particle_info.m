% plot particle information
%%
% writen by Liangjin Song on 20211129
% the particle information in the spectrum at the DF and the second island
%%
clear;
%%
indir='E:\Asym\dst1\data';
outdir='E:\Asym\dst1\out\Kinetic\High_Energy\429334303';
prm=slj.Parameters(indir,outdir);
%% particle's ID
%% id1='295320754';
id = '429334303';
spc='h';
spcs='ic';

xrange=[0,100];

%% figure property
extra.xlabel='X [c/\omega_{pi}]';
extra.ylabel='Z [c/\omega_{pi}]';
extra.ColorbarPosition='north';
extra.FontSize=12;

%% particle's information
% norm=prm.value.tem*prm.value.tle*prm.value.thl/prm.value.coeff;
norm=prm.value.mi*prm.value.vA*prm.value.vA;

% particle
prt=prm.read(['traj',spc,'_id',id]);
den=prt.acceleration_direction(prm);
den.x=den.x/norm;
den.y=den.y/norm;
den.z=den.z/norm;
prt=prt.norm_energy(norm);
prt=prt.norm_electric_field(prm);
prt=prt.norm_velocity(prm);

%% figure
dh=-0.08;

% fpos=[1000,100,800,1000];
f=figure; %('Position',fpos);
ha=slj.Plot.subplot(3,1,[0.03,0.1],[0.16,0.02],[0.12,0.03]);

%% part 1, the particle's trajectory
axes(ha(1));

lx=prt.value.time;
% extra.xrange=[lx(1),lx(end)];
ly.l1=prt.value.k;
ly.l2=prt.value.kx;
ly.l3=prt.value.ky;
ly.l4=prt.value.kz;
extra.LineStyle={'-', '-', '-', '-'};
extra.LineColor={'k', 'r', 'b', 'm'};

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

h=slj.Plot.linen(lx, ly, extra);
set(h,'box','off');
xlim(xrange);
set(gca,'FontSize', extra.FontSize);

cd(outdir);


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
