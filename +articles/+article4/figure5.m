% function figure5()
%%
% writen by Liangjin Song on 20210624
% the particle information in the spectrum with high energy
%%
clear;
run('articles.article4.parameters.m');
%% particle's ID
%% id3='1479944291';
id3='1575474944';

%% particle's time information
tt3=30;

%% figure property
extra.xlabel='X [c/\omega_{pi}]';
extra.ylabel='Z [c/\omega_{pi}]';
extra.FontSize=12;
extra.ColorbarPosition='north';

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
dh=0.028;
daxs=0.05;
fpos=[1000,10,600,1000];
figure1=figure('Position',fpos);
ha=slj.Plot.subplot(5,1,[0.013,0.12],[0.1,0.1],[0.15,0.15]);

%% part 1, the particle's trajectory
% % particle 3
% pos=get(ha(1),'Position');
% pos(1)=pos(1)+0.13;
% pos(2)=pos(2)+0.285;
% pos(3)=pos(3)*1.7;
% pos(4)=pos(4)*1.7;

% axes('Position',pos);
axes(ha(1));
ss=prm.read('stream',tt3);
cr=[0, max(prt3.value.k(trange))];
slj.Plot.stream(ss,prm.value.lx,prm.value.lz);
hold on
p=patch(prt3.value.rx(1:2134),prt3.value.rz(1:2134),[prt3.value.k(1:2133);NaN],'edgecolor','flat','facecolor','none');
set(p,'LineWidth',3);
p=patch(prt3.value.rx(2135:trange(end)),prt3.value.rz(2135:trange(end)),[prt3.value.k(2135:trange(end-1));NaN],'edgecolor','flat','facecolor','none');
set(p,'LineWidth',3);
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


xlim([30,52]);
ylim([-5,5]);
xlabel(extra.xlabel);
ylabel(extra.ylabel);
set(gca,'YTickMode','auto');
set(gca,'FontSize',extra.FontSize);

%% particle's trajectory
extra=[];
extra.FontSize=12;
extra.xrange=[5,35];
%% particle 3
cmd='obj.value.rx(2135:end)=obj.value.rx(2135:end)-100;';
prt3=prt3.command(cmd);
particle_information(ha, 2, prt3, den3, trange, extra);

%% text box
annotation(figure1,'textbox',...
    [0.126666666666667 0.952000000804663 0.0941666643569868 0.0369999991953374],...
    'String',{'(a)'},...
    'LineStyle','none',...
    'FontSize',18,...
    'FontName','Times New Roman');
annotation(figure1,'textbox',...
    [0.051666666666667 0.718000000804663 0.0958333309739829 0.0369999991953374],...
    'String',{'(b)'},...
    'LineStyle','none',...
    'FontSize',18,...
    'FontName','Times New Roman');
annotation(figure1,'textbox',...
    [0.051666666666667 0.555000000804663 0.0941666643569868 0.0369999991953374],...
    'String',{'(c)'},...
    'LineStyle','none',...
    'FontSize',18,...
    'FontName','Times New Roman');
annotation(figure1,'textbox',...
    [0.0500000000000002 0.391000000804663 0.0958333309739829 0.0369999991953373],...
    'String',{'(d)'},...
    'LineStyle','none',...
    'FontSize',18,...
    'FontName','Times New Roman');
annotation(figure1,'textbox',...
    [0.0500000000000003 0.227000000804663 0.0941666643569867 0.0369999991953373],...
    'String',{'(e)'},...
    'LineStyle','none',...
    'FontSize',18,...
    'FontName','Times New Roman');

%% save figure
cd(outdir);
print(figure1,'-dpng','-r300','figure5.png');
print(figure1,'-depsc','figure5.eps');


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
h=slj.Plot.linen(lx, ly, extra);
set(h,'box','off');
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
h=slj.Plot.linen(lx, ly, extra);
set(h,'box','off');
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
% extra.xlabel='\Omega_{ci}t';
h=slj.Plot.linen(lx, ly, extra);
set(h,'box','off');
set(gca,'XTicklabel',[]);

axes(ha(np+3));
extra.ylabell='X [c/\omega_{pi}]';
extra.ylabelr='Z [c/\omega_{pi}]';
extra.yrangel=[25,52];
% extra.yranger=[-1,1];
extra.xlabel='\Omega_{ci}t';
% prt.value.rx(2368:end)=prt.value.rx(2368:end)-100;
slj.Plot.plotyy1(lx, prt.value.rx(trange), prt.value.rz(trange), extra);
end