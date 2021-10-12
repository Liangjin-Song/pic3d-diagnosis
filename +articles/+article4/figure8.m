% function figure3_3()
%% plot the particle's trajectory, power of the electric field
% writen by Liangjin Song on 20210627
%%
clear;
run('articles.article4.parameters.m');
%% the particle's id
id=uint64(1607615077);

%% set the figure
figure1=figure('Position',[500,10,950,700]);
ha=slj.Plot.subplot(2,2,[0.09,0.12],[0.15,0.07],[0.1,0.08]);

%% read the partile data
prt=prm.read(['trajh_id',num2str(id)]);
norm=prm.value.mi*prm.value.vA*prm.value.vA;
prt=prt.norm_energy(norm);

%% the particle's duration
tt=801;
tt0=16;
range=1:1001;
xrange=[0,20];
star=range(1):50:range(end);

%% particle's trajectory
axes(ha(1));
dh=0.05;
extra.xlabel='X [c/\omega_{pi}]';
extra.ylabel='Z [c/\omega_{pi}]';
extra.ColorbarPosition='north';
extra.FontSize=16;
ss=prm.read('stream',tt0);
cr=[0, max(prt.value.k(range))];
slj.Plot.stream(ss,prm.value.lx,prm.value.lz,200);
hold on
p=patch(prt.value.rx(range),prt.value.rz(range),[prt.value.k(range(1:end-1));NaN],'edgecolor','flat','facecolor','none');
caxis(cr);
colormap('jet');
cb=colorbar('North');
% cb.Label.String='K_{ic}';
cb.Label.FontSize=extra.FontSize;
pos=get(cb,'Position');
pos(2)=pos(2)+dh;
set(cb,'Position',pos);
set(cb,'AxisLocation','out');
xlim([49,51]);
ylim([-0.5,0.5]);
set(p,'LineWidth',3);
xlabel(extra.xlabel);
ylabel(extra.ylabel);
set(gca,'FontSize',extra.FontSize);


%% vy-vz
vA=prm.value.vA;
vy=prt.value.vy/vA;
vz=prt.value.vz/vA;
axes(ha(3));
p=patch(vy(range),vz(range),[prt.value.k(range(1):range(end-1)); NaN],'edgecolor','flat','facecolor','none');
xtick=-0.2:0.2:0.6;
xtkble={'-0.2','0','0.2','0.4','0.6'};
ytick=-0.9:0.3:0.9;
ytkble={'-0.9','-0.6','-0.3','0','0.3','0.6','0.9'};
set(gca,'XTick',xtick,'Xticklabel',xtkble);
set(gca,'YTick',ytick,'Yticklabel',ytkble);
colormap('jet');
set(p,'LineWidth',3);
cb=colorbar;
% cb.Label.String='K_{ic}';
cb.Label.FontSize=extra.FontSize;
caxis([0,max(prt.value.k(range))]);
hold on
plot(vy(star),vz(star),'*k','LineWidth',8);
plot(vy(tt),vz(tt),'*r','LineWidth',8); % distribution position
plot(vy(star(1)),vz(star(1)),'*g','LineWidth',8); % begin
plot(vy(star(end)),vz(star(end)),'*b','LineWidth',8); % end
hold off
xlabel('Vic_y');
ylabel('Vic_z');
set(gca,'FontSize',extra.FontSize);

%% ry-rz
vy=(vy(1:end-1)+vy(2:end))/2;

%% y position
nvy=length(vy);
ry=zeros(nvy+1,1);
for i=1:nvy
    ry(i+1)=ry(i)+vy(i)*0.02;
end

%% y-z trajectory
axes(ha(4));
p=patch(ry(range),prt.value.rz(range),[prt.value.k(range(1):range(end-1)); NaN],'edgecolor','flat','facecolor','none');

colormap('jet');
set(p,'LineWidth',3);
cb=colorbar;
% cb.Label.String='K_{ic}';
cb.Label.FontSize=extra.FontSize;
caxis([0,max(prt.value.k(range))]);
xtick=0:1:3;
xtkble={'0','1','2','3'};
ytick=-1:0.5:2;
ytkble={'-1','-0.5','0','0.5','1','1.5','2'};
set(gca,'XTick',xtick,'Xticklabel',xtkble);
set(gca,'YTick',ytick,'Yticklabel',ytkble);
hold on;
plot(ry(star),prt.value.rz(star),'*k','LineWidth',8);
plot(ry(tt),prt.value.rz(tt),'*r','LineWidth',8);
plot(ry(star(1)),prt.value.rz(star(1)),'*g','LineWidth',8); % begin
plot(ry(star(end)),prt.value.rz(star(end)),'*b','LineWidth',8); % end
hold off
xlabel('Y [c/\omega_{pi}]');
ylabel('Z [c/\omega_{pi}]');
set(gca,'FontSize',extra.FontSize);


%% the power of the electric field
den=prt.acceleration_direction(prm);
den.x=den.x/norm;
den.y=den.y/norm;
den.z=den.z/norm;
ly.l1=prt.value.k(range);
ly.l2=den.x(range);
ly.l3=den.y(range);
ly.l4=den.z(range);
extra.LineStyle={'-', '-', '-', '-'};
extra.LineColor={'k', 'r', 'b', 'g'};
extra.legend={'K', '\int_0^{ t}qVxEx dt', '\int_0^{ t}qVyEy dt', '\int_0^{ t}qVzEz dt'};
extra.ylabel='Kic';
extra.Location='northwest';
extra.xlabel='\Omega_{ci}t';
axes(ha(2));
slj.Plot.linen(prt.value.time(range), ly, extra);
legend1 = legend(ha(2),'show');
set(legend1,...
    'Position',[0.599649122807018 0.66261905820478 0.152631575998507 0.206428565510682]);

%% text box
annotation(figure1,'textbox',...
    [0.0536842105263158 0.893285715435232 0.0594736827517811 0.0528571417076248],...
    'String',{'(a)'},...
    'LineStyle','none',...
    'FontSize',18,...
    'FontName','Times New Roman');

annotation(figure1,'textbox',...
    [0.567368421052632 0.880428572578089 0.0605263142993576 0.0528571417076248],...
    'String',{'(b)'},...
    'LineStyle','none',...
    'FontSize',18,...
    'FontName','Times New Roman');

annotation(figure1,'textbox',...
    [0.0968421052631579 0.446142858292375 0.0594736827517811 0.0528571417076247],...
    'String',{'(c)'},...
    'LineStyle','none',...
    'FontSize',18,...
    'FontName','Times New Roman');

annotation(figure1,'textbox',...
    [0.569473684210526 0.449000001149518 0.0605263142993576 0.0528571417076247],...
    'String',{'(d)'},...
    'LineStyle','none',...
    'FontSize',18,...
    'FontName','Times New Roman');

%% save the figure
cd(outdir);
print(figure1,'-dpng','-r300','figure8.png');
print(figure1,'-depsc','figure8.eps');