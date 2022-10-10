% function figure5()
%%
% writen by Liangjin Song on 20210624
% the particle information in the spectrum with high energy
%%
clear;
run('articles.article4.parameters.m');
%% particle's ID
id3='1466770715';

%% particle's time information
tt3=32;

%% figure property
extra.xlabel='X [c/\omega_{pi}]';
extra.ylabel='Z [c/\omega_{pi}]';
extra.FontSize=16;

%% particle's information
% norm=prm.value.tem*prm.value.tle*prm.value.thl/prm.value.coeff;
norm=0.5*prm.value.mi*prm.value.vA.^2;
trange=1:2501;

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
fpos=[1000,100,800,700];
f=figure('Position',fpos);
ha=slj.Plot.subplot(2,2,[0.025,0.12],[0.1,0.4],[0.1,0.1]);

%% part 1, the particle's trajectory
% particle 3
pos=get(ha(1),'Position');
pos(1)=pos(1)+0.13;
pos(2)=pos(2)+0.285;
pos(3)=pos(3)*1.7;
pos(4)=pos(4)*1.7;

axes('Position',pos);
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
xlim([0,52]);
ylim([-10,10]);
xlabel(extra.xlabel);
ylabel(extra.ylabel);
set(gca,'YTickMode','auto');
set(gca,'FontSize',extra.FontSize);

%% particle's trajectory
extra=[];
%% particle 3
cmd='obj.value.rx(2368:end)=obj.value.rx(2368:end)-100;';
prt3=prt3.command(cmd);
particle_information(ha, 1, prt3, den3, trange, extra);
%% save figure
cd(outdir);
print(f,'-dpng','-r300','figure9_1.png');


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

axes(ha(np+1));
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

axes(ha(np+2));
ly=[];
ly.l1=den.x(trange);
ly.l2=den.y(trange);
ly.l3=den.z(trange);
extra.LineStyle={'-', '-', '-'};
extra.LineColor={'r', 'b', 'g'};
extra.legend={'\int_0^{ t}qVxEx dt', '\int_0^{ t}qVyEy dt', '\int_0^{ t}qVzEz dt'};
extra.ylabel='Kic';
extra.Location='northwest';
extra.xlabel='\Omega_{ci}t';
slj.Plot.linen(lx, ly, extra);

axes(ha(np+3));
extra.ylabell='X [c/\omega_{pi}]';
extra.ylabelr='Z [c/\omega_{pi}]';
% extra.yrangel=[40,80];
% extra.yranger=[-1,1];
extra.xlabel='\Omega_{ci}t';
% prt.value.rx(2368:end)=prt.value.rx(2368:end)-100;
slj.Plot.plotyy1(lx, [prt.value.rx(1:2367);prt.value.rx(2368:2501)+100], prt.value.rz(trange), extra);
end