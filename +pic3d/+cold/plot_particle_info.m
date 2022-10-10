% plot particle information
%%
% writen by Liangjin Song on 20211129
% the particle information in the spectrum at the DF and the second island
%%
clear;
%%
indir='E:\PIC\Cold-Ions\mie100\data';
outdir='E:\PIC\Cold-Ions\mie100\out\Hot_ion\DF';
prm=slj.Parameters(indir,outdir);
%% particle's ID
%% id1='295320754';
id = '4756983';
spc='l';

%% particle's time information
tt=32;

%% figure property
extra.xlabel='X [c/\omega_{pi}]';
extra.ylabel='Z [c/\omega_{pi}]';
extra.ColorbarPosition='north';
extra.FontSize=12;

%% particle's information
% norm=prm.value.tem*prm.value.tle*prm.value.thl/prm.value.coeff;
norm=0.5*prm.value.mi*prm.value.vA.^2;
trange=1:2020;

% particle 1
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

fpos=[1000,100,800,1000];
f=figure('Position',fpos);
ha=slj.Plot.subplot(5,1,[0.02,0.1],[0.09,0.05],[0.09,0.1]);

%% part 1, the particle's trajectory
axes(ha(1));
ss=prm.read('stream',tt);
cr=[0, max(prt.value.k(trange))];
slj.Plot.stream(ss,prm.value.lx,prm.value.lz,20);
hold on
p1=patch(prt.value.rx,prt.value.rz,[prt.value.k(1:end-1);NaN],'edgecolor','flat','facecolor','none');
set(p1,'LineWidth',2);
% p2=patch(prt.value.rx(2135:2501),prt.value.rz(2135:2501),[prt.value.k(2135:2500);NaN],'edgecolor','flat','facecolor','none');

% set(p2,'LineWidth',2);

hbar=colorbar;
caxis(cr);
colormap('jet');
% pos=get(hbar,'Position');
% pos(2)=pos(2)+dh;
% set(hbar,'Position',pos);
% set(hbar,'AxisLocation','out');
xlim([0,100]);
ylim([-10,10]);
xlabel(extra.xlabel);
ylabel(extra.ylabel);
set(gca,'FontSize',extra.FontSize);


extra=[];
extra.xrange=[20,40];
particle_information(ha, prt, den, trange, spc, extra);


%%
function particle_information(ha, prt, den, trange, spc, extra)
lx=prt.value.time(trange);
% extra.xrange=[lx(1),lx(end)];
axes(ha(2));
ly.l1=prt.value.k(trange);
ly.l2=prt.value.kx(trange);
ly.l3=prt.value.ky(trange);
ly.l4=prt.value.kz(trange);
extra.LineStyle={'-', '-', '-', '-'};
extra.LineColor={'k', 'r', 'b', 'm'};

extra.legend={'K', 'Kx', 'Ky', 'Kz'};
extra.ylabel=['K',spc];
extra.Location='west';

h=slj.Plot.linen(lx, ly, extra);
set(h,'box','off');
set(gca,'XTicklabel',[]);

axes(ha(3));
ly=[];
ly.l1=den.x(trange);
ly.l2=den.y(trange);
ly.l3=den.z(trange);
% ly.l4=ly.l1+ly.l2+ly.l3;
% ly.l5=prt.value.k(trange);
extra.LineStyle={'-', '-', '-'};
extra.LineColor={'r', 'b', 'g'};

extra.legend={'\int_0^{ t}qVxEx dt', '\int_0^{ t}qVyEy dt', '\int_0^{ t}qVzEz dt'};
extra.ylabel=['K',spc];
extra.Location='northwest';

h=slj.Plot.linen(lx, ly, extra);
set(h,'box','off');
set(gca,'XTicklabel',[]);

axes(ha(4));
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

h=slj.Plot.linen(lx, ly, extra);
extra=rmfield(extra,'Location');
set(h,'box','off');
set(gca,'XTicklabel',[]);

axes(ha(5));
extra.ylabell='X [c/\omega_{pi}]';
extra.ylabelr='Z [c/\omega_{pi}]';
extra.xlabel='\Omega_{ci}t';
slj.Plot.plotyy1(lx, prt.value.rx(trange), prt.value.rz(trange), extra);
end

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
